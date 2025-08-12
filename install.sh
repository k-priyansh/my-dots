#!/bin/bash
# Check for root/sudo access
if [[ "$EUID" -ne 0 ]]; then
    echo "┌────────────────────────────────────────────────────────────────────────────┐"
    echo "│         [+] Please run as root (e.g., sudo ./flatpak-installer.sh)         │"
    echo "└─────────────────────────────────────────────────────────────────────╴ marine"
    exit 1
fi

#! >>> Flathub Setup
# Install flatpak if missing
install_flatpak() {
    if ! command -v flatpak &> /dev/null; then
        echo "┌───────────────────────────────┐"
        echo "│   [+] Installing Flatpak...   │"
        echo "└────────────────────────╴ marine"
        if command -v apt &> /dev/null; then
            apt update && apt install -y flatpak
        elif command -v dnf &> /dev/null; then
            dnf install -y flatpak
        elif command -v pacman &> /dev/null; then
            pacman -Sy flatpak --noconfirm
        else
            echo "[-] Unsupported package manager. Install Flatpak manually."
            exit 1
        fi
    else
        echo "[✓] Flatpak is already installed."
    fi
}

# Setup flathub repo
setup_flathub() {
    if ! flatpak remotes | grep -q flathub; then
        echo "┌───────────────────────────┐"
        echo "│   [+] Adding Flatpak...   │"
        echo "└────────────────────╴ marine"
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    else
        echo "[✓] Flathub already exists."
    fi
}

#! >>> Installing Essential Depedencies
# Load app list from external file
if [[ -f "applications/essentialapps.sh" ]]; then
    source ./applications/essentialapps.sh
else
    echo "┌──────────────────────────────────────────────────────────────────────────────────────────────────────────┐"
    echo "│         [-] applications/essentialapps.sh not found. Please create the file with a list of apps.         │"
    echo "└───────────────────────────────────────────────────────────────────────────────────────────────────╴ marine"
    exit 1
fi

# Install Depedencies
install_depedencies_apps() {
    for app in "${depedencies_apps[@]}"; do
        echo "┌─────────────────────────────────┐"
        echo "│   [+] Installing Dependencies   │"
        echo "└──────────────────────────╴ marine"
        echo "[+] Updating $app..."
        sudo apt install -y "$app"
	    clear
    done
}

#! >>> Installing Applications
# Load app list from external file
if [[ -f "applications/apps.sh" ]]; then
    source ./applications/essentialapps.sh
else
    echo "┌─────────────────────────────────────────────────────────────────────────────────────────────────┐"
    echo "│         [-] applications/apps.sh not found. Please create the file with a list of apps.         │"
    echo "└──────────────────────────────────────────────────────────────────────────────────────────╴ marine"
    exit 1
fi

install_applications() {
    for app in "${mine_apps[@]}"; do
        echo "┌─────────────────────────────────┐"
        echo "│   [+] Installing Applications   │"
        echo "└──────────────────────────╴ marine"
        echo "[+] Updating $app..."
        sudo apt install -y "$app"
	    clear
    done

}

#! >>> Installing Flatpak Applications
# Load app list from external file
if [[ -f "applications/flatpakapps.sh" ]]; then
    source ./applications/essentialapps.sh
else
    echo "┌────────────────────────────────────────────────────────────────────────────────────────────────────────┐"
    echo "│         [-] applications/flatpakapps.sh not found. Please create the file with a list of apps.         │"
    echo "└─────────────────────────────────────────────────────────────────────────────────────────────────╴ marine"
    exit 1
fi
# Install flatpak apps
install_flatpak_apps() {
    for app in "${flatpak_apps[@]}"; do
        if flatpak list --app | grep -q "$app"; then
            echo "[=] $app is already installed."
        else
            echo "[+] Installing $app..."
            echo "┌─────────────────────────────────┐"
            echo "│   [+] Installing Flatpak Apps   │"
            echo "└──────────────────────────╴ marine"
            flatpak install -y flathub "$app"
	    clear
        fi
    done
}

#! >>> Installing Applications
# installing zed editor
install_zed() {
    echo "┌───────────────────────────────┐"
    echo "│   [+] Installing Zed Editor   │"
    echo "└────────────────────────╴ marine"
    curl -f https://zed.dev/install.sh | sh
    clear
}

# installing wezterm terminal
install_wezterm(){
    echo "┌─────────────────────────────────────┐"
    echo "│   [+] Installing Wezterm Terminal   │"
    echo "└──────────────────────────────╴ marine"    
    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
    sudo apt update -y
    sudo apt install -y wezterm
}

# install brave browser
install_brave(){
    echo "┌──────────────────────────────────┐"
    echo "│   [+] Installing Brave Browser   │"
    echo "└───────────────────────────╴ marine"
    curl -fsS https://dl.brave.com/install.sh | sh
    clear
}

# install spotify
install_spotify(){
    echo "┌────────────────────────────┐"
    echo "│   [+] Installing Spotify   │"
    echo "└────────────────────── marine"
    curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update && sudo apt-get install spotify-client
    clear
}

# Installing ngrok
install_ngrok() {
    echo "┌──────────────────────────┐"
    echo "│   [+] Installing NGROK   │"
    echo "└───────────────────╴ marine"
    curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
    | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
    && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
    | sudo tee /etc/apt/sources.list.d/ngrok.list \
    && sudo apt update \
    && sudo apt install ngrok
}

# installing sublime
install_sublime() {
    echo "┌─────────────────────────────────┐"
    echo "│   [+] Installing Sublime Text   │"
    echo "└──────────────────────────╴ marine"
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt-get update
    sudo apt-get install sublime-text
    clear
}


#! >>> Installing Docker
# Installing Docker
install_docker_apps(){
    echo "┌──────────────────────────────┐"
    echo "│   [+] Updating Docker Apps   │"
    echo "└───────────────────────╴ marine"
    sudo apt install -y docker.io docker-compose
    clear
}

#! >>> Establishing Permissions
# Load app list from external file
if [[ -f "applications/permissions.sh" ]]; then
    source ./applications/essentialapps.sh
else
    echo "┌────────────────────────────────────────────────────────────────────────────────────────────────────────┐"
    echo "│         [-] applications/permissions.sh not found. Please create the file with a list of apps.         │"
    echo "└─────────────────────────────────────────────────────────────────────────────────────────────────╴ marine"
    exit 1
fi

# Enabling Services
start_app_services(){
    for app in "${app_permissions[@]}"; do
        echo "┌────────────────────────────────────┐"
        echo "│   [+] Enabling System Services..   │"
        echo "└─────────────────────────────╴ marine"
        echo "[+] Enabling $app_permission..."
        sudo "$app_permission"
        clear
    done
}


#! >>> Creating Docker Containers
# docker containers
create_containers(){
    echo "┌────────────────────────────────────┐"
    echo "│   [+] Creating Docker Containers   │"
    echo "└─────────────────────────────╴ marine"

    # Container number 01 : portainer - browser based docker gui
    sudo docker volume create portainer_data # Docker Volume
    sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.9.3
    sudo docker run -d -p 9001:9001 --name portainer_agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:2.9.3

    # Container number 02 : kalilinux/Rolling
    # sudo docker volume create bugbounty
    # sudo docker run -d -p 8001:8001 -p 9445:9445 --name kalilinux --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v bugboounty:/data kalilinux/kali-rolling
    # sudo docker run -d --name kalilinux --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v bugboounty:/data kalilinux/kali-rolling

    # Use a proxy server to access these containers
    # In your browser, go to https://localhost:8000 or https://localhost:9443 (depending on your portainer configuration)
    # Follow the instructions to configure your proxy server
}

#! >>> Configuring Firewall
# Load app list from external file
if [[ -f "firewall_rules.sh" ]]; then
    source ./firewall_rules.sh
else
    echo "┌──────────────────────────────────────────────────────────────────────────────────────────────┐"
    echo "│         [-] firewall_rules.sh not found. Please create the file with a list of apps.         │"
    echo "└───────────────────────────────────────────────────────────────────────────────────────╴ marine"
    exit 1
fi

# Setup firewall
setup_firewall(){
    echo "┌─────────────────────────┐"
    echo "│   [+] Securing System   │"
    echo "└──────────────────╴ marine"

    for wallrule in "${firerules[@]}"; do
        echo "┌─────────────────────────────────┐"
        echo "│   [+] Installing Dependencies   │"
        echo "└──────────────────────────╴ marine"
        echo "[+] Updating $wallrule..."
        sudo ufw "$wallrule"
	    clear
    done
}



openvas_setup() {
  echo "┌─────────────────────────────────┐"
  echo "│   [+] Installing OpenVAS Tool   │"
  echo "└──────────────────────────╴ marine"
  sudo apt update
  sudo apt install -y openvas
  sudo gvm-setup
  sudo gvm-check-setup
  sudo gvm-start
  google-chrome https://127.0.0.1:9392
  sudo greenbone-nvt-sync
  sudo greenbone-scapdata-sync
  sudo greenbone-certdata-sync
}

anonymity_setup() {
  echo "┌──────────────────────────────────┐"
  echo "│   [+] Installing Anonymity App   │"
  echo "└───────────────────────────╴ marine"
  sudo systemctl start tor
  sudo systemctl enable tor
  systemctl status tor
}

proxychain_setup() {
  echo "┌──────────────────────────────┐"
  echo "│   [+] SettingUp Proxychain   │"
  echo "└──────────────────────── marine"
  
  sudo echo "[ProxyList]" >> /etc/proxychains4.conf
  sudo echo "# add this if missing:" >> /etc/proxychains4.conf
  sudo echo "socks5  127.0.0.1 9050" >> /etc/proxychains4.conf
  
  sudo nano /etc/proxychains4.conf

  proxychains4 curl https://check.torproject.org/
}

vpn_setup() {
  echo "┌────────────────────────┐"
  echo "│   [+] Installing VPN   │"
  echo "└─────────────────╴ marine"

  sudo apt install -y openvpn network-manager-openvpn-gnome
  # sudo openvpn --config /etc/openvpn/yourvpnfile.ovpn

  # MAC address spoofing with macchanger
  sudo ifconfig wlan0 down
  sudo macchanger -r wlan0
  sudo ifconfig wlan0 up
  ip link show wlan0
}

logging_setup() {
  echo "┌─────────────────────────────────┐"
  echo "│   [+] Installing Logging Apps   │"
  echo "└──────────────────────────╴ marine"

  sudo apt install auditd audispd-plugins
  sudo systemctl enable auditd
  sudo systemctl start auditd
}

zap_setup() {
  echo "┌────────────────────────────┐"
  echo "│   [+] Installing ZAP App   │"
  echo "└─────────────────────╴ marine"
  sudo apt update
  sudo apt install -y zaproxy
}

mobile_tools() {
  echo "┌─────────────────────────────────┐"
  echo "│   [+] Installing Mobile Tools   │"
  echo "└──────────────────────────╴ marine"
  sudo apt install -y adb

  # MobSF (Mobile Security Framework) — automated mobile app testing (Android/iOS):
  git clone https://github.com/MobSF/Mobile-Security-Framework-MobSF.git $HOME/.hacking/MobSF
  ./$HOME/.hacking/MobSF/setup.sh
  ./$HOME/.hacking/MobSF/run.sh

  sudo apt install -y frida-tools
  sudo apt install -y apktool
}

cloud_tools() {
  echo "┌────────────────────────────────┐"
  echo "│   [+] Installing Cloud Tools   │"
  echo "└─────────────────────────╴ marine"
  
  sudo apt install -y awscli
  aws configure

  pip3 install scoutsuite

  git clone https://github.com/RhinoSecurityLabs/pacu.git $HOME/.hacking/pacu
  python3 -m venv $HOME/.hacking/pacu/.pyenv
  source ./$HOME/.hacking/pacu/.pyenv/bin/activate
  pip3 install -r requirements.txt
  python3 $HOME/.hacking/pacu/pacu.py

  curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

  sudo apt install -y google-cloud-sdk
}



ad_tools() {
  echo "┌───────────────────────────────────────────┐"
  echo "│   [+] Installing Active-Directory Tools   │"
  echo "└────────────────────────────────────╴ marine"

  sudo apt install -y impacket-scripts
  sudo apt install -y crackmapexec
  #sudo neo4j start
  sudo apt install -y responder
  sudo apt install -y powersploit
  sudo apt install -y krb5-user
}

cuda_setup() {
  echo "┌─────────────────────────────────┐"
  echo "│    [+] Installing Cuda Tools    │"
  echo "└──────────────────────────╴ marine"

  sudo apt update
  sudo apt install -y nvidia-driver nvidia-cuda-toolkit
  nvidia-smi
  nvcc --version
}

install_flatpak
setup_flathub
cuda_setup
install_depedencies_apps
install_applications
install_flatpak_apps
install_zed
install_wezterm
install_brave
install_spotify
install_ngrok
install_sublime

#openvas_setup
#anonymity_setup
#proxychain_setup
#vpn_setup
#logging_setup
#zap_setup
#mobile_tools
#cloud_tools
#ad_tools

install_docker_apps
start_app_services
create_containers
setup_firewall


echo "┌─────────────────────────────────────────────────┐"
echo "│      [🎉] All apps installed successfully!      │"
echo "└──────────────────────────────────────────╴ marine"



## Tools Installing
       # go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
       # go install -v github.com/projectdiscovery/pdtm/cmd/pdtm@latest
    ## Tools Setup
        ### pdtm
           # pdtm -install-all
        ### httpx
           # httpx --auth
           # httpx -auth
           # httpx -dashboard
           # httpx -l target.txt -dashboard
           # httpx --auth 3ddfdfa3-2ecf-4ab4-aa40-b2019b71c10c
        ### nuclei
           # nuclei -auth
           # nuclei -target http://honey.scanme.sh -cloud-upload\
