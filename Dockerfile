FROM debian:stable-slim

LABEL "maintainer"="TheDoctor0 <dawid.janik95@gmail.com>"
LABEL "repository"="https://github.com/TheDoctor0/zip-release"
LABEL "version"="0.2.0"

RUN apt-get update && apt-get install -y zip
RUN	apt-get clean -y
RUN rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
