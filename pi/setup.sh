sudo adduser $1
sudo usermod -a -G adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,gpio,i2c,spi $1
sudo rm /etc/sudoers.d/

sudo apt-get install fail2ba -y
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

