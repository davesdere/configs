// Load the AWS SDK for JavaScript
var AWS = require('aws-sdk');

// Set the region
AWS.config.update({region: 'REGION'});

// Set the AWS credentials
AWS.config.update({accessKeyId: 'AWS_ACCESS_KEY', secretAccessKey: 'AWS_SECRET_KEY'});

// Create an EC2 client
var ec2 = new AWS.EC2({apiVersion: '2016-11-15'});

// Define a function to get the public IP address of the device
function getPublicIp() {
  return fetch('https://api.ipify.org?format=json')
    .then(response => response.json())
    .then(data => data.ip);
}
// Define a function to modify the security group rules to allow incoming traffic only from the specified IP address
function modifySecurityGroup(securityGroupId, publicIp) {
  // Set the parameters for describing the security group
  var params = {
    GroupIds: [
      securityGroupId
    ]
  };
  
  // Get information about the security group
  return ec2.describeSecurityGroups(params).promise()
    .then(data => {
      // For each security group rule, check if it allows incoming traffic from the specified IP address
      var rulesToRevoke = data.SecurityGroups[0].IpPermissions.filter(rule => {
        if (rule.IpRanges.length > 0) {
          var cidrIp = rule.IpRanges[0].CidrIp;
          return cidrIp !== `${publicIp}/32`;
        }
        return false;
      });
      
      // Revoke the security group rules that do not allow incoming traffic from the specified IP address
      var revokePromises = rules

      
    /////////////
      // Define a function to modify the security group rules to allow incoming traffic only from the specified IP address
function modifySecurityGroup(securityGroupId, publicIp) {
  // Set the parameters for describing the security group
  var params = {
    GroupIds: [
      securityGroupId
    ]
  };
  
  // Get information about the security group
  return ec2.describeSecurityGroups(params).promise()
    .then(data => {
      // For each security group rule, check if it allows incoming traffic from the specified IP address
      var rulesToRevoke = data.SecurityGroups[0].IpPermissions.filter(rule => {
        if (rule.IpRanges.length > 0) {
          var cidrIp = rule.IpRanges[0].CidrIp;
          return cidrIp !== `${publicIp}/32`;
        }
        return false;
      });
      
      // Revoke the security group rules that do not allow incoming traffic from the specified IP address
      var revokePromises = rulesToRevoke.map(rule => {
        var params = {
          GroupId: securityGroupId,
          IpPermissions: [
            {
              IpProtocol: rule.IpProtocol,
              FromPort: rule.FromPort,
              ToPort: rule.ToPort,
              IpRanges: [
                {
                  CidrIp: rule.IpRanges[0].CidrIp
                }
              ]
            }
          ]
        };
        return ec2.revokeSecurityGroupIngress(params).promise();
      });
      
      // Execute the revokeSecurityGroupIngress method for each security group rule
      return Promise.all(revokePromises)
        .then(() => {
          // Allow incoming traffic from the specified IP address
          var params = {
            GroupId: securityGroupId,
            IpPermissions: [
              {
                IpProtocol: 'tcp',
                FromPort: 0,
      /////////////
                // Define a function to modify the security group rules to allow incoming traffic only from the specified IP address
function modifySecurityGroup(securityGroupId, publicIp) {
  // Set the parameters for describing the security group
  var params = {
    GroupIds: [
      securityGroupId
    ]
  };
  
  // Get information about the security group
  return ec2.describeSecurityGroups(params).promise()
    .then(data => {
      // For each security group rule, check if it allows incoming traffic from the specified IP address
      var rulesToRevoke = data.SecurityGroups[0].IpPermissions.filter(rule => {
        if (rule.IpRanges.length > 0) {
          var cidrIp = rule.IpRanges[0].CidrIp;
          return cidrIp !== `${publicIp}/32`;
        }
        return false;
      });
      
      // Revoke the security group rules that do not allow incoming traffic from the specified IP address
      var revokePromises = rulesToRevoke.map(rule => {
        var params = {
          GroupId: securityGroupId,
          IpPermissions: [
            {
              IpProtocol: rule.IpProtocol,
              FromPort: rule.FromPort,
              ToPort: rule.ToPort,
              IpRanges: [
                {
                  CidrIp: rule.IpRanges[0].CidrIp
                }
              ]
            }
          ]
        };
        return ec2.revokeSecurityGroupIngress(params).promise();
      });
      
      // Execute the revokeSecurityGroupIngress method for each security group rule
      return Promise.all(revokePromises)
        .then
///////////////
    
// Set the parameters for creating the security group
var params = {
  Description: 'Security group for WireGuard',
  GroupName: 'wireguard-sg'
};

// Create the security group
ec2.createSecurityGroup(params, function(err, data) {
  if (err) {
    console.log("Error", err);
  } else {
    var securityGroupId = data.GroupId;
    console.log("Success", data);
    
    // Set the parameters for allowing incoming traffic from the specified IP address for WireGuard
    var params = {
      GroupId: securityGroupId,
      IpPermissions: [
        {
          IpProtocol: 'udp',
          FromPort: 51820,
          ToPort: 51820,
          IpRanges: [
            {
              CidrIp: 'PUBLIC_IP/32'
            }
          ]
        }
      ]
    };
    
    // Allow incoming traffic from the specified IP address for WireGuard
    ec2.authorizeSecurityGroupIngress(params, function(err, data) {
      if (err) {
        console.log("Error", err);
      } else {
        console.log("Success", data);
      }
    });
  }
});

