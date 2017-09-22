CloudWatch Example Project
==========================
This project is a simple/stupid example of setting up and using CloudWatch Logging, Metrics, and Alerts.  
Normally, you'd do this in an EC2 instance, but I thought it would be useful/convenient to automate and
demonstrate using Vagrant.

Prerequisites
-------------

- _Vagrant_

  The latest copy is the best bet.

- _AWS Credentials_

  The VM gets configured with AWS CLI credentials you provide on the command line.  The credentials 
  specified require appropriate CloudWatch permissions.

Getting Started
---------------
Once you've cloned this repo, just do a `vagrant up`.

OK, it's not necessarily quite that simple.  You'll want your AWS credentials to be present in your
environment.  If you use a credentials file, you'll want to do `vagrant up`, but provide the 
variables along the way:

```AWS_REGION="<region you like>" NOTIFICATION_EMAIL="your.email@yourdomain.com" DISCRIMINATOR="<some hopefully unique name>" AWS_ACCESS_KEY_ID="<your key>" AWS_SECRET_ACCESS_KEY="<your secret key>" vagrant up```

(note:  I've only tested in `us-east-1`, so it might be best to like it most  :-\ )

The `DISCRIMINATOR` variable is used to separate your stuff by some useful name.  Your first initial and last name is a good way to go.

Once started, Vagrant does the rest.  Note that you will receive an SNS subscription confirmation email at the address you provided
once the VM is configured.  _You must confirm the subscription in order to receive alert emails._

Experimenting
-------------
Once the VM is started, use `vagrant ssh` to get into the instance and look around.  While you're in there,
be sure to do some stuff as as root, such as add new users (`sudo useradd -m <someusername>`) or just become root 
with `sudo su`.  All these activities are monitored by the CloudWatch Log Metrics put in place by the provisioning 
script, so run a few cases through.

To see the effects of your activities as well as other activities performed by the included scripts, log into
the AWS console and navigate to CloudWatch.  Note the sub-sections of CloudWatch in the left-hand menu.

 - Check CloudWatch Logs:  type your discriminator into the filter box and hit enter.  You should see a few Log
   Groups reflected.  Click in to browse the logs.
 - Check out Metrics:  in the Metrics console click on PeChatMetrics.  Investigate the metrics that have been
   created by the script.  Some metrics are separated by dimension (based on `DISCRIMINATOR`) and some are not.  
   If you experimented as suggested above, the graphs should show some interesting activity (your own, and that 
   of others that are running the code). 
 - Experiment with Dashboards:  try creating a Dashboard (Actions in the Graph Options tab of Metrics).
