# Davesdere
# TODO: Make all the functions region aware
import boto3
import urllib.request
import datetime
import json
import argparse
import configparser

global aws_access_key_id
global aws_secret_access_key

def find_vpn_stack_by_name():
    pass

# deploy vpn instances
def deploy_with_config():
    pass

def restrict_sg(ec2, ips_list, mode):
    # TODO: Implement logic
    if mode == 'add':
        pass
    elif mode == "remove":
        pass
    elif mode == "replace":
        pass
    else:
        print("Wrong op mode provided. Please choose one of the following: 'add', 'remove' and 'replace'")

    return None
    
# list vpn instances
def list_all_vpn(regions=None):
    # Set the tag key and value
    tag_key = "Environment"
    tag_value = "Algo"

    # If the regions list is not provided, get the list of all regions
    if regions is None:
        regions = [region['RegionName'] for region in ec2.describe_regions()['Regions']]
    else:
        pass

    # Loop through each region
    for region in regions:
        # Create a CloudFormation client in the region

        cloudformation = start_cloudformation_session(aws_access_key_id, aws_secret_access_key, region)
        ec2 = start_ec2_session(aws_access_key_id, aws_access_key_id,region)
        # Initialize the pagination variables
        next_token = None
        stacks = []

        # Loop until there are no more pages of results
        while True:
            # Call the list_stacks method and pass in the tag key and value, and the NextToken value if it exists
            if next_token:
                response = cloudformation.list_stacks(StackStatusFilter=['CREATE_COMPLETE', 'UPDATE_COMPLETE'],
                                        TagFilters=[{'Key': tag_key, 'Value': tag_value}],
                                        NextToken=next_token)
            else:
                response = cloudformation.list_stacks(StackStatusFilter=['CREATE_COMPLETE', 'UPDATE_COMPLETE'],
                                        TagFilters=[{'Key': tag_key, 'Value': tag_value}])

            # Append the stack summaries to the list
            stacks += response['StackSummaries']

            # Set the next token value
            next_token = response.get('NextToken', None)

            # Break the loop if there are no more pages of results
            if not next_token:
                break

        # Print the name and ID of each stack in the region
        list_of_ec2=[]
        for stack in stacks:
            print(f'Region: {region}, Stack name: {stack["StackName"]}, Stack ID: {stack["StackId"]}')
            list_of_ec2.append(list_ec2_resources_in_stack(cloudformation, ec2, stack['StackId']))
        return list_of_ec2

def list_ec2_resources_in_stack(cloudformation, ec2, stack_id):

    # Call the describe_stack_resources method and pass in the stack ID
    resources = cloudformation.describe_stack_resources(StackName=stack_id)
    list_of_ec2 = []
    ec2_details = {"Name": "null", "Id":"null"}
    # Print the resource type and ID of each EC2 resource
    for resource in resources['StackResources']:
        ec2_details = {"Name": "null", "Id":"null"}
        if resource['ResourceType'] == 'AWS::EC2::Instance':
            print(f'EC2 resource: {resource["ResourceType"]}, ID: {resource["PhysicalResourceId"]}')
            tags = ec2.describe_tags(Filters=[{'Name': 'resource-id', 'Values': [resource['PhysicalResourceId']]}])
            name_tag = [tag['Value'] for tag in tags['Tags'] if tag['Key'] == 'name']
            name_tag_value = name_tag[0] if name_tag else 'N/A'
            ec2_details["Name"] = name_tag_value
            ec2_details["Id"] = resource["PhysicalResourceId"]
            list_of_ec2 += ec2_details
    return list_of_ec2


def get_public_ip():
    # TODO: Error handling
    with urllib.request.urlopen("https://checkip.amazonaws.com") as url:
        return url.read().decode("utf-8").strip()

def load_credentials(path_to_file, profile_name):
    # TODO: Error handling
    # ~/.aws/credentials
    global aws_access_key_id
    global aws_secret_access_key
    # Parse the AWS CLI credentials file
    config = configparser.ConfigParser()
    config.read(f'{path_to_file}')

    # Get the access key and secret key for the desired profile
    profile_name = f'{profile_name}'
    access_key_id = config[f'{profile_name}']['aws_access_key_id']
    secret_access_key = config[f'{profile_name}']['aws_secret_access_key']

    return access_key_id, secret_access_key

def start_ec2_session(access_key_id, secret_access_key,in_region):
    # Set up the client for the AWS EC2 service
    ec2 = boto3.client('ec2', aws_access_key_id=f'{access_key_id}', aws_secret_access_key=f'{secret_access_key}', region_name=f'{in_region}')
    return ec2

def start_cloudformation_session(access_key_id, secret_access_key, in_region):
    cloudformation = boto3.client('cloudformation', aws_access_key_id=f'{access_key_id}', aws_secret_access_key=f'{secret_access_key}', region_name=f'{in_region}')
    return cloudformation

def get_all_aws_regions(ec2):
    regions = [region['RegionName'] for region in ec2.describe_regions()['Regions']]
    return regions

# start vpn instances
def start_instance(ec2, instance_id):
    ec2.start_instances(InstanceIds=[f'{instance_id}'])

# stop vpn instances
def stop_instance(ec2, instance_id):
    ec2.stop_instances(InstanceIds=[f'{instance_id}'])


# destroy vpn instances
def destroy_stack(cloudformation, short_name):
    # Create a CloudFormation client
    cloudformation = boto3.client('cloudformation')

    # Delete the stack with the specified name
    response = cloudformation.delete_stack(StackName=f'{short_name}')
   # Wait for the delete_stack operation to complete
    waiter = cloudformation.get_waiter('stack_delete_complete')
    waiter.wait(StackName=f'{short_name}')

    # Get the status code of the delete_stack operation
    status_code = response['ResponseMetadata']['HTTPStatusCode']
    
    return status_code

def find_instances_ids(ec2, short_name):

    # Search for EC2 instances with a tag key of "Name" and a value of short_name
    response = ec2.describe_instances(
        Filters=[
            {
                'Name': 'tag:Name',
                'Values': [f'{short_name}']
            },
        ]
    )
    # Get the instance IDs of the matching instances
    instance_ids = [instance['InstanceId'] for reservation in response['Reservations'] for instance in reservation['Instances']]

    return instance_ids

def check_status_of_ec2(ec2, short_name):
    # Search for EC2 instances with a tag key of "Name" and a value of short_name
    response = ec2.describe_instances(
        Filters=[
            {
                'Name': 'tag:Name',
                'Values': [f'{short_name}']
            },
        ]
    )
    for reservation in response['Reservations']:
        print(reservation)
    

def create_sg(ec2, sg_name, vpc_id, allow_ips, short_name):

    #TODO: Add logic to add multiple ips in one security group
    allow_ip = allow_ips[0]
    # Randomize name with timestamp
    # Get the current timestamp
    ts_suffix = datetime.datetime.utcnow().isoformat()
    # Create a security group allowing ingress Wireguard connections from the local public IP
    response = ec2.create_security_group(
        GroupName=f'{sg_name}{ts_suffix}',
        Description='Security group for Ingress Wireguard',
        VpcId=f'{vpc_id}'
    )
    security_group_id = response['GroupId']

    ec2.authorize_security_group_ingress(
        GroupId=security_group_id,
        IpPermissions=[
            {
                'IpProtocol': 'udp',
                'FromPort': 51820,
                'ToPort': 51820,
                'IpRanges': [
                    {
                        'CidrIp': f'{allow_ip}/32',
                        'Description': 'Wireguard connection from local public IP'
                    },
                ]
            },
        ]
    )
    # Add a tag to the security group
    ec2.create_tags(
        Resources=[security_group_id],
        Tags=[
            {
                'Key': 'CreationDate',
                'Value': ts_suffix
            },
            {
                'Key': 'Name',
                'Value': short_name
            },
        ]
    )

    return security_group_id


def attach_sg(ec2, instance_id, security_group_id):
    # Attach the security group to the EC2 instance
    ec2.modify_instance_attribute(
        InstanceId=f'{instance_id}',
        Groups=[security_group_id]
    )
    return security_group_id


def find_sg(ec2, target_cidr_block):
    # e.g. target_cidr_block = "1.2.3.4/32"
    # Search for security groups that allow incoming traffic from the IP address
    response = ec2.describe_security_groups(
        Filters=[
            {
                'Name': 'ip-permission.cidr',
                'Values': [f'{target_cidr_block}']
            },
        ]
    )
    security_group_ids = [sg['GroupId'] for sg in response['SecurityGroups']]
    for sg in security_group_ids:
        print(f'ID: {sg[0]}, Name: {sg[1]}')

    return security_group_ids


def search_in_logs():
    pass

def main():
    # Get the current timestamp
    timestamp = datetime.datetime.utcnow().isoformat()

    parser = argparse.ArgumentParser()
    parser.add_argument('--credentials', required=True, help='IAM: AWS credentials json file')
    parser.add_argument('--profile', required=True, help='IAM: Local AWS profile name')
    parser.add_argument('--operation', required=True, help='Function: Operation to do')
    parser.add_argument('--op_mode', required=False, help='Function: Operation mode for restrict_sg operation')
    parser.add_argument('--ip_list', required=False, help='Data: IP list')
    parser.add_argument('--short_name', required=False, help='Tags: The value of the Name key on the EC2')
    parser.add_argument('--config', required=False, help='Data: The JSON configuration file to configure Algo')

    parser.add_argument('--help', required=False, help='Help me help you out')
    parser.add_argument('--verbose', action='store_true', help='Verbose output')

    # Parse the command-line arguments
    args = parser.parse_args()

    # Extract the value of the arguments

    short_name = args.short_name
    operation = args.operation
    
    print(f'# Public IP: {get_public_ip()}')
    print(f'# Short name: {short_name}')
    print(f'# Operation: {operation}')
    print(f'# Timestamp: {timestamp}')
    print(f'# Credential files: {args.credentials}')


    #aws_access_key_id, aws_secret_access_key = load_credentials(args.credentials, args.profile)
    # Change global variable instead
    load_credentials(args.credentials, args.profile)

    if operation not in ['start_instance', 'stop_instance', 'deploy_vpn', 'delete_vpn','restrict_sg', 'check_status', 'list_all_vpn']:
        print('Wrong operation pal!')
        exit
    
    if operation == 'start_instance':
        ec2 = start_ec2_session(aws_access_key_id, aws_secret_access_key)
        instance_ids = find_instances_ids(ec2, short_name)
        for instance_id in instance_ids:
            start_instance(ec2, instance_id)
        print(f'Operation {operation} done.')

    if operation == 'stop_instance':
        ec2 = start_ec2_session(aws_access_key_id, aws_secret_access_key)
        instance_ids = find_instances_ids(ec2, short_name)
        for instance_id in instance_ids:
            stop_instance(ec2, instance_id)
        print(f'Operation {operation} done.')

    if operation == 'deploy_vpn':
        # TODO: Examine config file
        cf = start_cloudformation_session(aws_access_key_id, aws_secret_access_key)
        print("#"*60)
        print("#"," "*5,"Not implemented"," "*5,"#")
        print("#"*60)
        pass

    if operation == 'delete_vpn':
        cf = start_cloudformation_session(aws_access_key_id, aws_secret_access_key)
        destroy_stack(cf, short_name)
        print(f'Operation {operation} done.')
    
    if operation == 'restrict_sg':
        # TODO: Make test cases
        ec2 = start_ec2_session(aws_access_key_id, aws_secret_access_key)
        if len(args.ip_list) == 0:
            print("No IPs provided, exiting")
            exit
        if len(args.op_mode) == 0:
            print("No operation mode provided, exiting")
            exit
        # restrict_sg(ec2, args.ip_list, args.op_mode)
        print("#"*60)
        print("#"," "*5,"Not implemented"," "*5,"#")
        print("#"*60)
    
    if operation == 'check_status':
        ec2 = start_ec2_session(aws_access_key_id, aws_secret_access_key)
        check_status_of_ec2(ec2, short_name)
        print(f'Operation {operation} done.')

    if operation == 'list_all_vpn':
        cloudformation = start_cloudformation_session(aws_access_key_id, aws_secret_access_key)
        if len(args.op_mode) == 0:
            list_all_vpn(regions=None)
        elif 'region' in args.op_mode:
            region= args.op_mode.split('=')[-1]
            list_all_vpn(cloudformation, ec2=None, regions=[region])
        print(f'Operation {operation} done.')

if __name__ == '__main__':   
    main()

