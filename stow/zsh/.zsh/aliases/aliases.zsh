# --- Source other configs initialize >>>
# [[ -f $HOME/.zsh/aliases/extras.zsh ]] && source $HOME/.zsh/aliases/extras.zsh

alias lt='eza -a --tree --level=2 --icons=always'                                   # show system information
alias ls="eza --icons --group-directories-first"                                    # list files and directories
alias ll="eza --icons --group-directories-first -l"                                 # list files and directories with details
alias la="eza --icons --group-directories-first -l -a"                              # list all files and directories with details
alias bat="$HOME/.apps/bat/bat"                                                     # bat command
alias cat="bat"                                                                     # cat command
alias tree="eza -a --tree --level=10 --icons=always"
alias l="eza -l --icons --git -a"
alias llt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2  --icons --git"

alias v="nvim"                                                                      # open nvim
alias cl="clear"                                                                    # clear the terminal
alias cd="z"                                                                        # change directory
alias e="exit"                                                                      # exit the terminal
alias o="sudo nautilus "                                                            # Open the current directory in Finder

alias up="sudo apt -y update"                                                       # update the system
alias fup="sudo apt update && sudo apt -y upgrade"                                  # update and upgrade the system
alias ug="sudo apt -y full-upgrade"                                                 # upgrade the system
alias search="apt-cache search"                                                     # search for packages
alias update="sudo apt update"                                                      # update package list
alias install="sudo apt install -y"                                                 # Install Applications
alias purge="sudo apt purge -y"
alias fx="-fix-missing"

alias reload="source $HOME/.zshrc"
alias sc="source"
alias history-prune="sudo rm $HOME/.local/share/atuin/history.db*"

alias diff='diff --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias less='less -R'
alias man='man -P "less -R"'
alias ncdu='ncdu -x'
alias psql='psql -U postgres'
alias rsync='rsync --progress'
alias tail='tail -f'

alias python="python3"
alias pip='pip3'
alias python3="python3"
alias swift="$HOME/.apps/swift/usr/bin/swift"                                       # swift command
alias code="/usr/share/code/bin/code"                                               # open vscode

alias ls-supply="ls -1 /sys/class/power_supply/"                                    # show system powersupply grids 
alias mem="free -h"                                                                 # show memory usage
alias batteryreport="upower -i /org/freedesktop/UPower/devices/battery_BAT1"        # get battery report
alias clswap="sudo swapoff -a; sudo swapon -a"                                      # clear swap memory
alias cpu='sensors'                                                                 # show cpu usage
alias gpu='nvidia-smi'                                                              # show gpu usage
alias wifi='nmtui'                                                              # wifi settings

alias vopen='openvpn --config'
alias von='sudo openvpn --config'
alias voff='sudo pkill openvpn'
alias vstatus='sudo openvpn --status'

alias ping="ping -c 5"                                                              # Send 5 ICMP echo requests

alias ipconfig="ip a"                                                               # Display all IP addresses
alias netstat="ss -tulnp"                                                           # Show listening ports and connections
alias ports="sudo netstat | grep LISTEN"                                            # Show open ports
alias trace="traceroute"                                                            # Run traceroute
alias myip="curl ifconfig.me"                                                       # Get public IP address
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"                    # Alternative public IP
alias dnslookup="nslookup"                                                          # Query DNS records
alias whois="whois"                                                                 # Perform a WHOIS lookup
alias addhost="sudo nano /etc/hosts"                                                # Edit /etc/hosts file
alias dnstrace="dig +trace google.com"                                              # Trace DNS query
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"  # Run a speed test
alias netcon="nmcli connection show"                                                # List all network connections
alias checkip="curl -s ipinfo.io"                                                   # Display public IP and geo-info

## --------------- *** --------------- ##
#           hacking containers
## --------------- *** --------------- ##
alias mobsf='docker run -it --rm -p 8000:8000 opensecurity/mobile-security-framework-mobsf:latest'
alias hacking-hackthebox='docker run -it --rm hackthebox/hackthebox'
alias hacking-pwntools='docker run -it --rm pwntools/pwntools'
alias hacking-shellshock='docker run -it --rm owasp/shockwave'
alias hacking-burp='docker run -it --rm owasp/burp'
alias hacking-metasploit='docker run -it --rm metasploit/metasploit'
alias hacking-sqlmap='docker run -it --rm sqlmap/sqlmap'
alias hacking-pwncat='docker run -it --rm pwncat/pwncat'
alias hacking-wfuzz='docker run -it --rm wfuzz/wfuzz'
alias hacking-nmap='docker run -it --rm nmap/nmap'
alias hacking-dirbuster='docker run -it --rm dirbuster/dirbuster'
alias hacking-nikto='docker run -it --rm owasp/nikto'
alias hacking-hping3='docker run -it --rm hping3/hping3'
alias hacking-john='docker run -it --rm john/john'
alias hacking-hydra='docker run -it --rm hydra/hydra'
alias hacking-john-the-ripper='docker run -it --rm john-the-ripper/john-the-ripper'
alias hacking-john-jumbo='docker run -it --rm john-jumbo/john-jumbo'
alias hacking-john-watson='docker run -it --rm john-watson/john-watson'
alias hacking-john-wordlist='docker run -it --rm john-wordlist/john-wordlist'
alias hacking-john-parallel='docker run -it --rm john-parallel/john-parallel'
alias hacking-john-pre-parallel='docker run -it --rm john-pre-parallel/john-pre-parallel'
alias hacking-john-wordlist-parallel='docker run -it --rm john-wordlist-parallel/john-wordlist-parallel'