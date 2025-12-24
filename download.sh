#!/bin/bash

ENV_FILE=".env"
if [ ! -f "$ENV_FILE" ]; then
    echo -e "ERROR: can't find .env file"
    exit 1
fi

# Load env file
set -a
source "$ENV_FILE"
set +a

# Get all arguments
help=false
while getopts "h" opt; do
    case "$opt" in
        h) help=true ;;
        ?) echo -e "ERROR: Unknown option -$opt, leaving..." >&2; exit 1 ;;
    esac
done

# Help message
if $help; then
    echo -e "USAGE: $0 [-h]"
    echo -e "\t-h  Display this message"
    echo -e "\nDESCRIPTION:\nSwitch to the main branch to pull updates\nand will merge it to $RETRO_BRANCH branch"
    exit 0
fi

echo -e "-- Stash branch $RETRO_BRANCH"
git stash
echo -e "-- Stash branch $RETRO_BRANCH - done"

echo -e "-- Merge branch main to $RETRO_BRANCH"
git switch main
git pull
git switch $RETRO_BRANCH
git merge main
git push
echo -e "-- Merge branch main to $RETRO_BRANCH - done"

echo -e "-- Restore branch $RETRO_BRANCH"
git stash pop
echo -e "-- Restore branch $RETRO_BRANCH - done"
