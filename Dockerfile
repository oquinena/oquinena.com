FROM ubuntu:latest

ARG URL
ARG USERNAME
ARG FINGERPRINT
ARG SSHPASS

ENV URL=${URL}
ENV USERNAME=${USERNAME}
ENV SSHPASS=${SSHPASS}

RUN apt update && apt install -y hugo sshpass
RUN mkdir /root/.ssh
RUN echo ${URL} ${FINGERPRINT} > /root/.ssh/known_hosts
COPY run.sh /run.sh

ENTRYPOINT [ "/run.sh" ]