#!/bin/bash

# Create the auditd rule
RULE='-w /usr/sbin/httpd -p wa -k guacamole_connections'

# Append the rule to the audit.rules file
echo "$RULE" >> /etc/audit/rules.d/audit.rules

# Restart the auditd service
systemctl restart auditd

# Set the AWS CLI profile
export AWS_PROFILE=my-cli-profile

# Set the SNS topic ARN
TOPIC_ARN=arn:aws:sns:us-east-1:1234567890:MyTopic

# Set the subject for the SNS message
SUBJECT='Successful Apache Guacamole connection'

# Set the command to extract the IP address from the audit record
EXTRACT_IP='grep -oP "(?<=src=)[^ ]+"'


IP=`ausearch -k guacamole_connections | $EXTRACT_IP`

# Publish an SNS message with the IP address
aws sns publish --topic-arn $TOPIC_ARN --subject "$SUBJECT" --message "$IP"
