FROM debian:stable-slim

LABEL "maintainer"="dashjay <dashjay@aliyun.com>"
LABEL "repository"="https://github.com/dashjay/zip-release"
LABEL "version"="0.2.1"

COPY entrypoint.sh /entrypoint.sh

RUN apt-get update; \
    apt-get install -y zip; \
    apt-get clean -y; \
    rm -rf /var/lib/apt/lists/*; \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
