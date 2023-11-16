FROM ubuntu:jammy AS base

ARG TAGS
WORKDIR /root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt upgrade -y && \
    apt install -y software-properties-common curl build-essential git && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt update && \
    apt install -y ansible && \
    apt clean autoclean && \
    apt autoremove -y

COPY . .

CMD [ "sh", "-c", "ansible-playbook $TAGS local.yml"]
