#!/bin/bash

help=false

while getopts "h" opt; do
    case "$opt" in
        h) help=true ;;
        ?) echo -e "ERROR: Unknown option -$opt, leaving..." >&2; exit 1 ;;
    esac
done

# Example usage logic
if $help; then
    echo -e "USAGE: $0 <branch> [-h]"
    echo -e "\t-h  Display this message"
    echo -e "\nDESCRIPTION:\n\tInitialize a new instance of an EmuDeck setup,\nwill create a new branch and set an environment file"
    exit 0
fi

if [[ -z "$1" ]]; then
    echo -e "ERROR: can't find argument for branch name"
    exit 1
fi


# Create new branch
echo -e "-- Create branch $1"
git switch -c $1
git push -u origin $1
echo -e "-- Create branch $1 - done"

# Create environement file
echo -e "-- Create .env file"
ENV_FILE=".env"
echo "RETRO_BRANCH=\"$1\"" > $ENV_FILE
echo -e "-- Create .env file - done"
