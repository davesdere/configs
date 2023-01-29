#/bin/bash
MY_ALGO_VPN_SHORTNAME=$1
MY_AWS_CLI_PROFILE=$2
CURRENT_DATE=$(date +"%F-%H%M%S")
MY_PUBLIC_IP=$(curl https://checkip.amazonaws.com)

main(){
    # Get current VPC Id
    MY_CURRENT_VPN_VPC_ID=$(${AWS_CLI_PREFIX} ec2 describe-vpcs --filters Name=tag:Name,Values=${MY_ALGO_VPN_SHORTNAME} --query  'Vpcs[0].VpcId' --output text)
    echo "The VPC ID containing the VPN is ${MY_CURRENT_VPN_VPC_ID}"

    # Get current security group
    OLD_SECURITY_GROUP=$(${AWS_CLI_PREFIX} ec2 describe-instances --filters Name=tag:Name,Values=${MY_ALGO_VPN_SHORTNAME} --query 'Reservations[0].Instances[0].SecurityGroups[0].GroupId' --output text) # Todo: Check if there is more than one
    echo ${OLD_SECURITY_GROUP}


    echo "Current Security group attached"
    ${AWS_CLI_PREFIX} ec2 describe-instances --filters Name=tag:Name,Values=${MY_ALGO_VPN_SHORTNAME} --query 'Reservations[0].Instances[0].SecurityGroups'

    # Create new Security Group
    MY_NEW_SG_ID=$(${AWS_CLI_PREFIX} ec2 create-security-group --group-name ${MY_ALGO_VPN_SHORTNAME}-${CURRENT_DATE} --description "Enable SSH and IPsec" --vpc-id "${MY_CURRENT_VPN_VPC_ID}" --query 'GroupId' --output text)
    echo "New SG created ${MY_NEW_SG_ID}"

    # Add rules to new SG
    echo "Adding rules to SG"
    ${AWS_CLI_PREFIX} ec2 authorize-security-group-ingress --group-id ${MY_NEW_SG_ID} --protocol udp --port 51820 --cidr ${MY_PUBLIC_IP}/32
    ${AWS_CLI_PREFIX} ec2 authorize-security-group-ingress --group-id ${MY_NEW_SG_ID} --protocol tcp --port 4160 --cidr ${MY_PUBLIC_IP}/32
    ${AWS_CLI_PREFIX} ec2 authorize-security-group-ingress --group-id ${MY_NEW_SG_ID} --protocol udp --port 500 --cidr ${MY_PUBLIC_IP}/32
    ${AWS_CLI_PREFIX} ec2 authorize-security-group-ingress --group-id ${MY_NEW_SG_ID} --protocol udp --port 4500 --cidr ${MY_PUBLIC_IP}/32

    # Get instance ID
    echo "Getting instance ID"
    EC2_INSTANCE_ID=$(${AWS_CLI_PREFIX} ec2 describe-instances --filters Name=tag:Name,Values=${MY_ALGO_VPN_SHORTNAME} --query 'Reservations[0].Instances[0].InstanceId' --output text)

    # Assign new Security Group and detach old one
    echo "Assigning new Security Group and detaching old one"
    ${AWS_CLI_PREFIX} ec2 modify-instance-attribute --instance-id ${EC2_INSTANCE_ID} --groups ${MY_NEW_SG_ID}

    # Validate
    echo "Current Security group attached"
    ${AWS_CLI_PREFIX} ec2 describe-instances --filters Name=tag:Name,Values=${MY_ALGO_VPN_SHORTNAME} --query 'Reservations[0].Instances[0].SecurityGroups'

    # Delete old security group. You need to detach it first
    echo "Deleting old Security group: ${OLD_SECURITY_GROUP}"
    ${AWS_CLI_PREFIX} ec2 delete-security-group --group-id ${OLD_SECURITY_GROUP}
    echo done

}

# Check if shortname has been entered
if [ ! -z "${MY_ALGO_VPN_SHORTNAME}" ]; then
   echo "Working on ${MY_ALGO_VPN_SHORTNAME}"
else
    echo "No ALGO_VPN_SHORTNAME provided. Exiting"
    exit
fi


if [ "$MY_AWS_CLI_PROFILE" == "None" ]; then
    echo "AWS Profile: ${MY_AWS_CLI_PROFILE}"
    AWS_CLI_PREFIX="aws"
    main
fi
if [ ! -z "$MY_AWS_CLI_PROFILE" ]; then
   AWS_CLI_PREFIX="aws --profile ${MY_AWS_CLI_PROFILE}"
   echo "AWS CLI set to work with  profile ${MY_AWS_CLI_PROFILE}"
   main

else
    AWS_CLI_PREFIX="aws"
    echo "AWS CLI set to work with default profile"
    if aws configure list | grep -q 'not set'; then 
        echo "No default profile configured. Exiting"
        exit 
    fi
fi
