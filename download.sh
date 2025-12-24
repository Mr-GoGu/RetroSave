#!/bin/bash

UTILS="./utils.sh"
if [[ -f "$UTILS" ]]; then
    source "$UTILS"
else
    echo "ERROR: utils.sh could not be found" >&2
    exit 1
fi

# Load env variable
load_env

# Get all arguments
help=false
while getopts "h" opt; do
    case "$opt" in
        h) help=true ;;
        ?) echo "ERROR: Unknown option -$opt, leaving..." >&2; exit 1 ;;
    esac
done

# Help message
if $help; then
    echo "USAGE: $0 [-h]"
    echo -e "\t-h  Display this message"
    echo "\nDESCRIPTION:\nCheckout to the main branch and will merge it to $RETRO_BRANCH branch"
    exit 0
fi
