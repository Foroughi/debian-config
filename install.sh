sudo apt install -y xorg git wget software-properties-common libnotify-bin dunst
sudo add-apt-repository contrib
sudo add-apt-repository non-free
sudo apt update
sudo apt install -y nvidia-driver kitty

sudo apt install -y cmake build-essential ranger compton rofi unzip alsa-utils nitrogen network-manager htop slim
sudo apt install -y libimlib2-dev libncurses5-dev libx11-dev libxdamage-dev libxft-dev libxinerama-dev libxml2-dev libxext-dev libcurl4-openssl-dev liblua5.3-dev conky pavucontrol ntfs-3g firmware-realtek scrot tmux libgoogle-glog-dev neofetch cmatrix
sudo dpkg-reconfigure slim

mkdir ~/{.fonts , downloads , projects }
sudo mkdir -p /usr/share/xsessions/
sudo touch /usr/share/xsessions/tgwm.desktop


cd ~/downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y google-chrome-stable_current_amd64.deb 
rm google-chrome-stable_current_amd64.deb 
cd ..

cd ~/projects
git clone https://github.com/Foroughi/tgwm.git
cd tgwm
sudo make install
cd ..
rm -rf tgwm
cd ~

cat << EOF >> file.txt
The current working directory is: $PWD
You are logged in as: $(whoami)
EOF


echo [Desktop Entry]  | sudo tee -a /usr/share/xsessions/tgwm.desktop
echo Name=TGWM  | sudo tee -a /usr/share/xsessions/tgwm.desktop
echo Exec=tgwm  | sudo tee -a /usr/share/xsessions/tgwm.desktop
echo Type=XSession | sudo tee -a /usr/share/xsessions/tgwm.desktop


cp ~/.config/fonts/* ~/.fonts

curl -sS https://raw.githubusercontent.com/diogocavilha/fancy-git/master/install.sh | sh

fancygit --set-user-name " Ali"
fancygit --disable-time
fancygit --enable-bold-prompt
fancygit --enable-double-line

cd ~/downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip
unzip Hack.zip
cp *.ttf ~/.fonts
rm -rf *.ttf
rm -rf Hack.zip
cd ~

cd ~/downloads
https://github.com/adi1090x/slim_themes.git
sudo cp -r slim_themes/typogin /usr/share/slim/themes/
echo current_theme typogin | sudo tee -a /etc/slim.conf
echo loginc_cmd exec tgwm | sudo tee -a /etc/slim.conf

rm -rf slim_themes
cd ~

fc-cache -f -v
echo neofetch >> ~/.bashrc

sudo reboot
