# /	100G	

# 根目录

```bash
[thorgeng@CentOS 7 /]$ ll
lrwxrwxrwx.   1 root root     7 3月  27 03:35 bin -> usr/bin
dr-xr-xr-x.   6 root root  4096 3月  27 05:30 boot
drwxr-xr-x.  20 root root  3400 3月  29 20:41 dev
drwxr-xr-x. 145 root root 12288 3月  29 20:41 etc
drwxr-xr-x.   4 root root  4096 3月  27 03:54 home
lrwxrwxrwx.   1 root root     7 3月  27 03:35 lib -> usr/lib
lrwxrwxrwx.   1 root root     9 3月  27 03:35 lib64 -> usr/lib64
drwx------.   2 root root 16384 3月  27 03:33 lost+found
drwxr-xr-x.   2 root root  4096 4月  11 2018 media
drwxr-xr-x.   2 root root  4096 4月  11 2018 mnt
drwxr-xr-x.   3 root root  4096 3月  27 05:14 opt
dr-xr-xr-x. 162 root root     0 3月  30 2022 proc
dr-xr-x---.  15 root root  4096 3月  29 20:40 root
drwxr-xr-x.  40 root root  1220 3月  29 20:42 run
lrwxrwxrwx.   1 root root     8 3月  27 03:35 sbin -> usr/sbin
drwxr-xr-x.   2 root root  4096 4月  11 2018 srv
dr-xr-xr-x.  13 root root     0 3月  29 20:41 sys
drwxrwxrwt.  15 root root  4096 3月  29 20:43 tmp
drwxr-xr-x.  14 root root  4096 3月  27 03:35 usr
drwxr-xr-x.  22 root root  4096 3月  27 05:13 var

```



## /bin	

主要存放一些基本命令

```BASH

```





## /boot	1024M	

启动相关文件

## /dev	

设备相关

## /etc	

配置相关

## /home	100G	

家目录

## /lib	

函式库目录

## /lib64	

## /lost+found

## /media	

挂载光盘等

## /mnt	

挂载设备

## /opt	

程序目录

## /proc	

虚拟文件系统

## /root	

系统管理员家目录

## /run	

## /sbin	

底层命令

## /srv	

service	服务的资料文件

## /sys	

虚拟文件系统

## /tmp	

缓存目录

## /usr	100G

Unix Software Resource 系统软件资源

```bash
[thorgeng@CentOS 7 usr]$ ll
总用量 224
dr-xr-xr-x.   2 root root 57344 3月  27 21:19 bin
drwxr-xr-x.   2 root root  4096 4月  11 2018 etc
drwxr-xr-x.   2 root root  4096 4月  11 2018 games
drwxr-xr-x.  41 root root  4096 3月  27 05:12 include
dr-xr-xr-x.  43 root root  4096 3月  27 05:13 lib
dr-xr-xr-x. 146 root root 77824 3月  27 21:18 lib64
drwxr-xr-x.  51 root root 12288 3月  27 05:13 libexec
drwxr-xr-x.  12 root root  4096 3月  27 03:35 local
drwx------.   2 root root 16384 3月  27 03:34 lost+found
dr-xr-xr-x.   2 root root 20480 3月  27 05:15 sbin
drwxr-xr-x. 251 root root 12288 3月  27 21:19 share
drwxr-xr-x.   4 root root  4096 3月  27 03:35 src
lrwxrwxrwx.   1 root root    10 3月  27 03:35 tmp -> ../var/tmp
```

### /usr/bin

存放指令

### /usr/etc

### /usr/games

### /usr/include

c/c++等程序语言的档头(header)与包含档(include)放置处

### /usr/lib

各应用软件的函式库

### /usr/lib64

### /usr/libexec

### /usr/local

自行安装下载的软件

#### /usr/local/python3.10

安装的python3.10

### /usr/lost+found

### /usr/sbin

非系统正常运作所需要的系统指令。最常见的就是某些网络服务器软件的服务指令(daemon)

### /usr/share

放置共享文件

### /usr/src

源码文件

### /tmp -> ../var/tmp

## /var	100G	

存放常态性变动的文件

