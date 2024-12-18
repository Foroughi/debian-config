
#!/usr/bin/evn bash

# OpenAI API Key from environment variable
API_KEY="${GPT_TOKEN}"

# Validate that the API key is set
if [ -z "$API_KEY" ]; then
    echo "Error: GPT_TOKEN environment variable is not set."
    exit 1
fi

# Endpoint base URL
API_BASE_URL="https://api.openai.com/v1"

# Function to create a new thread
create_thread() {
    curl -s -X POST "$API_BASE_URL/threads" \
        -H "Authorization: Bearer $API_KEY" \
        -H "Content-Type: application/json" \
        -H "OpenAI-Beta: assistants=v2" \
        -d '{}'
}

# Function to send a message to the thread
send_message() {
    local thread_id="$1"
    local message="$2"

    curl -s -X POST "$API_BASE_URL/threads/$thread_id/messages" \
        -H "Authorization: Bearer $API_KEY" \
        -H "Content-Type: application/json" \
        -H "OpenAI-Beta: assistants=v2" \
        -d "{\"role\": \"user\", \"content\": \"$message\"}"
}

# Function to create a run and execute it
create_run() {
    local thread_id="$1"
    local message_id="$2"

    curl -s -X POST "$API_BASE_URL/threads/$thread_id/runs" \
        -H "Authorization: Bearer $API_KEY" \
        -H "Content-Type: application/json" \
        -H "OpenAI-Beta: assistants=v2" \
        -d "{\"assistant_id\": \"$ASSISTANT_ID\"}"
        # -d "{\"message_id\": \"$message_id\", \"assistant_id\": \"$ASSISTANT_ID\"}"
}


# Function to get the latest message from the thread
get_latest_message() {
    local thread_id="$1"

    curl -s -X GET "$API_BASE_URL/threads/$thread_id/messages" \
        -H "Authorization: Bearer $API_KEY" \
        -H "Content-Type: application/json" \
        -H "OpenAI-Beta: assistants=v2"
}

# Assistant ID (replace with your assistant's ID)
ASSISTANT_ID="asst_jRGatNNMhWdYGt8ZsdJ9Bi4S"

# Function to process the assistant's response
process_response() {


    # Send the user request as a message to the assistant
    message_response=$(send_message "$thread_id" "$1")

    message_id=$(echo "$message_response" | jq -r '.id')

    if [ -z "$message_id" ]; then
        echo "Error: Failed to send the message."
        exit 1
    fi

    # Create the first run using the message ID
    run_response=$(create_run "$thread_id" "$message_id")
    sleep 5

    local response=$(get_latest_message "$thread_id")
    # Extract the command, isCompleted, and summary fields from the JSON response
    local command=$(echo "$response" | jq -r '.data[0].content[0].text.value | fromjson | .command // empty')
    local is_completed=$(echo "$response" | jq -r '.data[0].content[0].text.value | fromjson | .isCompleted')

     echo $response

    # If no command is returned, exit
    if [ -z "$command" ]; then
        echo "Error: No command returned by the assistant."
        exit 1
    fi

    # echo "Running command(s): $command"

    # Run the command(s) and capture the output
    local command_output
    command_output=$(eval "$command" 2>&1)
    echo "$command_output"
    # If isCompleted is false, send the output back to the assistant
    if [ "$is_completed" = "false" ]; then
        process_response "$command_output"
    fi
}

# Create a new thread and capture the raw response for debugging
thread_response=$(create_thread)

# Extract thread ID from the response
thread_id=$(echo "$thread_response" | jq -r '.id')

if [ -z "$thread_id" ]; then
    echo "Error: Failed to create a thread. The response doesn't contain 'id'."
    exit 1
fi


# Main script logic

# Ensure user provided a request
if [ $# -eq 0 ]; then
    echo "Usage: $0 '<your request>'"
    exit 1
fi

process_response "$*"
