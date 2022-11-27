#!/bin/bash
# mkdir and cd into it in one command

ndirl=$1
if [ -n "$ndirl" ]; then
    echo -e "Creating directory [$ndirl]\nin $(pwd)"
    mkdir $(pwd)/$ndirl
    cd $(pwd)/$ndirl
    exit 0
else
echo No input provided. Exiting..
exit 1
fi
