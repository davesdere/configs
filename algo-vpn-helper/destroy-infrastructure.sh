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

# Delete Cloudformation stack
aws cloudformation delete-stack --stack-name ${MY_ALGO_VPN_SHORTNAME}
