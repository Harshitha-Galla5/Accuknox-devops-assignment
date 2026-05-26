#!/bin/bash

# Check if URL argument is provided
if [ -z "$1" ]; then
    echo "Usage: ./application-health-checker.sh <URL>"
    exit 1
fi

URL=$1
LOG_FILE="application_health.log"

# Timestamp
TIMESTAMP=$(date)

# Send HTTP request and capture status code
STATUS_CODE=$(curl -k -o /dev/null -s -w "%{http_code}" --max-time 10 $URL)

# Capture response time
RESPONSE_TIME=$(curl -k -o /dev/null -s -w "%{time_total}" --max-time 10 $URL)

echo "=========================================="
echo "Application Health Check"
echo "=========================================="
echo "Timestamp      : $TIMESTAMP"
echo "Application URL: $URL"
echo "HTTP Status    : $STATUS_CODE"
echo "Response Time  : ${RESPONSE_TIME}s"

# Determine application status

if [[ "$STATUS_CODE" =~ ^2[0-9][0-9]$ ]]; then

    APP_STATUS="UP"
    MESSAGE="Application is functioning correctly."

elif [[ "$STATUS_CODE" =~ ^3[0-9][0-9]$ ]]; then

    APP_STATUS="UP"
    MESSAGE="Application is reachable but redirected."

elif [ "$STATUS_CODE" -eq 404 ]; then

    APP_STATUS="DOWN"
    MESSAGE="Page not found."

elif [ "$STATUS_CODE" -eq 500 ]; then

    APP_STATUS="DOWN"
    MESSAGE="Internal server error."

elif [ "$STATUS_CODE" -eq 503 ]; then

    APP_STATUS="DOWN"
    MESSAGE="Service unavailable."

elif [ "$STATUS_CODE" -eq 000 ]; then

    APP_STATUS="DOWN"
    MESSAGE="Application unreachable or timeout occurred."

else

    APP_STATUS="DOWN"
    MESSAGE="Unexpected HTTP status code received."

fi

# Display final result
echo "Application Status: $APP_STATUS"
echo "Message           : $MESSAGE"

# Save result to log file
echo "[$TIMESTAMP] URL=$URL STATUS=$STATUS_CODE APP_STATUS=$APP_STATUS RESPONSE_TIME=${RESPONSE_TIME}s MESSAGE=\"$MESSAGE\"" >> $LOG_FILE

echo ""
echo "Health check completed."
