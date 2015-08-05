FROM ubuntu:15.04
MAINTAINER Franck Besnard <franck@besnard.mobi>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

RUN apt-get update \
        && apt-get install -y --force-yes --no-install-recommends \
                supervisor openssh-server pwgen sudo vim-tiny net-tools \
                lxde x11vnc xvfb gtk2-engines-murrine ttf-ubuntu-font-family lxterminal \
        && apt-get autoclean \
        && apt-get autoremove \
        && rm -rf /var/lib/apt/lists/*

ADD panel /root/
ADD lxde-x-terminal-emulator.desktop /root/

ADD startup.sh /
ADD desktop.conf /etc/supervisor/conf.d/

RUN chmod +x /startup.sh

EXPOSE 5900
WORKDIR /root
ENTRYPOINT ["/startup.sh"]
