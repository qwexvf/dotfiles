#!/bin/bash
# Generate a short session name from current directory

MAX_LEN=${1:-30}

path="${PWD/#$HOME/\~}"

if [ ${#path} -le $MAX_LEN ]; then
    echo "$path"
    exit 0
fi

# Split path into parts
IFS='/' read -ra parts <<< "$path"
len=${#parts[@]}

# Keep first (~/), last two dirs full, abbreviate middle
result=""
for ((i=0; i<len; i++)); do
    part="${parts[i]}"
    if [ $i -eq 0 ]; then
        result="$part"
    elif [ $i -ge $((len-2)) ]; then
        result="$result/$part"
    else
        result="$result/${part:0:1}"
    fi
done

echo "$result"
