#!/usr/bin/env python3
import subprocess
import requests
import sys

# Replace with your Discord webhook URL
WEBHOOK_URL = "https://discord.com/api/webhooks/XXXXXXXXX/XXXXXXXXX"

def get_ufw_status():
    try:
        # Run 'ufw status verbose' command
        result = subprocess.run(
            ["ufw", "status", "verbose"],
            capture_output=True,
            text=True,
            check=True
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        return f"Error getting UFW status: {e}"

def send_to_discord(message):
    payload = {"content": f"```bash\n{message}\n```"}
    try:
        response = requests.post(WEBHOOK_URL, json=payload)
        if response.status_code == 204:
            print("✅ Sent to Discord successfully")
        else:
            print(f"⚠️ Failed to send: {response.status_code} {response.text}")
    except Exception as e:
        print(f"❌ Error sending to Discord: {e}")

if __name__ == "__main__":
    if not WEBHOOK_URL:
        print("ERROR: Set your Discord webhook URL in the script.", file=sys.stderr)
        sys.exit(1)

    ufw_output = get_ufw_status()
    print("UFW Status:\n", ufw_output)  # Also show in terminal
    send_to_discord(ufw_output)
