Docker + Ubuntu-16.04 + openssh-server

#### parameter

* `ROOT_PWD` : openssh root Password   default "F96AEB124C"
* `ROCK_USER_PWD` : openssh rock user Password   default "F96AEB124C"


* `MYSQL_ROOT_PWD` : mysql root Password   default "mysql"
* `MYSQL_USER` : mysql create new user
* `MYSQL_USER_PWD` : mysql create new user Password
* `MYSQL_USER_DB` : mysql create new  user database

#### volume
```
* /var/lib/mysql default mysql data path
```
#### build image

```
$ docker build -t="rocktan001/docker-ubuntu16.04-rocktan001-database:v1.0" .
```


#### run a container with new User and Password

```
$ docker run -tid --name docker-ubuntu16.04-rocktan001-mysql -e ROOT_PWD=F96AEB124C -e ROCK_USER_PWD=rock -e MYSQL_ROOT_PWD=F96AEB124C -v /media/disk2:/media/disk2  -p 8890:22 -p 3306:3306 -p 6379:6379 rocktan001/docker-ubuntu16.04-rocktan001-database:v1.0

```