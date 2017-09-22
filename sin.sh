while true; do 
  SERIAL_TIME=$(date +%s)
  SIN=$(echo "s(${SERIAL_TIME}/10)*100" | bc -l)
  echo "SIN ${SERIAL_TIME} ${SIN}"
  sleep 1; 
done
