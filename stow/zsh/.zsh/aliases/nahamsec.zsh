# --------------------
# ------- AWS --------
# --------------------

function s3ls() {
  aws s3 ls "s3://$1"
}

function s3cp() {
  aws s3 cp "$2" "s3://$1"
}

# -------------------------------
# --- Content Discovery -------
# -------------------------------
function thewadl() { #this grabs endpoints from a application.wadl and puts them in yahooapi.txt
  # Grab endpoints from application.wadl
  curl -s "$1" | grep path | sed -n 's/.*resource path="\([^"]*\)".*/\1/p' | tee -a ~/.hacking/tools/dirsearch/db/yahooapi.txt
}

# -------------------------------
# --------- Recon ---------------
# -------------------------------

function crtndstry() {
  ./.hacking/tools/crtndstry/crtndstry "$1"
}

function am() { #runs amass passively and saves to json
  # Run Amass passively and save JSON
  amass enum --passive -d "$1" -json "$1.json" \
  jq .name "$1.json" | sed 's/"//g' | httprobe -c 60 | tee -a "$1-domains.txt"
}

function certprobe() { #runs httprobe on all the hosts from certspotter
  curl -s "https://crt.sh/?q=%25.$1&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | httprobe | tee -a ./all.txt
}


function mscan() { #runs masscan
  sudo masscan -p4443,2075,2076,6443,3868,3366,8443,8080,9443,9091,3000,8000,5900,8081,6000,10000,8181,3306,5000,4000,8888,5432,15672,9999,161,4044,7077,4040,9000,8089,443,7443 "$@"
}

function certspotter() {
  curl -s "https://certspotter.com/api/v0/certs?domain=$1" | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep "$1"
} #h/t Michiel Prins


function crtsh() {
  curl -s "https://crt.sh/?Identity=%25.$1" | grep ">*.$1" | sed 's/<[/]*[TB][DR]>/\n/g' | grep -vE "<|^[\*]*[\.]*$1" | sort -u | awk 'NF'
}

function certnmap() {
  curl -s "https://certspotter.com/api/v0/certs?domain=$1" | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep "$1" | nmap -T5 -Pn -sS -i - "$@"
} # #h/t Jobert Abma

function ipinfo() {
  curl -s "http://ipinfo.io/$1"
}

# -------------------------------
# ---------- Tools ---------------
# -------------------------------

function dirsearch() { # runs dirsearch and takes host and extension as arguments
  python3 ~/.hacking/tools/dirsearch/dirsearch.py -u "$1" -e "$2" -t 50 -b
}

function sqlmap() {
  python ~/.hacking/tools/sqlmap*/sqlmap.py -u "$1"
}

function ncx() {
  nc -l -n -vv -p "$1" -k
}

function crtshdirsearch() { #gets all domains from crtsh, runs httprobe and then dir bruteforcers
  curl -s "https://crt.sh/?q=%25.$1&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | httprobe -c 50 | grep https | xargs -n1 -I{} python3 ~/.hacking/tools/dirsearch/dirsearch.py -u {} -e "$2" -t 50 -b
}