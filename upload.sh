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
merge=false
commit=""
while getopts "hmc:" opt; do
    case "$opt" in
        h) help=true ;;
        m) merge=true ;;
        c) commit="$OPTARG" ;;
        ?) echo -e "ERROR: Unknown option -$opt, leaving..." >&2; exit 1 ;;
    esac
done

# Help message
if $help; then
    echo -e "USAGE: $0 [-h] [-m] [-c <message>]"
    echo -e "\t-h  Display this message"
    echo -e "\t-m  Merge $RETRO_BRANCH to main branch"
    echo -e "\t-c  Commit message (Default=\"[ADD] - save files\")"
    echo -e "\nDESCRIPTION:\n\tAdd all saves files and push them to $RETRO_BRANCH branch\nWill merge changes to main branch if specified"
    exit 0
fi

if [[ -z "$commit" ]]; then
    commit="[ADD] - save files"
fi

# Push to local branch
echo -e "-- Push to branch $RETRO_BRANCH"
git add .
git commit -m "$commit"
git push
echo -e "-- Push to branch $RETRO_BRANCH - done"

if ! $merge; then
    exit 0
fi

echo -e "-- Merge branch $RETRO_BRANCH to main"
git switch main
git pull
git merge $RETRO_BRANCH
git push
git switch $RETRO_BRANCH
echo -e "-- Merge branch $RETRO_BRANCH to main - done"
