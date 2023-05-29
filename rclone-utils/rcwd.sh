#!/bin/bash

# Check if the parameter is provided
if [ -z "$1" ]; then
    echo "Usage: ./rcwd.sh <cloud:>"
    exit 1
fi

# Run the rclone serve webdav command
rclone serve webdav --addr :8080 "$1"
