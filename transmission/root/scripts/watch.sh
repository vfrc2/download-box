#!/bin/sh

WATCH_DIR=/downloads
export TOP_PID=$$

echo Scan dir

find /downloads -name \*.torrent |\
(
    while read
    do
        /scripts/addTorrent.sh $REPLY
    done
)

echo Start watching $WATCH_DIR

/usr/bin/inotifywait -e close_write -e create --format '%e %w %f' -m -r $WATCH_DIR |\
(
    while read
    do
        EVENT=$(echo $REPLY | cut -f 1 -d' ')
        DIR=$(echo $REPLY | cut -f 2 -d' ')
        FILENAME=$(echo $REPLY | cut -f 3 -d' ')
        
        FILE=$DIR$FILENAME

        echo e \"$EVENT\"
        echo f $FILE

        if [ "CREATE,ISDIR" == "${EVENT}" ]; then
            echo Dir changed, exit
            kill -s TERM $TOP_PID
        fi

        IS_TORRENT=$(echo "$FILE" | grep "torrent$")

        if [ "CLOSE_WRITE,CLOSE" == "${EVENT}" ] && [[ ! -z $IS_TORRENT ]]; then
            /scripts/addTorrent.sh $FILE
        fi
    done
)
