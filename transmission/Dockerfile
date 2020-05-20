FROM linuxserver/transmission

RUN apk add --no-cache inotify-tools

COPY ./root/ .

VOLUME [ "/config" ]
