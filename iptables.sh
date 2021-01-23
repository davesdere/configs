sudo -i
echo The bare minimum
iptables -L
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -m conntrack --ctstate NEW -j DROP
iptables -A INPUT -m state --state NEW -j DROP
/sbin/iptables-save

