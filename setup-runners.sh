#!/bin/bash

function get_runner_token() {
  # Change line below
  local PAT="TOKEN"
  # Change line below
  local ORG="NAME"

  # Get the token
  echo $(curl -XPOST -fsSL \
    -H "Authorization: token ${PAT}" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/orgs/${ORG}/actions/runners/registration-token" |
    jq -r '.token')
}

function get_number_input() {
  local prompt_message=$1
  local input_number

  read -p "$prompt_message" input_number

  while ! validate_number "$input_number"; do
    read -p "Invalid input. Please enter a valid number: " input_number
  done

  echo "$input_number"
}

function validate_number() {
  local re='^[0-9]+$'
  if ! [[ $1 =~ $re ]]; then
    echo "Invalid input. Please enter a valid number."
    return 1
  fi
}

# Prompt the user for the start number
start_number=$(get_number_input "Enter the start number: ")

# Prompt the user for the end number
end_number=$(get_number_input "Enter the end number: ")

# Display the start and end numbers
echo "Start number: $start_number"
echo "End number: $end_number"

for ((i = start_number; i <= end_number; i++)); do
  echo "Current number: $i"
  directory_name="actions-runner-$i"
  mkdir "$directory_name" && cd "$directory_name"

  # Change line below to use variables for runner version and URL
  runner_version="2.304.0"
  runner_url="https://github.com/actions/runner/releases/download/v${runner_version}/actions-runner-linux-arm64-${runner_version}.tar.gz"
  curl -o "actions-runner-linux-arm64-${runner_version}.tar.gz" -L "$runner_url"

  # Verify the downloaded file's integrity
  echo "34c49bd0e294abce6e4a073627ed60dc2f31eee970c13d389b704697724b31c6  actions-runner-linux-arm64-${runner_version}.tar.gz" | shasum -a 256 -c

  tar xzf "./actions-runner-linux-arm64-${runner_version}.tar.gz"

  # Get the runner token
  runner_token="$(get_runner_token)"

  # Configure the runner
  ./config.sh --url "https://github.com/tracefy" \
              --token "$runner_token" \
              --name "$(hostname)-runner-$i" \
              --runnergroup "Default" \
              --work "_work" \
              --labels "self-hosted,Linux,arm64"

  cd ..
done

echo "Crontab:"
for ((i = start_number; i <= end_number; i++)); do
  echo "@reboot $(pwd)/actions-runner-$i/run.sh &"
done

echo "Now:"
for ((i = start_number; i <= end_number; i++)); do
  echo "$(pwd)/actions-runner-$i/run.sh &"
done
