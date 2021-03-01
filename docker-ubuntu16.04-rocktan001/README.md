Docker + Ubuntu-16.04 + openssh-server

#### parameter

* `ROOT_PWD` : root Password   default "F96AEB124C"
* `ROCK_USER_PWD` : root Password   default "F96AEB124C"


#### build image

```
$ docker build -t="rocktan001/docker-ubuntu16.04-rocktan001:v1.0" .
```

#### run a default contaier

```
$ docker run -tid --name docker-ubuntu16.04-rocktan001 -v /media/disk2:/media/disk2 -p 8889:00 rocktan001/docker-ubuntu16.04-rocktan001:v1.0
```


#### run a container with new User and Password

```
$ docker run -tid --name docker-ubuntu16.04-rocktan001 -e ROOT_PWD=F96AEB124C -e ROCK_USER_PWD=rock -v /media/disk2:/media/disk2 -p 8889:22 rocktan001/docker-ubuntu16.04-rocktan001:v1.0
```