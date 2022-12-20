# With QPython.  

Boto3 stopped supporting Python 3.6 at version 1.16.5

```pip3 boto3==1.16.15```

```
import boto3
import urllib.request

def get_public_ip():
    with urllib.request.urlopen("https://checkip.amazonaws.com") as url:
        return url.read().decode("utf-8").strip()

print(get_public_ip())


def start_session():
    pass

# list vpn instances
def list_vpn_instances():
    pass

# start vpn instances
def start_instance():
    pass

# stop vpn instances
def stop_instance():
    pass

def find_vpn_stack_by_name():
    pass

# destroy vpn instances
def destroy_stack():
    pass

# deploy vpn instances
def deploy_with_config():
    pass

def get_public_ip():
    pass

def restrict_sg():
    pass

def search_in_logs():
    pass

# Set up the client for the AWS EC2 service
ec2 = boto3.client('ec2', region_name='us-east-1')


# Create a security group allowing ingress Wireguard connections from the local public IP
response = ec2.create_security_group(
    GroupName='my-security-group',
    Description='Security group for Wireguard connections',
    VpcId='vpc-12345678'
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
                    'CidrIp': f'{my_ip}/32',
                    'Description': 'Wireguard connection from local public IP'
                },
            ]
        },
    ]
)

import datetime

# Get the current timestamp
timestamp = datetime.datetime.utcnow().isoformat()

# Add a tag to the security group
ec2.create_tags(
    Resources=[security_group_id],
    Tags=[
        {
            'Key': 'CreationDate',
            'Value': timestamp
        },
    ]
)

# Attach the security group to the EC2 instance
ec2.modify_instance_attribute(
    InstanceId='i-12345678',
    Groups=[security_group_id]
)





# Set up the client for the AWS S3 service
s3 = boto3.client('s3', region_name='us-east-1')
Use the client to perform the desired actions. For example, to list all the objects in a bucket:
Copy code
# List all the objects in a bucket
objects = s3.list_objects(Bucket='my-bucket')
print(objects)
Handle any errors that may occur. For example:
Copy code
try:
    # Perform some action
    result = s3.do_something()
except Exception as e:
    # Handle the error
    print(e)
I hope this helps! Let me know if you have any questions or need further assistance.

- get local public IP
- add a security group to a EC2 allowing ingress Wireguard connection to the IP found in the previous step

To get the local public IP address and add a security group to an Amazon Elastic Compute Cloud (EC2) instance allowing ingress Wireguard connection to that IP using the Python boto3 library, you can use the following steps:

Import the necessary modules and set up the client for the AWS EC2 service:
Copy code
import boto3

# Set up the client for the AWS EC2 service
ec2 = boto3.client('ec2', region_name='us-east-1')
Get the local public IP address using the urllib library, as shown in the previous example:
Copy code
import urllib.request

def get_public_ip():
    with urllib.request.urlopen("http://checkip.dyndns.org") as url:
        return url.read().decode("utf-8").strip()

my_ip = get_public_ip()
Create a security group allowing ingress Wireguard connections from the local public IP address:
Copy code
# Create a security group allowing ingress Wireguard connections from the local public IP
response = ec2.create_security_group(
    GroupName='my-security-group',
    Description='Security group for Wireguard connections',
    VpcId='vpc-12345678'
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
                    'CidrIp': f'{my_ip}/32',
                    'Description': 'Wireguard connection from local public IP'
                },
            ]
        },
    ]
)
This will create a security group with a rule allowing ingress Wireguard connections from the local public IP address.

I hope this helps! Let me know if you have any questions or need further assistance.





Add tags to the security group. The key is CreationDate and the value is a timestamp.

To add a tag to a security group in Amazon Elastic Compute Cloud (EC2) with the key "CreationDate" and a value of a timestamp, you can use the create_tags method of the EC2 client. Here's an example of how you can do this:

Copy code
import datetime

# Get the current timestamp
timestamp = datetime.datetime.utcnow().isoformat()

# Add a tag to the security group
ec2.create_tags(
    Resources=[security_group_id],
    Tags=[
        {
            'Key': 'CreationDate',
            'Value': timestamp
        },
    ]
)
This will add a tag to the security group with the key "CreationDate" and a value of the current timestamp in ISO format.

I hope this helps! Let me know if you have any questions or need further assistance.





Write the code to attach the security group to an ec2 instance

To attach a security group to an Amazon Elastic Compute Cloud (EC2) instance using the Python boto3 library, you can use the modify_instance_attribute method of the EC2 client. Here's an example of how you can do this:

Copy code
# Attach the security group to the EC2 instance
ec2.modify_instance_attribute(
    InstanceId='i-12345678',
    Groups=[security_group_id]
)
This will attach the security group with the ID security_group_id to the EC2 instance with the ID i-12345678.

I hope this helps! Let me know if you have any questions or need further assistance.





Find ec2 instance based on tag value

To find an Amazon Elastic Compute Cloud (EC2) instance based on a tag value using the Python boto3 library, you can use the describe_instances method of the EC2 client and filter the results based on the tag value. Here's an example of how you can do this:

Copy code
import boto3

# Set up the client for the AWS EC2 service
ec2 = boto3.client('ec2', region_name='us-east-1')

# Search for EC2 instances with a tag key of "Name" and a value of "MyInstance"
response = ec2.describe_instances(
    Filters=[
        {
            'Name': 'tag:Name',
            'Values': ['MyInstance']
        },
    ]
)

# Get the instance IDs of the matching instances
instance_ids = [instance['InstanceId'] for reservation in response['Reservations'] for instance in reservation['Instances']]

# Print the instance IDs
print(instance_ids)

# Search for EC2 instances with a tag key of "Name" and a value of "MyInstance"
response = ec2.describe_instances(
    Filters=[
        {
            'Name': 'tag:Name',
            'Values': ['MyInstance']
        },
    ]
)

# Get the instance IDs of the matching instances
instance_ids = [instance['InstanceId'] for reservation in response['Reservations'] for instance in reservation['Instances']]

# Print the instance IDs
print(instance_ids)
This will search for all EC2 instances that have a tag with the key "Name" and the value "MyInstance", and it will print the instance IDs of the matching instances.

response = ec2.describe_instances(
    Filters=[
        {
            'Name': 'tag:Name',
            'Values': ['MyInstance']
        },
    ]
)
# Get the instance IDs of the matching instances
instance_ids = [instance['InstanceId'] for reservation in response['Reservations'] for instance in reservation['Instances']]

# Detach the security group from the EC2 instance
ec2.modify_instance_attribute(
    InstanceId=instance_ids[0],
    Groups=[]
)


# Delete the security group
ec2.delete_security_group(GroupId=security_group_id)


# Search for security groups that allow incoming traffic from the IP address 1.2.3.4
response = ec2.describe_security_groups(
    Filters=[
        {
            'Name': 'ip-permission.cidr',
            'Values': ['1.2.3.4/32']
        },
    ]
)

# Get the IDs and names of the matching security groups
security_groups = [(sg['GroupId'], sg['GroupName']) for sg in response['SecurityGroups']]

# Print the IDs and names of the matching security groups
for sg in security_groups:
    print(f'ID: {sg[0]}, Name: {sg[1]}')



```
