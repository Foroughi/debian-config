#!/bin/bash

batch_install() {

    clear
    cd ~
    $1

    #echo "$1 Done, Press any key to get back to main menu"
    #read
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

    sudo apt install -y  i3  xclip rofi  picom nitrogen  polybar dunst conky scrot xsecurelock

}


CmdTools() {


    sudo apt install -y bat direnv tree lsd btop curl ranger unzip ca-certificates wget  tmux neofetch cmatrix fzf   gpg apt-transport-https

    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat

}

Apt() {


    sudo cp ./source-lists/* /etc/apt/source-list.d/
    sudo apt update

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

    sudo mkdir -p -m 755 /etc/apt/keyrings \
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
    sudo usermod -aG docker $USER
}

Neovim(){
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
    echo export PATH="$PATH:/opt/nvim-linux-x86_64/bin" >> ~/.bashrc
}

Flox(){
    echp 'Please Use their website for now'
}

Starship(){
    curl -sS https://starship.rs/install.sh | sh
}

Lazygit(){
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit -D -t /usr/local/bin/
}
Lazydocker(){
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
}

WezTerm(){

    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
    sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg

    sudo apt update
    sudo apt install wezterm
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


        if [ $key == "[A" ]
        then
                current=$((current - 1))

                if [ $current -lt  0 ]
                then
                    current=$((count - 1))
                fi
        fi


        if [ $key == "[B" ]
        then
                current=$((current + 1))

                if [ $current -ge $count ]
                then
                    current=0
                fi
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


    statuses+=(" ")

    statuses+=(" ")

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

    statuses+=(" ")

    if [ -n "$(which flox)" ]
    then
        statuses+=("I")
    else
        statuses+=(" ")
    fi

    statuses+=(" ")

    if [ -n "$(which nvim)" ]
    then
        statuses+=("I")
    else
        statuses+=(" ")
    fi

    statuses+=(" ")

    if [ -n "$(which starship)" ]
    then
        statuses+=("I")
    else
        statuses+=(" ")
    fi

    statuses+=(" ")


    if [ -n "$(which lazygit)" ]
    then
        statuses+=("I")
    else
        statuses+=(" ")
    fi


    if [ -n "$(which lazydocker)" ]
    then
        statuses+=("I")
    else
        statuses+=(" ")
    fi

    if [ -n "$(which wezterm)" ]
    then
        statuses+=("I")
    else
        statuses+=(" ")
    fi

    #Apt
    statuses+=(" ")
}


tput civis

batch_install Directories

statuses=()

modules=(
    Xorg
    Build
    Libraries
    Sound
    Misc
    CmdTools
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
    Flox
    Neovim
    Starship
    Lazygit
    Lazydocker
    WezTerm
    Apt
)

descriptions=(
    "Install Xorg (X11) and its dependencies"
    "Install GCC and build-essential package"
    "Install required libraries for TGWM and etc"
    "Install sound driver and sound utils"
    "Install desktop widgets , optional utils"
    "Install Commandline tools"
    "Install Nvidia driver"
    "Install Google chrome"
    "Install TGWM"
    "Install Hack fonts (DEPRECATED)"
    "Install Slim (DEPRECATED)"
    "Install Docker"
    "Install Vscode (DEPRECATED)"
    "Generate Github ssh key"
    "Configure default git settings"
    "Install Fuzzy finder"
    "Install Fancy git (DEPRECATED)"
    "Deploy custom bash file"
    "Deploy custom profile file"
    "Install Github CLI"
    "Final preperation"
    "Install Flox"
    "Install Neovim"
    "Install starship"
    "Install Lazygit"
    "Install Lazydocker"
    "Install Wezterm"
    "Cope Apt source lists"
)

count=${#modules[@]}


getkey
