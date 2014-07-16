FROM ubuntu:trusty
MAINTAINER Toshiaki Baba <toshiaki@netmark.jp>
RUN apt-get update
RUN apt-get -y upgrade

## hubot
RUN apt-get update && apt-get -y install git build-essential supervisor nodejs nodejs-dev nodejs-legacy node-gyp npm redis-server
RUN npm install bower -g
RUN npm install -g hubot coffee-script hubot-xmpp
RUN cd /opt ; hubot --create mybot
RUN cd /opt/mybot && yes | rm -f scripts/*
RUN cd /opt/mybot && npm install hubot-xmpp@0.1.11 cron@1.0.0

## sshd
RUN apt-get -y install openssh-server
RUN echo 'root:p@ssw0rd' |chpasswd
RUN sed -i.bak 's/^PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN mkdir /var/run/sshd

## supervisor
RUN install -d /etc/supervisor ; install -d /etc/supervisor/conf.d
ADD supervisord.conf /etc/supervisor/supervisord.conf

ADD run.sh /opt/mybot/run.sh
RUN chmod a+x /opt/mybot/run.sh

EXPOSE 22
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
