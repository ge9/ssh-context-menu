#/bin/sh
mypath=$1
mydir=`dirname $0`
index=0
while IFS= read -r line1 && IFS= read -r line2
do
    length1=${#line1}
    path_prefix=$(echo "$mypath" | cut -c 1-"$length1")
    if [ "$path_prefix" = "$line1" ]; then
        line1="$line2$(echo "$mypath" | cut -c $(($length1 + 1))-)"
        echo "1:$line1"
        exit
    fi
done < "$mydir/../config/remote-paths-unix.txt"
echo "0:$mypath"
