#!/usr/bin/env python3
"""
notify.py

Usage:
  ./notify.py nmap -sV 192.168.29.1

Requirements:
  pip3 install -r requirements.txt
  (requirements.txt contains: requests)

Behavior:
  - Runs nmap with the args you pass.
  - Streams nmap output live to the terminal.
  - Forces XML output (temp file) unless you specify -oX / --output-xml.
  - Parses XML after the run and posts a compact embed to the Discord webhook.
"""

import os
import sys
import shutil
import subprocess
import tempfile
import xml.etree.ElementTree as ET
import requests
from datetime import datetime

# ---------- CONFIG ----------
# Hard-coded webhook (you gave this). If you want to override via env:
WEBHOOK = os.environ.get("DISCORD_WEBHOOK_URL") or \
    "https://discord.com/api/webhooks/1417103632679174164/9wp3dsl5b_-PWYXxlUG_onLEJEfXJ5PuZXSkXahlCl6OIguZRFL1Ifluz8xS_e6fFvHK"

if not WEBHOOK.strip():
    print("ERROR: Discord webhook URL is empty.", file=sys.stderr)
    sys.exit(1)
# ----------------------------

def prepare_nmap_args(user_args):
    # user_args: list (without leading 'nmap')
    # Detect if user specified -oX / --output-xml
    has_oX = any(a == "-oX" or a == "--output-xml" for a in user_args)
    tmp_xml = None
    args = list(user_args)
    if not has_oX:
        tmp = tempfile.NamedTemporaryFile(prefix="nmap_", suffix=".xml", delete=False)
        tmp.close()
        tmp_xml = tmp.name
        args += ["-oX", tmp_xml]
    else:
        # find the provided xml file if any
        xmlfile = None
        for i, a in enumerate(args):
            if a == "-oX" or a == "--output-xml":
                if i+1 < len(args):
                    xmlfile = args[i+1]
                break
        tmp_xml = xmlfile
    return args, tmp_xml

def stream_run(cmd):
    """
    Run command with Popen, stream stdout+stderr to terminal in real-time,
    and also capture into a buffer for later parsing / sending.
    Returns (returncode, captured_output_string)
    """
    try:
        proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, bufsize=1)
    except Exception as e:
        print("Failed to execute:", e, file=sys.stderr)
        return 2, ""

    captured_lines = []
    try:
        # iterate lines as they appear
        with proc.stdout:
            for line in iter(proc.stdout.readline, ""):
                if line == "":
                    break
                # Print live to terminal
                print(line, end="")
                captured_lines.append(line)
        proc.wait()
    except KeyboardInterrupt:
        # If user interrupts, kill child and propagate
        try:
            proc.kill()
        except Exception:
            pass
        print("\n[Interrupted by user]", file=sys.stderr)
        return proc.returncode or 130, "".join(captured_lines)

    return proc.returncode, "".join(captured_lines)

def parse_nmap_xml(xml_path):
    if not xml_path or not os.path.exists(xml_path):
        return []

    try:
        tree = ET.parse(xml_path)
    except Exception as e:
        print("Failed to parse nmap xml:", e, file=sys.stderr)
        return []

    root = tree.getroot()
    hosts = []
    for host in root.findall("host"):
        h = {}
        addrs = []
        for addr in host.findall("address"):
            addrs.append({"addr": addr.get("addr"), "type": addr.get("addrtype")})
        h["addresses"] = addrs

        hostnames = []
        hn = host.find("hostnames")
        if hn is not None:
            for hostname in hn.findall("hostname"):
                hostnames.append(hostname.get("name"))
        h["hostnames"] = hostnames

        ports = []
        ports_el = host.find("ports")
        if ports_el is not None:
            for port in ports_el.findall("port"):
                portid = port.get("portid")
                proto = port.get("protocol")
                state_el = port.find("state")
                state = state_el.get("state") if state_el is not None else "unknown"
                service_el = port.find("service")
                service_name = service_el.get("name") if service_el is not None else None
                product = service_el.get("product") if service_el is not None else None
                version = service_el.get("version") if service_el is not None else None
                ports.append({
                    "port": portid,
                    "proto": proto,
                    "state": state,
                    "service": service_name,
                    "product": product,
                    "version": version
                })
        h["ports"] = ports
        hosts.append(h)
    return hosts

def build_discord_embed(cmd, returncode, captured_snippet, hosts, xml_path):
    title = "Nmap scan finished"
    description = f"Command: `{' '.join(cmd)}`\nReturn code: {returncode}\nXML: `{xml_path or 'N/A'}`"
    fields = []

    # targets
    all_addrs = []
    for h in hosts:
        for a in h["addresses"]:
            all_addrs.append(a["addr"])
    unique_addrs = sorted(set(all_addrs))
    fields.append({"name": "Targets", "value": ", ".join(unique_addrs) if unique_addrs else "N/A", "inline": True})

    open_count = sum(1 for h in hosts for p in h["ports"] if p["state"] == "open")
    fields.append({"name": "Open ports (total)", "value": str(open_count), "inline": True})

    # host summaries (first 6)
    host_lines = []
    for h in hosts[:6]:
        addr_str = ", ".join(a["addr"] for a in h["addresses"]) or "N/A"
        hn = f" ({', '.join(h['hostnames'])})" if h["hostnames"] else ""
        open_ports = [f"{p['port']}/{p['proto']} {p['service'] or ''}{' '+p['version'] if p.get('version') else ''}".strip()
                      for p in h["ports"] if p["state"] == "open"]
        ports_str = ", ".join(open_ports) if open_ports else "no open ports"
        host_lines.append(f"**{addr_str}**{hn}\n{ports_str}")

    fields.append({"name": "Host summaries (first 6)", "value": "\n\n".join(host_lines) if host_lines else "No hosts found", "inline": False})

    # snippet (trim to avoid too large messages)
    snippet = (captured_snippet or "").strip()
    if len(snippet) > 900:
        snippet = snippet[:900] + "... (truncated)"
    if snippet:
        fields.append({"name": "nmap output (snippet)", "value": snippet, "inline": False})

    embed = {
        "title": title,
        "description": description,
        "timestamp": datetime.utcnow().isoformat(),
        "fields": fields,
        "footer": {"text": "notify.py"}
    }
    return embed

def post_webhook(embed):
    payload = {"embeds": [embed]}
    headers = {"Content-Type": "application/json"}
    try:
        r = requests.post(WEBHOOK, json=payload, headers=headers, timeout=15)
        r.raise_for_status()
        return True
    except Exception as e:
        print("Failed to post webhook:", e, file=sys.stderr)
        return False

def main():
    if len(sys.argv) < 2:
        print("Usage: notify.py nmap <nmap args...>", file=sys.stderr)
        sys.exit(1)

    if sys.argv[1] != "nmap":
        print("WARNING: script expects 'nmap' as the first argument; passing the rest to nmap anyway.", file=sys.stderr)

    # Build nmap args (without leading 'nmap')
    user_args = sys.argv[2:] if sys.argv[1] == "nmap" else sys.argv[1:]
    if not user_args:
        print("No nmap arguments provided.", file=sys.stderr)
        sys.exit(1)

    args_to_run, xml_path = prepare_nmap_args(user_args)

    nmap_bin = shutil.which("nmap")
    if not nmap_bin:
        print("ERROR: nmap not found in PATH.", file=sys.stderr)
        sys.exit(1)

    cmd = [nmap_bin] + args_to_run
    print("[*] Running:", " ".join(cmd))
    returncode, captured = stream_run(cmd)

    # parse xml if exists
    hosts = parse_nmap_xml(xml_path)
    embed = build_discord_embed(cmd, returncode, captured, hosts, xml_path)
    sent = post_webhook(embed)
    if sent:
        print("[*] Discord webhook sent.")
    else:
        print("[!] Failed to send Discord webhook.", file=sys.stderr)

    # cleanup if we created the xml in tmpdir
    try:
        tmpdir = tempfile.gettempdir()
        if xml_path and xml_path.startswith(tmpdir) and os.path.exists(xml_path):
            os.unlink(xml_path)
    except Exception:
        pass

    sys.exit(returncode if returncode is not None else 0)

if __name__ == "__main__":
    main()
