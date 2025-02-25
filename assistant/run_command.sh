#!/bin/bash

# Read input from stdin
read command

# Execute command and return JSON output
OUTPUT=$(eval "$command" 2>&1)
echo "{\"output\": \"$OUTPUT\"}"
