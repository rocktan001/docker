FROM docker.io/ubuntu:14.04
#作者
MAINTAINER ROCK
#更新源
#ADD etc/sources.list /etc/apt/sources.list

RUN apt-get update

#安装openssh
RUN apt-get -y install openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh

#安装supervisor
RUN apt-get -y install supervisor
RUN mkdir -p /var/log/supervisor

ADD etc/supervisord.conf /etc/supervisord.conf

RUN apt-get -y install curl apt-utils  net-tools iputils-ping  
# MTK编译环境
RUN apt-get install -y bc git gnupg flex bison gperf build-essential zip curl libc6-dev libncurses5-dev  x11proto-core-dev   g++-multilib mingw32 tofrodos python-markdown libxml2-utils xsltproc  g++ cpp g++-4.6 gcc-4.6 gcc-multilib g++-multilib

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk

#清理 apt
RUN apt-get -y autoremove && apt-get clean

RUN echo "root:F96AEB124C" | chpasswd

RUN useradd -m -s /bin/bash rock
RUN echo "rock:F96AEB124C" | chpasswd


COPY etc/startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh


RUN  echo "export LANG=C.UTF-8" >> /etc/bash.bashrc
#开放端口
EXPOSE 22

ENTRYPOINT ["/root/startup.sh"]
#设置自动启动命令
CMD ["/usr/bin/supervisord"]
