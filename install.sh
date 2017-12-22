#/bin/bash

base_pkgs="build-essential linux-headers-$(uname -r) apt-transport-https ca-certificates software-properties-common curl"

apt_pkgs="\
    guake \
    gnome-do gnome-do-plugins \
    git \
    zip unzip \
    vim \
    firefox \
    telegram \
    nautilus-dropbox \
    htop \
    openjdk-9-jdk \
    zsh \
    tmux \
    bc \
    tree \
    rsync \
    jq \
    ranger \
    virtualbox virtualbox-ext-pack vagrant \
    xclip \
    vlc \
    geany \
    deluge \
    synaptic \
    gparted \
    nodejs \
    enpass \
    gdebi \
    synapse"

add_ppas() {
    #nodejs
    curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -

    #enpass
    sudo echo "deb http://repo.sinew.in/ stable main" > /etc/apt/sources.list.d/enpass.list && wget -O - https://dl.sinew.in/keys/enpass-linux.key | sudo apt-key add -
}


rgdebi() {
    curl -J -L -O "/tmp/$2" $1 && gdebi "/tmp/$2"
}

sudo su
apt-get update
apt-get install "$base_pkgs"
add_ppas()
apt-get update
apt-get install "$apt_pkgs"

rgdebi "https://github.com/keeweb/keeweb/releases/download/v1.6.3/KeeWeb-1.6.3.linux.x64.deb" "keeweb.debi"
rgdebi "https://go.microsoft.com/fwlink/?LinkID=760868" "vscode.deb"
rgdebi "https://go.skype.com/skypeforlinux-64.deb" "skype.deb"


curl -fsSL get.docker.com -o get-docker.sh | sh

