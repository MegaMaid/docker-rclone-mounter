FROM ubuntu

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz /tmp/
ADD https://github.com/rclone/rclone/releases/download/v1.49.5/rclone-v1.49.5-linux-amd64.zip /tmp/

COPY scripts/* /usr/bin/
COPY root /

RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /
RUN apt-get update && \
    apt-get install -y unzip zip fuse ca-certificates && \
    update-ca-certificates && \
    sed -i 's/#user_allow_other/user_allow_other/' /etc/fuse.conf && \
    mkdir -p /config && \
    mkdir -p /mount && \
    mkdir -p /log && \
    mkdir -p /cache && \
    unzip /tmp/rclone-v1.49.5-linux-amd64.zip -d /tmp/ && \
    mv /tmp/rclone-v1.49.5-linux-amd64/rclone /usr/local/bin && \
    chmod a+x /usr/local/bin/rclone

RUN chmod a+x /usr/bin/* && \
    groupmod -g 1000 users && \
    useradd -u 911 -U -d / -s /bin/false abc && \
    usermod -G users abc && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ /var/tmp/* /tmp/*

VOLUME ["/config", "/mount", "/cache"]

ENV RCLONE_DISABLE_MEMORY_CACHE "1"

ENTRYPOINT ["/init"]
