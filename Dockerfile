FROM ubuntu:22.04

LABEL maintainer="Harshitha"
LABEL description="Wisecow application containerized using Docker"

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/usr/games:${PATH}"

RUN apt-get update && \
    apt-get install -y \
    fortune-mod \
    fortunes-min \
    cowsay \
    netcat && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY app/ /app/

RUN chmod +x wisecow.sh

EXPOSE 4499

CMD ["./wisecow.sh"]
