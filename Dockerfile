FROM ubuntu:jammy AS base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt upgrade -y && \
    apt install -y software-properties-common curl build-essential git sudo && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt update && \
    apt install -y ansible && \
    apt clean autoclean && \
    apt autoremove -y

FROM base AS development
ARG TAGS
RUN addgroup --gid 1000 rgoularti
RUN adduser --gecos rgoularti --uid 1000 --gid 1000 --disabled-password rgoularti
# USER rgoularti
# WORKDIR /home/rgoularti

FROM development
COPY . .
# CMD [ "sh", "-c", "ansible-playbook", $TAGS local.yaml"]
