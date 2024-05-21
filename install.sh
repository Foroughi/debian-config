
clear

batch_install() {
    cd ~

    if [ -z $2 ] 
    then
        printf "[ ] Installing $1"
    else
        printf "[ ] $2 $1"
    fi    

    $1 >> /dev/null

    printf "\r[D] $1                             \n"
}


Xorg() {    
        
    sudo apt install -y xorg 2>/dev/null    

}

Build() {    
        
    sudo apt install -y cmake build-essential 2>/dev/null    

}

Libraries() {    
        
    sudo apt install -y libnotify-bin libimlib2-dev libncurses5-dev libx11-dev libxdamage-dev libxft-dev libxinerama-dev libxml2-dev libxext-dev libcurl4-openssl-dev liblua5.3-dev libgoogle-glog-dev 2>/dev/null    

}

Sound() {    
        
    sudo apt install -y alsa-utils pulseaudio pavucontrol firmware-realtek 2>/dev/null 

}

Misc() {    
    
    sudo apt install -y curl ranger rofi unzip picom nitrogen htop ca-certificates kitty wget polybar dunst conky scrot tmux neofetch cmatrix fzf 2>/dev/null    
    
}


Nvidia() {    

    sudo apt install -y software-properties-common 2>/dev/null    
    sudo add-apt-repository -y contrib 2>/dev/null    
    sudo add-apt-repository -y non-free 2>/dev/null    
    sudo apt update 2>/dev/null    
    
             
}



Directories() { 

    mkdir ~/.fonts
    mkdir ~/downloads
    mkdir ~/projects

}


Google_Chrome() { 

    cd ~/downloads
    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y ./google-chrome-stable_current_amd64.deb 2>/dev/null 
    rm google-chrome-stable_current_amd64.deb    

}

TGWM() { 

    sudo mkdir -p /usr/share/xsessions/
    sudo touch /usr/share/xsessions/tgwm.desktop
    cd ~/projects
    git clone -q https://github.com/Foroughi/tgwm.git
    cd tgwm
    sudo make install -q

    echo [Desktop Entry]  | sudo tee -a /usr/share/xsessions/tgwm.desktop
    echo Name=TGWM  | sudo tee -a /usr/share/xsessions/tgwm.desktop
    echo Exec=tgwm  | sudo tee -a /usr/share/xsessions/tgwm.desktop
    echo Type=XSession | sudo tee -a /usr/share/xsessions/tgwm.desktop

    cp ~/.config/fonts/* ~/.fonts

}

FancyGit() { 

    curl -sS https://raw.githubusercontent.com/diogocavilha/fancy-git/master/install.sh | sh   >> /dev/null     
}

Hack_Fonts() {

    cd ~/downloads
    wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip
    unzip Hack.zip
    cp *.ttf ~/.fonts
    rm -rf *.ttf
    rm -rf Hack.zip    
}

Slim() {
    sudo apt install slim -y 2>/dev/null 
    sudo dpkg-reconfigure slim
    cd ~/downloads
    git clone -q https://github.com/adi1090x/slim_themes.git
    sudo cp -r slim_themes/themes/typogin /usr/share/slim/themes/
    echo current_theme typogin | sudo tee -a /etc/slim.conf
    echo login_cmd exec tgwm | sudo tee -a /etc/slim.conf
    rm -rf slim_themes
}

Docker() {
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update 2>/dev/null 
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin  2>/dev/null
    sudo usermod -aG docker $USER
}

VsCode() {

    sudo touch /etc/apt/sources.list.d/vscode.list
    echo "deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/repos/code stable main"  | sudo tee -a /etc/apt/sources.list.d/vscode.list
    sudo apt update 2>/dev/null
    sudo apt install code -y 2>/dev/null
}

Github_SSH_key() {
    ssh-keygen -q -t ed25519 -C "foroughi.ali@gmail.com"  -P ""
}

Git() {
    git config --global user.email "foroughi.ali@gmail.com"
    git config --global user.name "Ali Foroughi"
    git config --global pull.rebase true
    git config --global init.defaultBranch master
}

Fuzzy_Finder() {
	~/.fzf/uninstall >> /dev/null
	rm -rf ~/.fzf
    git clone -q --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    cd ~/.fzf
    ./install --all >> /dev/null
}

Custom_BashRC() {
    echo . ~/.config/mybashrc.sh >> ~/.bashrc
}

Custom_Profile() {
    echo "if [ -d \"$HOME/.config\" ] ; then
            if [ -f \"$HOME/.config/myprofile.sh\" ] ; then
                    . \"$HOME/.config/myprofile.sh\"
            fi
    fi" >> ~/.profile
}

Github_CLI() {

    mkdir -p -m 755 /etc/apt/keyrings \
    && wget -q O- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update 2>/dev/null \
    && sudo apt install gh -y >> /dev/null

}

Preperation() {

    fc-cache -f -v >> /dev/null
    pulseaudio --check
    pulseaudio -D
    sudo usermod -aG audio $USER
    sudo usermod -aG video $USER

    sudo apt upgrade -y   >> /dev/null

}

batch_install Xorg
batch_install Build
batch_install Libraries
batch_install Sound
batch_install Misc
batch_install Nvidia
batch_install Directories Creating
batch_install Google_Chrome
batch_install TGWM
batch_install Hack_Fonts
batch_install Slim
batch_install Docker
batch_install VsCode
batch_install Github_SSH_key
batch_install Git Configuring
batch_install Fuzzy_Finder
batch_install FancyGit
batch_install Custom_BashRC Configuring
batch_install Custom_Profile Configuring
batch_install Github_CLI
batch_install Preperation Final

sudo apt install -y nvidia-driver

reboot
