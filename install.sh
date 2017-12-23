#/bin/bash

base_pkgs="build-essential linux-headers-$(uname -r) apt-transport-https ca-certificates software-properties-common curl gdebi"

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
    glipper \
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
    silversearcher-ag \
    thunderbird \
    enpass \
    synapse"

add_ppas() {
    #nodejs
    curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -

    #enpass
    echo "deb http://repo.sinew.in/ stable main" > /etc/apt/sources.list.d/enpass.list && wget -O - https://dl.sinew.in/keys/enpass-linux.key | apt-key add -
}

rgdebi() {
    filename=`openssl rand -base64 12`
    curl -J -L -O "/tmp/$2" $filename && gdebi "/tmp/$filename"
}

sudo su

#apt-pkgs
apt-get update
apt-get install "$base_pkgs"
add_ppas()
apt-get update
apt-get install "$apt_pkgs"

#pure .deb pkgs
rgdebi "https://github.com/keeweb/keeweb/releases/download/v1.6.3/KeeWeb-1.6.3.linux.x64.deb"
rgdebi "https://go.microsoft.com/fwlink/?LinkID=760868"
rgdebi "https://go.skype.com/skypeforlinux-64.deb"

#snap pkgs
snap install spotify
snap install simplenote

#pip pkgs
pip3 install autokey

#curl based installers
curl -fsSL get.docker.com  | sh
sh -c "`curl -fsSL https://raw.githubusercontent.com/vtrbtf/dotfiles/master/install.sh`"
curl http://j.mp/spf13-vim3 -L -o - | sh

#hooks
#(crontab -l 2>/dev/null; echo "@daily wget -O /etc/hosts https://github.com/StevenBlack/hosts/blob/master/alternates/fakenews-gambling-porn-social/hosts?raw=true") | crontab -
