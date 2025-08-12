mkdir -p $HOME/.icons
cd $HOME/.icons
git clone https://github.com/vinceliuice/Qogir-icon-theme
cd Qogir-icon-theme
chmod +x install.sh
./install.sh

cd $HOME/.icons
unzip macOS-White.zip
unzip Tela-black.zip
unzip Tela-dracula.zip


mkdir -p $HOME/.themes
cd $HOME/.themes
git clone https://github.com/EliverLara/Space.git

unzip Obsidian-flow-blue-dark.zip
unzip Space-dark.zip
unzip Space-transparency.zip
