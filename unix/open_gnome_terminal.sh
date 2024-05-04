#!/bin/sh
arg="$@"
if [ -n "$arg" ]; then
    gnome-terminal "$@" &
    exit
fi
ret="$(`dirname $0`/../scripts/getremote.sh "$PWD")"
path_type=$(echo "$ret" | cut -c 1-1)
path_data=$(echo "$ret" | cut -c 3-)
if [ "$path_type" = "1" ]; then
    ssh_host=$(echo "$path_data" | cut -d ':' -f 1)
    IFS=
    ssh_dir=$(/bin/printf %q $(echo "$path_data" | cut -d ':' -f 2-))
    gnome-terminal -- ssh -t $ssh_host "cd $ssh_dir; exec $SHELL -l"
    exit
fi
gnome-terminal
