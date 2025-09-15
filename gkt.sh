mkdir -p $HOME/.icons
git clone https://github.com/vinceliuice/Qogir-icon-theme
cd Qogir-icon-theme
chmod +x install.sh
./install.sh

mkdir -p $HOME/.themes
cd $HOME/.themes
git clone https://github.com/EliverLara/Space.git
