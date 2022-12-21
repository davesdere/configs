#!/bin/bash

# Create the auditd rule
RULE='-w /usr/sbin/httpd -p wa -k guacamole_connections'

# Append the rule to the audit.rules file
echo "$RULE" >> /etc/audit/rules.d/audit.rules

# Restart the auditd service
systemctl restart auditd
