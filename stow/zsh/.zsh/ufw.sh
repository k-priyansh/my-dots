sudo apt-get install ufw
sudo ufw disable

sudo ufw limit ssh/tcp
sudo ufw allow 19683/tcp
sudo ufw logging on
sudo ufw enable
sudo ufw status