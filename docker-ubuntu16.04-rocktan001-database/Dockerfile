FROM docker.io/ubuntu:16.04
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

#安装mysql
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

RUN mkdir -p /var/lib/mysql && \
    mkdir -p /var/run/mysqld && \
    mkdir -p /var/log/mysql && \
    chown -R mysql:mysql /var/lib/mysql && \
    chown -R mysql:mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/log/mysql
# UTF-8 and bind-address
RUN sed -i -e "$ a [client]\n\n[mysql]\n\n[mysqld]"  /etc/mysql/my.cnf && \
    sed -i -e "s/\(\[client\]\)/\1\ndefault-character-set = utf8/g" /etc/mysql/my.cnf && \
    sed -i -e "s/\(\[mysql\]\)/\1\ndefault-character-set = utf8/g" /etc/mysql/my.cnf && \
    sed -i -e "s/\(\[mysqld\]\)/\1\ninit_connect='SET NAMES utf8'\ncharacter-set-server = utf8\ncollation-server=utf8_unicode_ci\nbind-address = 0.0.0.0/g" /etc/mysql/my.cnf

# redis
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y redis-server

RUN sed -i -e "s/^bind.*/bind 0.0.0.0/g" /etc/redis/redis.conf && \
    sed -i -e "s/^appendonly.*/appendonly yes/g" /etc/redis/redis.conf && \
    sed -i -e "s/^daemonize.*/daemonize no/g" /etc/redis/redis.conf && \
    sed -i -e "$ a requirepass F96AEB124C\n" /etc/redis/redis.conf

#清理 apt
RUN apt-get -y autoremove && apt-get clean

RUN echo "root:F96AEB124C" | chpasswd

RUN useradd -m -s /bin/bash rock
RUN echo "rock:F96AEB124C" | chpasswd


COPY etc/startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh


RUN  echo "export LANG=C.UTF-8" >> /etc/bash.bashrc

VOLUME /var/lib/mysql

#开放端口
EXPOSE 22 3306 6379

ENTRYPOINT ["/root/startup.sh"]

#设置自动启动命令
CMD ["/usr/bin/supervisord"]
