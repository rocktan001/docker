Docker + Ubuntu-16.04 + openssh-server

#### parameter

* `ROOT_PWD` : root Password   default "F96AEB124C"
* `ROCK_USER_PWD` : root Password   default "F96AEB124C"

#### run a container with new User and Password

```

$ docker run -tid --name rock-mtk-ubuntu14.04 -e ROOT_PWD=root -e ROCK_USER_PWD=rock -v /media/disk2/:/media/disk2/ -p 24:22  rocktan001/docker-ubuntu14.04-rocktan001-android:v1.0
$ docker run -tid --name rock-mtk-ubuntu14.04 -e ROOT_PWD=F96AEB124CXIAOQIANG4423 -e ROCK_USER_PWD=F96AEB124CXIAOQIANG4423 -v /media/disk2/chenwb/:/media/disk2/chenwb/ -p 60024:22  rocktan001/docker-ubuntu14.04-rocktan001-android:v1.0
```