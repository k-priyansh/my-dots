# Function for colormapping
function colormap() {
  for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}


# function for compress media files
compress_media() {
    if [[ $# -lt 2 ]]; then
        echo "Usage: compress_media <input_file> <output_file> [bitrate/quality]"
        echo "Example: compress_media input.mp4 output.mp4 2M"
        return 1
    fi

    local input_file="$1"
    local output_file="$2"
    local bitrate_or_quality="${3:-2M}" # Default bitrate is 2M if not specified

    if [[ ! -f "$input_file" ]]; then
        echo "Error: Input file '$input_file' not found!"
        return 1
    fi

    echo "Compressing '$input_file' to '$output_file' with bitrate/quality: $bitrate_or_quality..."

    ffmpeg -i "$input_file" -b:v "$bitrate_or_quality" -b:a 128k "$output_file" -y

    if [[ $? -eq 0 ]]; then
        echo "Compression successful! File saved as '$output_file'."
    else
        echo "Compression failed!"
    fi
}
# compress_media input.mp4 output.mp4 1M

# system_ip
function sysip() {
  local_ip=$(hostname -I | awk '{print $1}')
  public_ipv6=$(curl -6 -s ifconfig.me)
  public_ipv4=$(curl -4 -s ifconfig.me)
  
  echo "Localhost IP: $ip"
  echo "Public IPV4: $public_ipv4"
  echo "Public IPV6: $public_ipv6"
}

# function for windows title 
function set_win_title(){
	system_ip=$(hostname -I | awk '{print $1}')
	#if [[ $system_ip == "127.0.0.1"]]; then
	#	systemip= $system_ip
	#else
	#		systemip= $system_ip
	#fi
	echo -ne "\033]0; Terminal\007"
}
precmd_functions+=(set_win_title)


# function for creating new markdown file in obsidian/00_inbox directory
vn(){ # setting up new course vault
  local filename="$1"
  if [[ -z "$filename" ]]; then
    echo "Usage: vn <filename>"
    return 1
  fi
  #use your own path <filepath>
  mkdir -p $HOME/Obsidian/${filename}
}

# function for git checkout
function gsw() {
    local branch=$1
    if [ -z "$branch" ]; then
        echo "Usage: gsw <branch_name>"
        return 1
    fi
    git checkout $branch
    if [ $? -eq 0 ]; then
        echo "Switched to branch $branch"
    else
        echo "Failed to switch branch"
    fi
}

# function for converting webp media
convert_webp() {
  for i in *
  do
  if [[ "${i##*.}" == "webp" ]]; then
      echo "WEBP FILE => $i"
      # show filename
      filename="${i%.*}"
      # show Extension
      extension="${i##*.}"
      ## webp converter
      ffmpeg -i "$filename" "$filename.png"
    fi
  done
}

ctfready(){ # setting up new course vault
  local filename="$1"
  if [[ -z "$filename" ]]; then
    echo "Usage: ctfready <filename>"
    return 1
  fi
  #use your own path <filepath>
  mkdir -p $HOME/Obsidian/Capture-the-Flag/${filename}
  # sudo apt install python3 python3-venv
  python3 -m venv $HOME/Obsidian/Capture-the-Flag/${filename}/.ctf${filename}
  source $HOME/Obsidian/Capture-the-Flag/${filename}/.ctf${filename}/bin/activate

  base_dir="$HOME/Obsidian/Capture-the-Flag/$filename"
  mkdir -p "$base_dir/credentials/cleartext" \
          "$base_dir/credentials/hashes" \
          "$base_dir/credentials/tokens" \
          "$base_dir/credentials/jwt" \
          "$base_dir/screenshots/recon" \
          "$base_dir/screenshots/web-vulns" \
          "screenshots/mobile" \
          "$base_dir/screenshots/post-exploitation" \
          "$base_dir/privesc/linux" \
          "$base_dir/privesc/windows" \
          "$base_dir/privesc/scripts" \
          "$base_dir/shells/webshells" \
          "$base_dir/shells/revshells" \
          "$base_dir/shells/tty-upgrades" \
          "$base_dir/notes" \
          "$base_dir/exfil/database-dumps" \
          "$base_dir/exfil/config-files" \
          "$base_dir/exfil/secrets" \
          "$base_dir/misc/binaries" \
          "$base_dir/misc/logs" \
          "$base_dir/misc/memory-dumps"



  ln -sf $HOME/Obsidian/Capture-the-Flag/${filename} $HOME/Desktop/
  cd $HOME/Desktop/${filename}
  clear
  la
}