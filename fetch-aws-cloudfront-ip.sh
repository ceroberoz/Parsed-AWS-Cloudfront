#!/bin/bash

# Define the URL to retrieve data from
apiEndpoint="https://ip-ranges.amazonaws.com/ip-ranges.json"

# Data file with timestamp prefix
dataFile="ip_ranges_data_$(date +'%Y%m%d%H%M%S').json"

# Perform the curl command to get data from the specified URL
curl -s "$apiEndpoint" > "$dataFile"

# Function to log messages with timestamps
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') $1" >> "script_log.txt"
}

# Fetch AWS Cloudfront IP Ranges
log "Processing CLOUDFRONT IPv4"
jq -r '.prefixes[] | select(.service=="CLOUDFRONT") | .ip_prefix' < "$dataFile" > CLOUDFRONT-IPv4.txt
log "Processing CLOUDFRONT IPv4 - Done"

log "Processing CLOUDFRONT IPv6"
jq -r '.ipv6_prefixes[] | select(.service=="CLOUDFRONT") | .ipv6_prefix' < "$dataFile" > CLOUDFRONT-IPv6.txt
log "Processing CLOUDFRONT IPv6 - Done"

# Return script completion message
log "Script execution completed successfully."
