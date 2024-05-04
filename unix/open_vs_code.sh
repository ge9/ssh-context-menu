#!/bin/sh
mode=$1
while [ "$2" != "" ]
do
    ret=$(`dirname $0`/../scripts/getremote.sh "$2")
    path_type=$(echo "$ret" | cut -c 1-1)
    path_data=$(echo "$ret" | cut -c 3-)
    echo $path_data
    if [ "$path_type" = "1" ]; then
        ssh_host=$(echo "$path_data" | cut -d ':' -f 1)
        ssh_dir=$(echo "$path_data" | cut -d ':' -f 2- | sed 's/#/%23/g')
        code --$mode-uri "vscode-remote://ssh-remote+$ssh_host$ssh_dir" &
    else
        code $path_data &
    fi
    shift
done
