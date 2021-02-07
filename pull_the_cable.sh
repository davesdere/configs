I=sudo 
echo # The bare minimum to get you working
$I iptables -L
$I iptables -F
$I iptables -P INPUT DROP
$I iptables -P FORWARD DROP
$I /sbin/iptables-save

$I iptables -L

