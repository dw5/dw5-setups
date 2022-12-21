install lsof

# ---

sudo cp /etc/iptables/rules.v4 /etc/iptables/rules.v4.bak && sudo truncate -s 0 /etc/iptables/rules.v4
sudo iptables -A OUTPUT -p tcp --sport 80 -m conntrack --ctstate ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 443 -m conntrack --ctstate ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

# --- setupper (old)

sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade

# Snaps? No thanks
snap list
sudo snap remove
sudo snap remove lxd
sudo snap remove core18
sudo snap remove snapd
sudo umount /snap/core/
ls /snap/core
sudo apt purge snapd
sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd

# Video processing
sudo apt-get install ffmpeg
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

# Coolio sys info
sudo apt-get install screenfetch 
sudo apt-get install neofetch

# Apache (maybe nginx would be better) + PHP
sudo apt-get install apache2
sudo a2enmod rewrite

# PHP8
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt install php8.0 libapache2-mod-php8.0

echo "">/var/www/html/index.html

a2enmod proxy proxy_http
a2enmod proxy_balancer
a2enmod security2
a2enmod lbmethod_byrequests
systemctl restart apache2
sudo apt-get install git

# Security - Fail2ban, EndlessSSH
sudo apt-get install fail2ban
apt install make install libc6-dev gcc
git clone https://github.com/skeeto/endlessh.git
cd endlessh/
make
mv endlessh /usr/local/bin
which endlessh 
cp util/endlessh.service /etc/systemd/system/
systemctl enable endlessh

cd ../
git clone https://github.com/itskenny0/fail2ban-endlessh.git
cd fail2ban-endlessh/
cp action.d/endlessh.conf  /etc/fail2ban/action.d/
ls /etc/fail2ban/action.d/
cp jail.d/endlessh.conf  /etc/fail2ban/jail.d/
systemctl restart fail2ban.service 
