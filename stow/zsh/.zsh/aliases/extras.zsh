## --------------- *** --------------- ##
#                 Docker
## --------------- *** --------------- ##

alias dri="docker images"                                                           # show docker images
alias drpl="docker pull"                                                            # pull docker image
alias drps="docker ps"                                                              # show docker containers
alias drpu="docker push"                                                            # push docker image
alias drr="docker run"                                                              # run docker container
alias drs="docker search"                                                           # search docker image
alias drco="docker compose"
alias drpsa='docker ps -a'
alias drpsf='docker ps -f status=exited'

## --------------- *** --------------- ##
#               Container
## --------------- *** --------------- ##
alias dpr="docker container start myportainer"                                      # start docker container myportainer - docker gui
alias dpra="docker start portagent"                                                 # portainer externsion for docker

alias dr-kali="docker start mykali && docker attach mykali"                         # kali-linux container


## --------------- *** --------------- ##
#                college
## --------------- *** --------------- ##
# Add aliases for college
# alias .college="$HOME/.college"                                                     # college command
# alias cryp="cd $HOME/.college/final-year project/app.py"


## --------------- *** --------------- ##
#               kubernets
## --------------- *** --------------- ##
# aliases for k8s
alias kc='kubectl'
alias kg='kubectl get'
alias ka="kubectl apply -f"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias kl="kubectl logs"
alias kgpo="kubectl get pod"
alias kgd="kubectl get deployments"
alias kc="kubectx"
alias kns="kubens"
alias kl="kubectl logs -f"
alias ke="kubectl exec -it"
alias kcns='kubectl config set-context --current --namespace'
alias podname=''

## --------------- *** --------------- ##
#                  labs
## --------------- *** --------------- ##
# alias .labs="$HOME/.labs"                                                           # labs command

## --------------- *** --------------- ##
#                  ssh
## --------------- *** --------------- ##
# alias prx="ssh "                                                                  # remote connection
# alias prxh="ssh -Y "                                                              # remote connection with X11 forwarding

# aliases for labs
# alias lab-ssh='ssh -o StrictHostKeyChecking=no'
# alias lab-git='git clone'
# alias lab-docker='docker run -it'
# alias lab-kubectl='kubectl apply -f'
# alias lab-helm='helm install'
# alias lab-terraform='terraform init'
# alias lab-terraform-apply='terraform apply'
# alias lab-terraform-destroy='terraform destroy'

## --------------- *** --------------- ##
#                  pnpm
## --------------- *** --------------- ##
alias p="pnpm"                                                                      # pnpm command
alias pi="pnpm install"                                                             # install packages
alias pa="pnpm add"                                                                 # add packages
alias pd="pnpm dev"                                                                 # run development mode
alias pb="pnpm build"                                                               # build the project
alias pr="pnpm run"                                                                 # run scripts
alias psd="pnpm start:dev"                                                          # start development mode
alias pbs="pnpm build:prod"                                                         # build the project in production mode
alias pbsd="pnpm start:prod"                                                        # start the project in production mode
alias p-up='pnpm update'                                                            # update pnpm packages

## --------------- *** --------------- ##
#               directories
## --------------- *** --------------- ##
# alias gprj="z $HOME/Projects"                                                       # open project folder in terminal
# alias gcs="z $HOME/Vault's/10 Cheat-sheets"                                         # open cheat sheet folder in terminal
alias vsetting="code ~/.config/Code/User/settings.json"                             # open visual studio code setting in vscode

## --------------- *** --------------- ##
#                commands
## --------------- *** --------------- ##

alias w="sudo nano"

## --------------- *** --------------- ##
#            package management
## --------------- *** --------------- ##


## --------------- *** --------------- ##
#           system information
## --------------- *** --------------- ##
alias ghost="gs"                                                                    # replace ghostscript command so git status works properly
alias osinfo="cat /etc/os-release"
alias nf='neofetch'                                                                 # show system information
alias ff='fastfetch'                                                                # show system information


## --------------- *** --------------- ##
#             system tools
## --------------- *** --------------- ##


## --------------- *** --------------- ##
#              poweroption
## --------------- *** --------------- ##
alias shutdown='systemctl poweroff'                                                 # shutdown the system

## --------------- *** --------------- ##
#                  pnpm
## --------------- *** --------------- ##


## --------------- *** --------------- ##
#                  git
## --------------- *** --------------- ##
alias gc='git clone'
alias gi='git init'                                                                 # initialize a git repository
alias gro='git remote add origin'                                                   # add a remote repository
alias ga='git add'                                                                  # add files to the staging area
alias gaa='git add .'                                                               # add all files to the staging area
alias gcm='git commit -m'                                                           # commit files with a message
alias gpsh='git push'                                                               # push files to the remote repository
alias gpsho='git push -u origin'                                                    # push files to the remote repository and set the upstream tracking information
alias gss='git status -s'                                                           # show the status of the repository
# alias gs='echo ""; echo "*********************************************"; echo -e "   DO NOT FORGET TO PULL BEFORE COMMITTING"; echo "*********************************************"; echo ""; git status'               # show the status of the repository

alias gca="git commit -a -m"
alias gpo="git pull origin"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'


# aliases for network basics
# !Basic Networking Commands
alias ipup="sudo dhclient"                                                          # Get a new IP via DHCP
alias ipdown="sudo dhclient -r"                                                     # Release current IP
alias ping="ping -c 5"                                                              # Send 5 ICMP echo requests

# aliases for network interfaces
# !Wi-Fi and Network Interfaces
alias wifiup="nmcli radio wifi on"                                                  # Enable Wi-Fi
alias wifidown="nmcli radio wifi off"                                               # Disable Wi-Fi
alias wifilist="nmcli dev wifi list"                                                # List available Wi-Fi networks
alias wificonnect="nmcli dev wifi connect"                                          # Connect to a Wi-Fi network
alias wifidisconnect="nmcli dev disconnect wlan0"                                   # Disconnect from Wi-Fi
alias netinfo="nmcli dev show"                                                      # Show detailed info for all network devices
alias ifup="sudo ifconfig wlan0 up"                                                 # Bring up wireless interface
alias ifdown="sudo ifconfig wlan0 down"                                             # Bring down wireless interface
alias ifrestart="sudo systemctl restart NetworkManager"                             # Restart NetworkManager

# aliases for dns and hosts
# !DNS and Hosts
alias resolv="cat /etc/resolv.conf"                                                 # View DNS configuration
alias dnstest="dig google.com"                                                      # Test DNS resolution
alias dnsperf="dig google.com +stats"                                               # Test DNS query performance

# aliases for network tools
# !Networking Tools
alias connect="nmcli connection up"                                                 # Activate a network connection
alias disconnect="nmcli connection down"                                            # Deactivate a network connection
alias ip-os='nmap -O'
alias ip-arp='arp -a'


# aliases for firewall 
# !Firewall and Security


# aliases for public IP addresses
# !Public IP and Network Testing
alias googledns="ping 8.8.8.8 -c 5"                                                 # Test connection to Google DNS
alias speed="speedtest-cli"                                                         # Run a network speed test
alias latency="ping -c 5 1.1.1.1"                                                   # Test latency to Cloudflare's DNS

## --------------- *** --------------- ##
#         programming language
## --------------- *** --------------- ##
# aliases for python
alias spy="python3 -m venv pyenv && source pyenv/bin/activate"
alias pip-install='pip3 install'
alias pip-update='pip3 install --upgrade'
alias pip-freeze='pip3 freeze'
alias pip-list='pip3 list'

# aliases for swift

