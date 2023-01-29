#/bin/bash
MY_ALGO_VPN_SHORTNAME=$1
MY_AWS_CLI_PROFILE=$2

# Check if shortname has been entered
if [ ! -z "${MY_ALGO_VPN_SHORTNAME}" ]; then
   echo "Working on ${MY_ALGO_VPN_SHORTNAME}"
else
    echo "No ALGO_VPN_SHORTNAME provided. Exiting"
    exit
fi

if [ "$MY_AWS_CLI_PROFILE" == "None"]; then
    echo "AWS Profile: ${MY_AWS_CLI_PROFILE}"
    AWS_CLI_PREFIX="aws"
fi
if [ ! -z "$MY_AWS_CLI_PROFILE" ]; then
   AWS_CLI_PREFIX="aws --profile ${MY_AWS_CLI_PROFILE}"
   echo "AWS CLI set to work with  profile ${MY_AWS_CLI_PROFILE}"

else
    AWS_CLI_PREFIX="aws"
    echo "AWS CLI set to work with default profile"
    if aws configure list | grep -q 'not set'; then 
        echo "No default profile configured. Exiting"
        exit 
    fi
fi


# Get instance ID
echo "Getting instance ID"
EC2_INSTANCE_ID=$(${AWS_CLI_PREFIX} ec2 describe-instances --filters Name=tag:Name,Values=${MY_ALGO_VPN_SHORTNAME} --query 'Reservations[0].Instances[0].InstanceId' --output text)
# Start instance
echo "Checking AWS EC2 Instance: ${EC2_INSTANCE_ID}"
${AWS_CLI_PREFIX} ec2 describe-instance-status --instance-ids ${EC2_INSTANCE_ID}