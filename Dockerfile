FROM ubuntu:12.04
MAINTAINER  APSL <bcabezas@apsl.net>
ENV DEBIAN_FRONTEND noninteractive

# REPOS
# http://jpetazzo.github.io/2013/10/06/policy-rc-d-do-not-start-services-automatically/
RUN \
    echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90forceyes;\
    echo 'deb http://archive.ubuntu.com/ubuntu precise main restricted universe' > /etc/apt/sources.list ;\
    echo 'deb http://archive.ubuntu.com/ubuntu precise-updates main universe' >> /etc/apt/sources.list ;\
    apt-get update;\
    echo exit 101 > /usr/sbin/policy-rc.d && chmod +x /usr/sbin/policy-rc.d;\
    dpkg-divert --local --rename --add /sbin/initctl;\
    ln -sf /bin/true /sbin/initctl;\
    apt-get -y dist-upgrade && apt-get clean

# timezone Europe/Madrid
RUN \
    echo "Europe/Madrid" > /etc/timezone ;\
    rm -f /etc/localtime ;\
    ln -sf /usr/share/zoneinfo/Europe/Madrid  /etc/localtime

# circus + circus-web + envtpl depends
RUN \
    apt-get -y  install  python-zmq python-gevent \
      python-bottle python-mako python-anyjson python-greenlet \
      python-beaker python-psutil python-tornado \
      unzip wget vim-tiny python-distribute python-pip python-jinja2 && apt-get clean

RUN \
    pip install circus==0.11.1 ;\
    pip install circus-web==0.5 ;\
    pip install envtpl


# circus conf
ADD conf/circus.ini.tpl  /etc/
# start script
ADD start.sh /bin/
RUN \ 
    mkdir  /etc/circus.d ;\
    mkdir /etc/setup.d

EXPOSE 8080
CMD /bin/start.sh
