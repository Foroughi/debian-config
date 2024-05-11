sudo apt install -y xorg software-properties-common libnotify-bin dunst
sudo add-apt-repository -y contrib
sudo add-apt-repository -y non-free
sudo apt update
sudo apt install -y nvidia-driver  
sudo apt install -y cmake build-essential ranger compton rofi unzip alsa-utils nitrogen network-manager htop slim curl ca-certificates kitty wget
sudo apt install -y libimlib2-dev libncurses5-dev libx11-dev libxdamage-dev libxft-dev libxinerama-dev libxml2-dev libxext-dev libcurl4-openssl-dev liblua5.3-dev conky  pulseaudio pavucontrol firmware-realtek scrot tmux libgoogle-glog-dev neofetch cmatrix
sudo dpkg-reconfigure slim

mkdir ~/.fonts
mkdir ~/downloads
mkdir ~/projects
sudo mkdir -p /usr/share/xsessions/
sudo touch /usr/share/xsessions/tgwm.desktop


cd ~/downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb 
rm google-chrome-stable_current_amd64.deb 
cd ..

cd ~/projects
git clone https://github.com/Foroughi/tgwm.git
cd tgwm
sudo make install
cd ..
rm -rf tgwm
cd ~

echo [Desktop Entry]  | sudo tee -a /usr/share/xsessions/tgwm.desktop
echo Name=TGWM  | sudo tee -a /usr/share/xsessions/tgwm.desktop
echo Exec=tgwm  | sudo tee -a /usr/share/xsessions/tgwm.desktop
echo Type=XSession | sudo tee -a /usr/share/xsessions/tgwm.desktop

cp ~/.config/fonts/* ~/.fonts

curl -sS https://raw.githubusercontent.com/diogocavilha/fancy-git/master/install.sh | sh
source ~/.bashrc
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
git clone https://github.com/adi1090x/slim_themes.git
sudo cp -r slim_themes/themes/typogin /usr/share/slim/themes/
echo current_theme typogin | sudo tee -a /etc/slim.conf
echo login_cmd exec tgwm | sudo tee -a /etc/slim.conf

rm -rf slim_themes
cd ~

fc-cache -f -v
echo alias l="ls -ls" >> ~/.bashrc
echo alias h="history" >> ~/.bashrc
echo alias c="clear" >> ~/.bashrc
echo neofetch >> ~/.bashrc

pulseaudio --check
pulseaudio -D


### Docker Engine ###
sudo apt-get update
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER

### VsCode ###
cd ~/downloads
wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
sudo apt install -y ./code*.deb
rm -rf ./code*.deb
cd ~

ssh-keygen -t ed25519 -C "foroughi.ali@gmail.com"


git config --global user.email "foroughi.ali@gmail.com"
git config --global user.name "Ali Foroughi"



sudo reboot
