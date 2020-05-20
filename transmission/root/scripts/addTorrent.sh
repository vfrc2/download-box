#!/bin/sh

TORRENT=$1
DOWNLOAD_DIR=/downloads

DIR=$(dirname $TORRENT)

transmission-remote -w "$DIR" -a "$TORRENT"

if [ $? -eq 0 ]; then
    echo wait 10s before delete
    sleep 10

    echo Delete $TORRENT
    rm $TORRENT
fi
