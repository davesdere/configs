#!/bin/bash
# David Cote | MIT License 2018
ver="0.1"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"  # get current directory of this script
progName=$(basename -- "$0")
cd $DIR
echo "INFO  : $progName $ver  written by David Cote | MIT 2018"
username=$1
groupname=$2
if $1="":
  echo "You need 2 arguments username and groupname"
fi
# Accesses
# https://help.ubuntu.com/community/Sudoers # Good ressource
# Add a user and set their password
sudo adduser $username
# What groups are there?
groups
# To add to the groups, First let's see which one 'pi' has
sudo adduser $username $groupName

#sudo dpkg-reconfigure tzdata # Setting timezone data

# Kill the sessions
# This will close all the sessions of user
#sudo pkill -9 -u $username

# Remove the pi user
#userdel -r -f pi
#sudo deluser pi sudo # Or only remove sudo permissions
# The sudoers file are in this
#/etc/sudoers

# VIM life
update-alternatives --set editor /usr/bin/vim.tiny | update-alternatives --set editor /usr/bin/vi | echo "Couldn't find any vim in /usr/bin/" & ls /usr/bin/vi*

# To keep local vim setting when using it as root, use
sudo -e vim /path/to/file
# When creating a user, the content of /etc/skel will be copied to the new user folder in /home

## Change host name | Requires reboot
#vim /etc/hosts # Change hostname under address 127.0.1.1
#vim /etc/hostname # Change hostname string
#sudo /etc/init.d/hostname.sh # Commit changes
#sudo reboot

# If something breaks
#sudo apt --fix-broken install

## Diagnosis
dmesg # Check install messages
systemctl status dbus.service # Check Dbus
uname -a # To know which kernel you are running
hostnamectl | grep "Operating System" # To get the code name
## Memory and space on disk
## The Master Tool # NCDU
#sudo ncdu -x /mnt
# To know what is inside a directory and how much it weighs
# sudo du -ah

# Magic
## Ziping files
find . -name "*.[jpg]" -print | zip source -@ # Will put all the JPG of the pi in a zip
## Remove lines from files
# This removes lines from a file where a value between , is less than 12 characters
awk -F "," 'length($2)>12' file.csv
# Lazy ListFiles
alias l="ls -a"
echo "alias la='ls -A'" > ~/.bashrc
# Reload bash
source ~/..bashrc

# To check the connection from ssh
# Can be used to trigger backup or restore point
#sudo cat /var/log/auth.log
