#!/bin/bash

apt update
apt -y purge audience epiphany-browser scratch-text-editor
apt -y full-upgrade
apt -y install fish software-properties-common git

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410
apt-add-repository ppa:philip.scott/elementary-tweaks -y
echo deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list
apt-add-repository -y ppa:hourglass-team/hourglass-daily
apt-add-repository -y ppa:numix/ppa
apt-add-repository -y ppa:tista/adapta
apt-add-repository -y ppa:alexlarsson/flatpak
add-apt-repository -y ppa:nilarimogard/webupd8

apt -y update
apt -y install pdftk albert gedit gnome-system-monitor elementary-tweaks unace zip unzip p7zip p7zip-rar rar unrar vlc gimp flatpak autoconf automake libgtk-3-dev owncloud-client gnome-disk-utility spotify-client ubuntu-restricted-extras krita guake variety hourglass screenfetch breeze-cursor-theme numix-icon-theme-circle inkscape browser-plugin-vlc openssh-server 
git clone https://github.com/surajmandalcell/elementary-x.git ~/.themes/elementary-x
git clone https://github.com/numixproject/numix-folders ~/.numix/
flatpak install --from https://flathub.org/repo/appstream/de.haeckerfelix.gradio.flatpakref
git clone https://github.com/andreisergiu98/arc-flatabulous-theme ~/.themes/flarc && cd ~/.themes/flarc
./autogen.sh --prefix=/usr
make install
git clone https://github.com/horst3180/arc-theme ~/.themes/arc-theme --depth 1 && cd ~/.themes/arc-theme
./autogen.sh --prefix=/usr
make install


# download some debs and source
mkdir /tmp/debs/
wget -O /tmp/debs/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
wget -O /tmp/debs/vivaldi.deb https://downloads.vivaldi.com/stable/vivaldi-stable_1.12.955.38-1_amd64.deb
wget -O /tmp/debs/skype.deb https://go.skype.com/skypeforlinux-64.deb
wget -O /tmp/debs/wps.deb http://kdl1.cache.wps.com/ksodl/download/linux/a21//wps-office_10.1.0.5707~a21_amd64.deb
wget -O /tmp/debs/teamviewer.deb https://download.teamviewer.com/download/teamviewer_i386.deb
cd /tmp/
mkdir -p /opt/franz
wget -qO- https://github.com/meetfranz/franz-app/releases/download/4.0.4/Franz-linux-x64-4.0.4.tgz | tar xvz -C /opt/franz/

# install
dpkg -iR /tmp/debs/
rm -r /tmp/debs/

# create franz launcher
wget "https://cdn-images-1.medium.com/max/360/1*v86tTomtFZIdqzMNpvwIZw.png" -O /opt/franz/franz-icon.png

# adblock hosts
wget -O /tmp/hosts.zip https://hosts-file.net/download/hosts.zip
cd /tmp
unzip /tmp/hosts.zip
mv hosts.txt /etc/hosts
sed -i "21 a 127.0.1.1       $(hostname)" /etc/hosts

cp /usr/share/icons/Numix-Circle /usr/share/icons/Numix-modified -r
sed -i '5s/.*/Inherits=elementary,Numix/' /usr/share/icons/Numix-modified/index.theme

apt -fy install
apt autoremove -y
apt autoclean -y

gsettings set org.gnome.mutter overlay-key "'Super_L'"
gsettings set org.pantheon.desktop.gala.behavior overlay-action "'wingpanel --toggle-indicator=app-launcher'"
