# =======================================
# 🚀 Zsh Configuration 
# =======================================

# >>> Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc. >>>
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# >>> oh-my-zsh >>>
export ZSH="$HOME/.oh-my-zsh"

# >>> zsh-theme >>>
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="edvardm"
# ZSH_THEME="robbyrussell"
# eval "$(starship init zsh)"

# >>> Powerlevel10k Configuration >>>
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh                # p10k --

plugins=(
    zsh-syntax-highlighting zsh-autosuggestions git battery brew 
    coffee copybuffer copyfile copypath dirhistory git history sudo
    terraform toolbox torrent vscode web-search xcode zsh-interactive-cd
    zsh-navigation-tools eza grc colorize
)

source $ZSH/oh-my-zsh.sh

zstyle ':completion:*' menu select # selectable menu
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' 'r:|=*' 'l:|=* r:|=*'  # case insensitive completion
zstyle ':completion:*' special-dirs true # Complete . and .. special directories
zstyle ':completion:*' list-colors '' # colorize completion lists
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01' # colorize kill list
export WORDCHARS=${WORDCHARS//[\/]} # remove / from wordchars so that / is a seperator when deleting complete words
zstyle ':omz:update' mode auto                                      # update automatically without asking

# =======================================
# ⚡ Enhancements
# =======================================
# >>> autin >>>
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"                                    

# >>> better cd >>>
eval "$(zoxide init zsh)"                                   

# >>> project enviroments >>>
eval "$(direnv hook zsh)"                                   

# >>> fuzzy finder >>>
eval "$(fzf --zsh)"                                         

# >>> typo fixer >>>
eval "$(thefuck --alias fk)"                                

# >>> linux brew >>>
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# =======================================
# 🛠 Paths & Languages
# =======================================
# >>> spicetify >>>
export PATH="$HOME/.spicetify:$PATH"

# >>> GO >>>
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

# >>> Node >>>
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# >>> kiro >>>
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# >>> Jetbrains >>>
# export PATH=$PATH:/opt/goland/bin	#goland : go ide
# export PATH=$PATH:/opt/phpstorm/bin	#phpstorm : php ide
# export PATH=$PATH:/opt/clion/bin	#clion : c/c++ ide
# export PATH=$PATH:/opt/pycharm/bin	#pycharm : python ide
# export PATH=$PATH:/opt/rustrover/bin	#rustrover : rust ide
# export PATH=$PATH:/opt/webstorm/bin	#webstorm : js/ts ide

# =======================================
# 🔧 Aliases
# =======================================
[[ -f $HOME/.zsh/aliases/aliases.zsh ]] && source $HOME/.zsh/aliases/aliases.zsh
[[ -f $HOME/.zsh/functions/functions.zsh ]] && source $HOME/.zsh/functions/functions.zsh
# [[ -f $HOME/.zsh/scripts/scripts.zsh ]] && source $HOME/.zsh/scripts/scripts.zsh
# [[ -f $HOME/.zsh/starship.zsh ]] && source $HOME/.zsh/starship.zsh
# [[ -f $HOME/.zsh/zap.zsh ]] && source $HOME/.zsh/zap.zsh
# [[ -f $HOME/.zsh/aliases/nahamsec.zsh ]] && source $HOME/.zsh/aliases/nahamsec.zsh

# >>> General
alias ftp-start="python3 $HOME/dotfiles/ftp.py"
alias pyserver='python3 -m http.server 4445'
alias tunnel='ngrok http 4445'

# >>> Docker
alias docker="sudo docker"
alias dr="docker"                                                                   # docker command
alias drcps="docker container ps --all"                                             # search all docker containers
alias drstop="docker stop conatiner"                                                # stop docker container
alias drrm='docker rm '
alias drparrot="docker run --rm -ti --network host -v $PWD/work:/work parrotsec/security"

# >>> MAIN
alias scan="sudo nmap -sV $1"
alias ncat='nc -nv'
alias netcat='nc'
alias hcat='highlight -O ansi'
alias httpie='http --default-scheme=https'
alias pwncat='pwncat --ssl'
alias sqlmap='sqlmap --batch --random-agent'
alias wfuzz='wfuzz -z file,wfuzz-wordlist.txt'
alias burp="java -jar /path/to/burp/burp.jar"
alias metasploit='msfconsole'
alias gobust='gobuster dir --wildcard --wordlist'
# alias pydirsearch='python dirsearch.py -w db/dicc.txt -b -u'
# alias massdns='~/hacking/tools/massdns/bin/massdns -r ~/hacking/tools/massdns/lists/resolvers.txt -t A -o S bf-targets.txt -w livehosts.txt -s 4000'
# alias fuzz='ffuf -w ~/hacking/SecLists/content_discovery_all.txt -mc all -u'
# alias gr='~/go/src/github.com/tomnomnom/gf/gf'
alias http="xh"                                                                     # HTTP requests with xh!
# alias mat='osascript -e "tell application \"System Events\" to key code 126 using {command down}" && tmux neww "cmatrix"'

alias macvendor="sudo nmap --script mac-vendor"                                     # Discover MAC address vendor
alias dnsflush="sudo resolvectl flush-caches"                                       # Flush DNS cache (systemd-resolved)
alias sniff="sudo tcpdump -i any"                                                   # Capture network packets
alias pscan="sudo nmap -sS"                                                         # Perform a SYN scan with nmap
alias arp="arp -a"                                                                  # Display ARP table
alias netsp="iftop"                                                                 # Show network speed (requires iftop)
alias iperf="iperf3"                                                                # Run an iperf3 bandwidth test

# >>> Firewall
alias fwstatus="sudo ufw status verbose"                                            # Check firewall status
alias fwallow="sudo ufw allow"                                                      # Allow a port/service in firewall
alias fwdeny="sudo ufw deny"                                                        # Deny a port/service in firewall
alias fwreload="sudo ufw reload"                                                    # Reload firewall rules
alias scanlocal="sudo nmap -sn 192.168.1.0/24"                                      # Scan local network
alias listconns="ss -s"                                                             # Show network socket statistics
alias tcpblock="iptables -A INPUT -p tcp --dport"                                   # Block TCP port
alias udpblock="iptables -A INPUT -p udp --dport"                                   # Block UDP port

# Webhooks
alias webhook_env="source $HOME/dotfiles/webhooks/discord/.pyenv/bin/activate"
alias nmap_notify="webhook_env && python3 $HOME/dotfiles/webhooks/discord/nmap_notify.py"
