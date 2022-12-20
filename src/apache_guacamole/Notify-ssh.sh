#!/bin/bash

# Check if inotify-tools package is installed
if ! dpkg -s inotify-tools &> /dev/null; then
  # Install inotify-tools package if it is not installed
  apt-get update
  apt-get install -y inotify-tools
fi

# Set the directory to watch for new ssh keys
SSH_DIR="/root/.ssh"

# Set the script to run when a new ssh key is added
SCRIPT="/root/ssh-key-added.sh"

# Run the inotifywait command to listen for new ssh keys
inotifywait -m "$SSH_DIR" -e create -e moved_to |
  while read path action file; do
    # Check if the file is an ssh key
    if [[ $file == *".pub" ]]; then
      # Run the script
      $SCRIPT "$path$file"
    fi
  done
