#!/bin/bash

# Start Cloudflare interview agent using environment variables
# Usage: 
# export MEETING_ID="your-meeting-id"
# export AUTH_TOKEN="your-auth-token"
# ./start-interview.sh

if [ -z "$MEETING_ID" ] || [ -z "$AUTH_TOKEN" ]; then
    echo "Usage:"
    echo "  export MEETING_ID=\"your-meeting-id\""
    echo "  export AUTH_TOKEN=\"your-auth-token\""
    echo "  ./start-interview.sh"
    echo ""
    echo "To get the values:"
    echo "1. Go to https://dash.realtime.cloudflare.com/dashboard"
    echo "2. Click 'Join' on your meeting"
    echo "3. Copy the meeting ID and auth token from the URL"
    exit 1
fi

echo "Starting interview with meeting ID: $MEETING_ID"
echo "Agent URL: https://cf-rt-agent.acme-corp.workers.dev"

curl -X POST "https://cf-rt-agent.acme-corp.workers.dev/init?meetingId=$MEETING_ID" \
     -H "Authorization: Bearer $AUTH_TOKEN"
