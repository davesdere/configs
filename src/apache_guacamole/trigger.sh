#!/bin/bash

# Set the AWS CLI profile
export AWS_PROFILE=my-cli-profile

# Set the SNS topic ARN
TOPIC_ARN=arn:aws:sns:us-east-1:1234567890:MyTopic

# Set the subject for the SNS message
SUBJECT='Successful Apache Guacamole connection'

# Set the command to extract the IP address from the audit record
EXTRACT_IP='grep -oP "(?<=src=)[^ ]+"'

# Set up a watch on the httpd file that triggers the script when a connection is made
auditctl -w /usr/sbin/httpd -p wa -k guacamole_connections -F auid!=4294967295 -F dir=+ -F success=1 -F perm=wa -F key=guacamole_connections -F exe=/usr/sbin/httpd -F subj_user=root -F exit,always -S all -F arch=b32 -F auid=0 -F exe_real=/usr/sbin/httpd -F obj_type=file -F obj_class=file -F filetype=regular -F obj=system_u:object_r:httpd_exec_t:s0 -F op=open -F success=yes -a always,exit -F dir=< -F perm=wa -F exe=< -F key=< -F arch=< -F auid=< -F exe_real=< -F obj_type=< -F obj_class=< -F filetype=< -F obj=< -F op=<

# Extract the IP address from the audit record
IP=`ausearch -k guacamole_connections | $EXTRACT_IP`

# Publish an SNS message with the IP address
aws sns publish --topic-arn $TOPIC_ARN --subject "$SUBJECT" --message "$IP"
