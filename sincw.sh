ENV=$1
while true; do 
  SERIAL_TIME=$(date +%s)
  SIN=$(echo "s(${SERIAL_TIME}/10)" | bc -l)
  #echo "SIN ${SERIAL_TIME} ${SIN}"
  aws cloudwatch put-metric-data --region us-east-1 --metric-name Sine --namespace PeChatMetrics --value ${SIN} --timestamp $(date +"%Y-%m-%dT%T.000Z") --dimensions environment=${ENV}
  sleep 5; 
done
