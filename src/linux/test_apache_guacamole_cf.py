import unittest
import boto3

class TestCloudFormationScript(unittest.TestCase):

    def setUp(self):
        # Create a CloudFormation client
        self.cfn_client = boto3.client('cloudformation')

    def test_ec2_instance_created(self):
        # Get the list of stacks
        stacks = self.cfn_client.list_stacks()['StackSummaries']

        # Check that the stack with the name "my-stack" exists
        stack_exists = False
        for stack in stacks:
            if stack['StackName'] == 'my-stack':
                stack_exists = True
                break
        self.assertTrue(stack_exists)

        # Get the stack resource list
        resources = self.cfn_client.list_stack_resources(StackName='my-stack')['StackResourceSummaries']

        # Check that the EC2 instance resource with the name "GuacamoleEC2Instance" exists
        instance_exists = False
        for resource in resources:
            if resource['LogicalResourceId'] == 'GuacamoleEC2Instance':
                instance_exists = True
                break
        self.assertTrue(instance_exists)

    def test_guacamole_installed(self):
        # Connect to the EC2 instance using the boto3 EC2 client
        ec2_client = boto3.client('ec2')
        instances = ec2_client.describe_instances()['Reservations'][0]['Instances']
        instance_id = instances[0]['InstanceId']

        # Connect to the EC2 instance using the boto3 SSM client
        ssm_client = boto3.client('ssm')

        # Check that the guacd service is running
        guacd_running = ssm_client.send_command(
            InstanceIds=[instance_id],
            DocumentName='AWS-RunShellScript',
            Parameters={'commands': ['systemctl is-active guacd']}
        )['Command']['Status'] == 'Success'
        self.assertTrue(guacd_running)

        # Check that the tomcat8 service is running
        tomcat8_running = ssm_client.send_command(
            InstanceIds=[instance_id],
            DocumentName='AWS-RunShellScript',
            Parameters={'commands': ['systemctl is-active tomcat8']}
        )['Command']['Status'] == 'Success'
        self.assertTrue(tomcat8_running)

    def tearDown(self):
        # Delete the CloudFormation stack
        self.cfn_client.delete_stack(StackName='my-stack')

if __name__ == '__main__':
    unittest.main()
