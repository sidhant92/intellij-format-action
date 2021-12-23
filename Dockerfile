FROM ubuntu:latest
MAINTAINER Sidhant Aggarwal <sidhant92@hotmail.com>

RUN echo ${INPUT_INTELLIJ_VERSION}

RUN apt-get update \
    && apt-get install -y bash git wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && wget --no-verbose -O /tmp/idea.tar.gz https://download.jetbrains.com/idea/ideaIC-2021.1.2.tar.gz \
    && cd /opt \
    && tar xzf /tmp/idea.tar.gz \
    && mv /opt/idea* /opt/idea \
    && rm /tmp/idea.tar.gz

ENV REVIEWDOG_VERSION=v0.13.0

RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN ["chmod", "+x", "/usr/local/bin/entrypoint.sh"]

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]