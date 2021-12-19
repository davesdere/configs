echo "Evaluated if script is run as root"
echo "The user is $SUDO_USER"
if [ -z $SUDO_USER ]; then echo "The script is not running as root"; else echo "Script running as root";fi
