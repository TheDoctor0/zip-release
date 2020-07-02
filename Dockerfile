FROM debian:stable-slim

LABEL "maintainer"="TheDoctor0 <dawid.janik95@gmail.com>"
LABEL "repository"="https://github.com/TheDoctor0/zip-release"
LABEL "version"="0.4.0"

COPY entrypoint.sh /entrypoint.sh

RUN apt-get update; \
    apt-get install -y zip; \
    apt-get clean -y; \
    rm -rf /var/lib/apt/lists/*; \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
