#!/usr/bin/env bash

echo "Waiting for kafka Connect to start listening on localhost"

while : ; do
  curl_status=$(curl -s -o /dev/null -w %{http_code} http://localhost:8083/connectors)
  echo -e "$(date)" " Kafka connect listener HTTP status: " "$curl_status" " (waiting for 5s)"
  if [ "$curl_status" -eq 200 ] ; then
    break
  fi
  sleep 5
done

echo -e "\n--\n+> Creating Data Connectors"
curl -s \
     -X PUT \
     -H "Content-Type: application/json" \
     -d "$(cat connectors/"${CONNECTOR_NAME}.json")" \
     http://localhost:8083/connectors/"${CONNECTOR_NAME}"/config
