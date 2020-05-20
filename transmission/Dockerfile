FROM linuxserver/transmission

RUN apk add --no-cache inotify-tools

COPY ./root/ .
RUN chmod a+x /scripts/* /etc/services.d/watch/run

VOLUME [ "/config" ]

