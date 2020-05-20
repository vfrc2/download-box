#!/bin/sh

WATCH_DIR=/downloads

echo Start watching $WATCH_DIR

inotifywait -e close_write --include '.torrent$' --format '%w %f' -m -r $WATCH_DIR |\
(
    while read
    do
        DIR=$(echo $REPLY | cut -f 1 -d' ')
        FILE=$(echo $REPLY | cut -f 2 -d' ')
        echo File writed $DIR $FILE
    done
)

