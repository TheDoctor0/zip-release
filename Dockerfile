FROM debian:stable-slim

LABEL "maintainer"="Dawid Janik <dawid.janik95@gmail.com>"
LABEL "repository"="https://github.com/TheDoctor0/action-zip"
LABEL "version"="0.1.0"

LABEL "com.github.actions.name"="Archive"
LABEL "com.github.actions.description"="Create zip archive"
LABEL "com.github.actions.icon"="archive"
LABEL "com.github.actions.color"="grey"

RUN apt-get update && apt-get install -y zip
RUN	apt-get clean -y
RUN rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
