#!/usr/bin/env python3
import os
import re
import shlex
import asyncio
import tempfile
import ipaddress
from pathlib import Path

import discord
from discord import File
from dotenv import load_dotenv

# Load .env (optional)
load_dotenv()

TOKEN = os.getenv("DISCORD_BOT_TOKEN")
CHANNEL_ID = int(os.getenv("DISCORD_CHANNEL_ID", "0"))  # optional: restrict to a channel
ALLOWED_ROLE_ID = os.getenv("ALLOWED_ROLE_ID")  # optional: restrict by role id (string)
TIMEOUT = int(os.getenv("NMAP_TIMEOUT", "120"))  # seconds
MAX_OUTPUT_CHARS = int(os.getenv("MAX_OUTPUT_CHARS", "1800"))

if not TOKEN:
    raise SystemExit("Set DISCORD_BOT_TOKEN in environment or .env")

intents = discord.Intents.default()
intents.message_content = True
client = discord.Client(intents=intents)


# Basic validators
HOSTNAME_RE = re.compile(r"^[A-Za-z0-9.-]{1,253}$")
PORTS_RE = re.compile(r"^(\d+(-\d+)?)(,(\d+(-\d+)?))*$")  # e.g. 22,80,1-1024

def is_valid_target(t: str) -> bool:
    t = t.strip()
    # try IP or CIDR
    try:
        if '/' in t:
            ipaddress.ip_network(t, strict=False)
            return True
        ipaddress.ip_address(t)
        return True
    except ValueError:
        pass
    # basic hostname check
    if HOSTNAME_RE.match(t):
        # reject things with spaces or suspicious chars
        if '..' in t or t.startswith('-') or t.endswith('-'):
            return False
        return True
    return False

def is_valid_ports(p: str) -> bool:
    return bool(PORTS_RE.match(p))


async def run_nmap_cmd(cmd_list, timeout=TIMEOUT):
    """Run the nmap command using asyncio subprocess and return stdout/stderr."""
    proc = await asyncio.create_subprocess_exec(
        *cmd_list,
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.STDOUT
    )
    try:
        out, _ = await asyncio.wait_for(proc.communicate(), timeout=timeout)
    except asyncio.TimeoutError:
        proc.kill()
        await proc.communicate()
        return None, "Timed out"
    return out.decode(errors="ignore"), None


def build_nmap_args(target: str, scan_type: str = None, ports: str = None):
    args = ["nmap", "-Pn"]  # -Pn: don't ping by default to avoid issues
    # scan type mapping
    if scan_type == "quick":
        args.extend(["-T4", "-F"])
    elif scan_type == "service":
        args.append("-sV")
    elif scan_type == "os":
        args.append("-O")
    elif scan_type == "all":
        args.append("-A")
    # ports
    if ports:
        args.extend(["-p", ports])
    # target
    args.append(target)
    return args


def parse_command_content(content: str):
    """
    Expected format:
    !nmap <target> [--type TYPE] [--ports PORTS]
    returns dict or (None, error)
    """
    parts = shlex.split(content)
    if len(parts) < 2:
        return None, "Usage: !nmap <target> [--type TYPE] [--ports PORTS]"

    target = parts[1]
    scan_type = None
    ports = None

    i = 2
    while i < len(parts):
        p = parts[i]
        if p in ("--type", "--scan-type") and i + 1 < len(parts):
            scan_type = parts[i+1].lower()
            i += 2
        elif p == "--ports" and i + 1 < len(parts):
            ports = parts[i+1]
            i += 2
        else:
            # unknown/extra token
            return None, f"Unknown argument or malformed command: {p}"
    # validate
    if not is_valid_target(target):
        return None, "Invalid target format. Accepts IPv4/IPv6/CIDR or simple hostname."

    allowed_types = {"quick", "service", "os", "all", None}
    if scan_type not in allowed_types:
        return None, f"Invalid scan type. Allowed: quick, service, os, all."

    if ports and not is_valid_ports(ports):
        return None, "Invalid ports format. Use 80,443 or 1-1024 or comma separated list."

    return {"target": target, "type": scan_type, "ports": ports}, None


@client.event
async def on_ready():
    print(f"Logged in as {client.user} (id: {client.user.id})")
    print("Bot is ready.")


@client.event
async def on_message(message: discord.Message):
    # ignore self
    if message.author == client.user:
        return

    if not message.content.startswith("!nmap"):
        return

    # Optional: restrict to a channel
    if CHANNEL_ID and message.channel.id != CHANNEL_ID:
        return

    # Optional: restrict by role
    if ALLOWED_ROLE_ID:
        role_ids = [str(r.id) for r in message.author.roles]
        if ALLOWED_ROLE_ID not in role_ids:
            await message.reply("You are not authorized to use this command.")
            return

    await message.channel.typing()
    parsed, err = parse_command_content(message.content)
    if err:
        await message.reply(f"Error: {err}")
        return

    target = parsed["target"]
    scan_type = parsed["type"]
    ports = parsed["ports"]

    # Build and run
    cmd = build_nmap_args(target, scan_type, ports)
    # Safety: do not run as root automatically. Warn if running as root.
    if os.geteuid() == 0:
        await message.reply("Warning: bot is running as root. It's safer to run it as a non-root user.")
    # Run nmap
    try:
        stdout, timeout_err = await run_nmap_cmd(cmd)
    except Exception as e:
        await message.reply(f"Execution error: {e}")
        return

    if timeout_err:
        await message.reply(f"Nmap timed out after {TIMEOUT} seconds.")
        return

    if not stdout:
        await message.reply("No output from nmap.")
        return

    if len(stdout) > MAX_OUTPUT_CHARS:
        # write to tempfile and send as file
        tf = tempfile.NamedTemporaryFile(prefix="nmap_", suffix=".txt", delete=False)
        tf.write(stdout.encode(errors="ignore"))
        tf.flush()
        tf.close()
        try:
            await message.reply("Output too long — sending as a file:", file=File(tf.name))
        finally:
            try:
                Path(tf.name).unlink()  # attempt cleanup
            except Exception:
                pass
    else:
        # wrap in code block
        await message.reply(f"```text\n{stdout}\n```")


if __name__ == "__main__":
    client.run(TOKEN)
