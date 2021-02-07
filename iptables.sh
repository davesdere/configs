I=sudo 
echo # The bare minimum to get you working
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
# Allow all loopback (lo0) traffic and reject traffic
# to localhost that does not originate from lo0.
$I iptables -A INPUT -i lo -j ACCEPT
$I iptables -A INPUT ! -i lo -s 127.0.0.0/8 -j REJECT
# To test
$I iptables -A INPUT -s 192.168.0.0/16 -j DROP
$I iptables -A INPUT -s 10.0.0.0/16 -j DROP

#$I iptables -A INPUT -m state --state NEW -j DROP
# Drop invalid packets
$i iptables -A INPUT -m conntrack --ctstate INVALID -j DROP

echo # Your new configs
$I iptables -L
$I /sbin/iptables-save

