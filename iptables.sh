I=sudo 
echo The bare minimum
$I iptables -L
$I iptables -F
$I iptables -P INPUT DROP
$I iptables -P FORWARD DROP
$I iptables -P OUTPUT ACCEPT
$I iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$I iptables -A INPUT -m conntrack --ctstate NEW -j DROP
# DNS
#$I iptables -A INPUT -p tcp -m tcp --sport 53 -j ACCEPT
#$I iptables -A INPUT -p udp -m udp --dport 53 -j ACCEPT
$I iptables -A OUTPUT -p tcp -m tcp --sport 53 -j ACCEPT
$I iptables -A OUTPUT -p udp -m udp --dport 53 -j ACCEPT
#$I iptables -A INPUT -m state --state NEW -j DROP
$I /sbin/iptables-save

