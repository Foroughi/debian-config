#!/bin/bash

batch_install() {

    clear
    cd ~
    $1
    
}


Xorg() {    
        
    sudo apt install -y xorg   

}

Build() {    
        
    sudo apt install -y cmake build-essential   

}

Libraries() {    
        
    sudo apt install -y libnotify-bin libimlib2-dev libncurses5-dev libx11-dev libxdamage-dev libxft-dev libxinerama-dev libxml2-dev libxext-dev libcurl4-openssl-dev liblua5.3-dev libgoogle-glog-dev   

}

Sound() {    
        
    sudo apt install -y alsa-utils pulseaudio pavucontrol firmware-realtek  

}

Misc() {    
    
    sudo apt install -y curl ranger rofi unzip picom nitrogen htop ca-certificates kitty wget polybar dunst conky scrot tmux neofetch cmatrix fzf   gpg apt-transport-https
    
}


Nvidia() {    

    sudo apt install -y software-properties-common   
    sudo add-apt-repository -y contrib   
    sudo add-apt-repository -y non-free   
    sudo apt update   
    sudo apt install -y nvidia-driver
             
}



Directories() { 

    mkdir ~/.fonts
    mkdir ~/downloads
    mkdir ~/projects

}


Google_Chrome() { 

    cd ~/downloads
    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y ./google-chrome-stable_current_amd64.deb  
    rm google-chrome-stable_current_amd64.deb    

}

TGWM() { 

    sudo mkdir -p /usr/share/xsessions/
    sudo touch /usr/share/xsessions/tgwm.desktop
    cd ~/projects
    git clone -q https://github.com/Foroughi/tgwm.git
    cd tgwm
    sudo make install 

    echo [Desktop Entry]  | sudo tee -a /usr/share/xsessions/tgwm.desktop
    echo Name=TGWM  | sudo tee -a /usr/share/xsessions/tgwm.desktop
    echo Exec=tgwm  | sudo tee -a /usr/share/xsessions/tgwm.desktop
    echo Type=XSession | sudo tee -a /usr/share/xsessions/tgwm.desktop

    cp ~/.config/fonts/* ~/.fonts

}

FancyGit() { 

    curl -sS https://raw.githubusercontent.com/diogocavilha/fancy-git/master/install.sh | sh        
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
    sudo apt install slim -y  
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
    sudo apt-get update  
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin  
    sudo usermod -aG docker $USER
}

VsCode() {

    
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
    rm -f packages.microsoft.gpg
    
    sudo apt update
    sudo apt install code # or code-insiders

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
		
    git clone -q --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    cd ~/.fzf
    ./install  
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
    && sudo apt update  \
    && sudo apt install gh -y 

}

Preperation() {

    fc-cache -f -v 
    pulseaudio --check
    pulseaudio -D
    sudo usermod -aG audio $USER
    sudo usermod -aG video $USER    

}

menu() {

        clear
        
        printf "\nPlease select your package and install : \n\n"

        for (( c=0; c<count; c++ ))  do

                if [ "$c" == $1 ]
                then

                        printf "      > ";
                else
                        printf "        ";
                fi


                printf "[${statuses[c]}] ${descriptions[c]}\n";
        done

        printf "\n [i] Install [s] Select/Deselect [q] Quit\n"


}
  getkey(){

    check
    current=0
    escape_char=$(printf "\u1b")

    while true; do

        menu $current      

        read -rsn1 key
        if [[ $key == $escape_char ]]; then
                read -rsn2  key
        fi

        if [ $key == "s" ] &&  [ "${statuses[current]}" != "I" ] 
        then

            if [ "${statuses[current]}" == "S" ] 
            then
                statuses[current]=" "

            else
                statuses[current]="S"
            fi              
        fi


        if [ $key == "[A" ] && [ $current -gt  0 ]
        then
                current=$((current - 1))
        fi


        if [ $key == "[B" ] && [ $(( $current + 1 )) -lt $count ]
        then
                current=$((current + 1))
        fi

        if [ $key == "q" ]
        then
            tput cnorm
            clear
            exit
        fi

        if [ $key == "i" ]
        then
            for (( c=0; c<count; c++ ))  do

                if [ "${statuses[c]}" == "S"  ]
                then
                    batch_install ${modules[c]}
                    statuses[c]="I"
                fi
            done
        fi
        
    done
}

check() {

    if [ -f "/bin/x11perf" ]
    then
        statuses+=("I")
    else
        statuses+=(" ")
    fi

    if [ -f "/usr/bin/gcc" ]
    then
        statuses+=("I")
    else
        statuses+=(" ")
    fi


    statuses+=(" ")
    
    if [ -n "$(which alsamixer)" ]
    then
        statuses+=("I")
    else
        statuses+=(" ")
    fi

    if [ -n "$(which tmux)" ]
    then
        statuses+=("I")
    else
        statuses+=(" ")
    fi

    if [ -n "$(which nvidia-settings)" ]
    then
        statuses+=("I")
    else
        statuses+=(" ")
    fi

    if [ -n "$(which google-chrome)" ]
    then
        statuses+=("I")
    else
        statuses+=(" ")
    fi

    if [ -n "$(which tgwm)" ]
    then
        statuses+=("I")
    else
        statuses+=(" ")
    fi

    statuses+=(" ")
      

    if [ -n "$(which slim)" ]
    then
        statuses+=("I")
    else
        statuses+=(" ")
    fi

    if [ -n "$(which docker)" ]
    then
        statuses+=("I")
    else
        statuses+=(" ")
    fi

    if [ -n "$(which code)" ]
    then
        statuses+=("I")
    else
        statuses+=(" ")
    fi

    statuses+=(" ")
    statuses+=(" ")

    if [ -n "$(which fzf)" ]
    then
        statuses+=("I")
    else
        statuses+=(" ")
    fi

    if [ -n "$(which fancygit)" ]
    then
        statuses+=("I")
    else
        statuses+=(" ")
    fi

    statuses+=(" ")
    statuses+=(" ")

    if [ -n "$(which gh)" ]
    then
        statuses+=("I")
    else
        statuses+=(" ")
    fi

    statuses+=(" ")

}


tput civis

batch_install Directories


count=20
statuses=()
modules=(
    Xorg 
    Build
    Libraries
    Sound
    Misc
    Nvidia    
    Google_Chrome
    TGWM 
    Hack_Fonts
    Slim 
    Docker 
    VsCode 
    Github_SSH_key 
    Git 
    Fuzzy_Finder 
    FancyGit 
    Custom_BashRC 
    Custom_Profile 
    Github_CLI 
    Preperation
)
descriptions=(
    "Install Xorg (X11) and its dependencies"     
    "Install GCC and build-essential package"     
    "Install required libraries for TGWM and etc"     
    "Install sound driver and sound utils"     
    "Install desktop widgets , optional utils"     
    "Install Nvidia driver"         
    "Install Google chrome"     
    "Install TGWM"     
    "Install Hack fonts"     
    "Install Slim"     
    "Install Docker"     
    "Install Vscode"     
    "Generate Github ssh key"     
    "Configure default git settings"     
    "Install Fuzzy finder"     
    "Install Fancy git"     
    "Deploy custom bash file"     
    "Deploy custom profile file"     
    "Install Github CLI"     
    "Final preperation"     
)


getkey