// Load the AWS SDK for JavaScript
var AWS = require('aws-sdk');

// Set the region
AWS.config.update({region: 'REGION'});

// Set the AWS credentials
AWS.config.update({accessKeyId: 'AWS_ACCESS_KEY', secretAccessKey: 'AWS_SECRET_KEY'});

// Create an EC2 client
var ec2 = new AWS.EC2({apiVersion: '2016-11-15'});

// Set the parameters for describing the instances
var params = {
  Filters: [
    {
      Name: 'tag:Name',
      Values: [
        'myvpn'
      ]
    }
  ]
};

// Describe the instances
ec2.describeInstances(params, function(err, data) {
  if (err) {
    console.log("Error", err);
  } else {
    // Get the instance IDs of the instances that have a tag with the key 'Name' and the value 'myvpn'
    var instanceIds = data.Reservations.map(reservation => reservation.Instances.map(instance => instance.InstanceId)).flat();
    
    // Set the parameters for stopping the instances
    var params = {
      InstanceIds: instanceIds
    };
    
    // Stop the instances
    ec2.stopInstances(params, function(err, data) {
      if (err) {
        console.log("Error", err);
      } else {
        console.log("Success", data);
      }
    });
  }
});
