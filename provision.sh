#!/usr/bin/env bash

STATE_FILE=/tmp/provisioned

function idem() {
  if ! grep -q ${1} ${STATE_FILE}; then
    (${1})
    echo ${1} >> ${STATE_FILE}
  else
    echo "Skipping ${1} ..."
  fi
}


function setupAwsCredentials() {
  echo "Creating aws credentials in /root/.aws/credentials"
  mkdir -p /root/.aws/
  cat <<EOF > /root/.aws/credentials
[default]
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
EOF
}

function resolve() {
  sed "s/#.*#/${DISCRIMINATOR}/g" ${1} > ${2}
}

function setupAwsLogAgent() {
  echo "Creating cloudwatch config file in /root/awslogs.conf"
  resolve /vagrant/awslogs/awslogs.conf /root/awslogs.conf

  echo "Downloading cloudwatch logs setup agent"
  cd /root
  wget https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py
  echo "Running non-interactive cloudwatch-logs setup script"
  python ./awslogs-agent-setup.py --region us-east-1 --non-interactive --configfile=/root/awslogs.conf

  echo "Setting up cloudwatch config files"
  resolve /vagrant/awslogs/auth.conf /var/awslogs/etc/config/auth.conf
  resolve /vagrant/awslogs/syslog.conf /var/awslogs/etc/config/syslog.conf
  resolve /vagrant/awslogs/sin.conf /var/awslogs/etc/config/sin.conf
  service awslogs restart
}


function aptGetUpdate() {
  echo "Updating package database"
  apt-get update
}

function installMoreUtils() {
  echo "Installing moreutils (for ts)"
  apt-get install -y moreutils
}


function installAwsCli() {
  echo "Installing AWS CLI"
  pip install awscli
}


function setupCloudWatchMonitoring() {
TOPIC_ARN=$(aws sns create-topic --region ${AWS_REGION} --name ${DISCRIMINATOR}-pe-chat --output text)

aws sns subscribe \
  --region ${AWS_REGION} \
  --topic-arn ${TOPIC_ARN} \
  --protocol email \
  --notification-endpoint ${NOTIFICATION_EMAIL}

echo "An SNS topic was created for Alarm emails:  ${TOPIC_ARN}"
echo "** YOU MUST ACCEPT THE SUBSCRIPTION CONFIRMATION SENT TO ${NOTIFICATION_EMAIL} TO ACTUALLY SEE NOTIFICATIONS!!"

sleep 15
aws logs put-metric-filter \
  --region ${AWS_REGION} \
  --log-group-name ${DISCRIMINATOR}/pe-chat/auth.log \
  --filter-name auth-new-user \
  --filter-pattern "new user" \
  --metric-transformations metricName=AuthNewUser,metricNamespace=PeChatMetrics,metricValue=1,defaultValue=0

aws logs put-metric-filter \
  --region ${AWS_REGION} \
  --log-group-name ${DISCRIMINATOR}/pe-chat/auth.log \
  --filter-name auth-sudo \
  --filter-pattern '"pam_unix(sudo:session): session opened for user root"' \
  --metric-transformations metricName=AuthSudo,metricNamespace=PeChatMetrics,metricValue=1,defaultValue=0

aws logs put-metric-filter \
  --region ${AWS_REGION} \
  --log-group-name ${DISCRIMINATOR}/pe-chat/auth.log \
  --filter-name auth-ssh-login \
  --filter-pattern '"sshd:session"' \
  --metric-transformations metricName=AuthSsh,metricNamespace=PeChatMetrics,metricValue=1,defaultValue=0

aws cloudwatch put-metric-alarm \
  --region ${AWS_REGION} \
  --alarm-name ${DISCRIMINATOR}-alarm-auth-new-user \
  --alarm-description "Alarm when new user created on machine" \
  --alarm-actions ${TOPIC_ARN} \
  --metric-name AuthNewUser \
  --namespace PeChatMetrics \
  --statistic Sum \
  --period 60 \
  --evaluation-periods 1 \
  --threshold 0 \
  --comparison-operator GreaterThanThreshold
}


idem aptGetUpdate
idem installMoreUtils
idem setupAwsCredentials
idem setupAwsLogAgent
idem installAwsCli
idem setupCloudWatchMonitoring

# Fire up silly "sin(x)" logging
/vagrant/sin.sh | ts >> /tmp/sin.log &

# Fire up silly "sin(x) CW Metric publishing
/vagrant/sincw.sh ${DISCRIMINATOR} &

