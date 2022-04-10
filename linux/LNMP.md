# 1.	Linux（CentOS 7.9）

## 1.1	安装

## 1.2	配置

`CentOS`安装时若选择的是最小安装版本，启动后只有终端窗户，无图形界面，若要安装图形界面，需先连接WIFI

### 1.2.1	连接无线网络

- #### `nmcli`

查看网络状态，查看wifi的DEVICE

```shell
$ nmcli dev status
DEVICE  TYPE      STATE   CONNECTION
enp8s0  ethernet  不可用  --
lo      loopback  未托管  --
wlp7s0  wifi      未托管  --
```

开启无线网口

```shell
$ nmcli r wifi on
```

- `wpa_supplicant`

装机后，系统是自带`wpa_supplicant`工具的， `wpa_supplicant`是一个连接、配置`WIFI`的工具，它主要包含`wpa_supplicant`与`wpa_cli`两个程序。通常情况下，可以通过`wpa_cli`来进行`WIFI`的配置与连接，如果有特殊的需要，可以编写应用程序直接调用`wpa_supplicant`的接口直接开发。



1. 启动`wpa_supplicant`

```shell
$ wpa_supplicant -i wlp7s0 -c /etc/wpa_supplicant/wpa_supplicant.conf &
[1] 2597
```

2. 启动`wpa_cli`

打开新的终端窗口，搜索可用的wifi

```shell
$ wpa_cli -i wlp7s0 scan             // 搜索附近wifi网络
$ wpa_cli -i wlp7s0 scan_result      // 打印搜索wifi网络结果
bssid / frequency / signal level / flags / ssid
xx:d0:xx:xx:xx:xx	2437	-51	[WPA2-EAP-CCMP][ESS]	wifi_1
xx:d0:xx:xx:xx:xx	2462	-40	[WPA2-PSK-CCMP][ESS]	wifi_2
xx:a5:xx:xx:xx:xx	2462	-48	[ESS]	wifi_3
xx:78:xx:xx:xx:xx	2437	-58	[WPS][ESS]	wifi_4
```

3. 配置`wifi`

```shell
$ wpa_cli -i wlp7s0 add_network    
0
$ wpa_cli -i wlp7s0 set_network 0 ssid '"name"' 
//设置wifi名，注意单引号和双引号，适用于[WPA-PSK-CCMP+TKIP][WPA2-PSK-CCMP+TKIP][ESS]加密方式
$	wpa_cli -i wlp7s0 set_network 0 psk '"psk"'  
//设置wifi密码
$ wpa_cli -i wlp7s0 enable_network 0
```

4. 修改配置文件

```shell
$ vi /etc/wpa_supplicant/wpa_supplicant.conf
network={
	ssid="home"
	scan_ssid=1
	key_mgmt=WPA-PSK
	psk="psk"
}
```

5. 分配IP地址

```shell
$ dhclient wlp7s0
$ ip addr  //查看连接状态
```

6. 重启之后需要重新启动`wpa_supplicant`，重新分配IP

### 1.2.2  重启自动连WIFI

1. 如果`ifconfig`命令不存在，先安装`net-tools`

 ```shell
$ yum -y install net-tools
 ```

2. 编写固定ip与启动`wpa_supplicantD`的脚本

```SHELL
$ vi /home/newmean/autostart.sh
#!/bin/sh

#wifi设置ip与子网掩码
ifconfig wlp7s0 99.99.99.4 netmask 255.255.254.0
#设置默认网管
route add default gw 99.99.99.255
#更新生效
ifconfig wlp7s0 up
#启动wpa_supplicant -B 后台启动
wpa_supplicant -B -i wlp7s0 -c /etc/wpa_supplicant/wpa_supplicant.conf
#dhcp 获取 ip 地址
dhclient
$ chmod +x /home/xxx/autostart.sh   #增加执行权限
```

3. 脚本加入`rc.local`开机启动

```shell
$ touch /etc/rc.local
$ chmod +x /etc/rc.local
$ vi /etc/rc.local

# 在最后一行加入autostart.sh的路径
/home/xxx/autostart.sh
```

### 1.2.3	笔记本合盖不休眠

1. 编辑logind.conf文件配置

```shell
$ vi /etc/systemd/logind.conf
```

2. 修改`HandleLidSwitch`

```shell
HandleLidSwitch=lock
```

3. 重启服务生效配置

```shell
$ systemctl restart systemd-logind
```

```shell
HandlePowerKey //按下电源键后的行为，默认power off
HandleSleepKey //按下挂起键后的行为，默认suspend
HandleHibernateKey //按下休眠键后的行为，默认hibernate
HandleLidSwitch //合上笔记本盖后的行为，默认suspend

ignore 忽略，跳过
power off 关机
eboot 重启
halt 挂起
suspend shell内建指令，可暂停目前正在执行的shell。若要恢复，则必须使用SIGCONT信息。所有的进程都会暂停，但不是消失（halt是进程关闭）
hibernate 让笔记本进入休眠状态
hybrid-sleep 混合睡眠，主要是为台式机设计的，是睡眠和休眠的结合体，当你选择Hybird时，系统会像休眠一样把内存里的数据从头到尾复制到硬盘里 ，然后进入睡眠状态，即内存和CPU还是活动的，其他设置不活动，这样你想用电脑时就可以快速恢复到之前的状态了，笔记本一般不用这个功能。
lock 仅锁屏，计算机继续工作
```

### 1.2.4	安装图形界面（按需）

1. 查看支持的图形界面

```shell
$ yum grouplist
```

2. 安装`GNOME`

```shell
$ yum groupinstall "GNOME Desktop" "Graphical Administration Tools"
...			#中间需要输入两三次Y/N，大概需要下载1000多文件，再update或install
...y		#然后还要verify,时间要很久
...
...y
...
complete!  #表示安装完成
```

3. 设置启动模式

```shell
$ systemctl get-default
multi-user.target
$ systemctl set-default graphical.target
$ systemctl get-default
graphical.target
```

3. 重启进入图形界面

### 1.2.5  关闭防火墙（或开放部分端口）

```shell
$ systemctl status firewalld	#active为开启
$ systemctl stop firewalld		#关闭防火墙
$ systemctl disable firewalld	#禁止防火墙服务开机自启
```

```shell
$ firewall-cmd --list-ports	#查看开放的端口
$ firewall-cmd --permanent --zone=public --add-port=3306/tcp	#开放3306端口
#--zone：区域
#--add-port：为指定区域设置允许访问的某个端口（包括协议名）
#--permanent:带有此选项的命令用于设置永久性规则，这些规则只有在重新启动firewalld或重新加载防火墙规则时才会生效:若不带有此选项，表示用于设置运行时规则
$ firewall-cmd --reload 	#重启防火墙
```



### 1.2.6	关闭SELinux

```shell
$ getenforce #验证SELinux状态
enforcing	#开启状态
$ sestatus	#查看更多SELinux信息
$ setenforce 0	#临时关闭SELinux
#永久关闭
$ vi /etc/selinux/config
#设置SELINUX值
SELINUX=disabled
#设置完成后重启并再次验证SELinux状态
```



# 2.	Nginx

## 2.1	安装

1. 去官网http://nginx.org/下载对应的nginx包，推荐使用稳定版本http://nginx.org/download/nginx-1.20.2.tar.gz

2. 安装依赖环境


```shell
$ yum install gcc-c++	#安装gcc环境
$ yum install -y pcre pcre-devel	#安装pcre库用于解析正则表达式
$ yum install -y zlib zlib-devel	#zlib压缩和解压缩依赖
$ yum install -y openssl openssl-devel	
#SSL 安全的加密的套接字协议层，用于HTTP安全传输，也就是https
```

3. 解压

```shell
$ tar -zxvf nginx-1.20.2.tar.gz -C /tmp
$ cd /tmp/nginx-1.20.2
```

4. 创建`makefile`

```shell
# 若使用的不是原装的openssl 需要修改文件  不然make时出错
$ ./configure \   
--prefix=/usr/local/nginx \    #指定nginx安装目录
--pid-path=/var/run/nginx/nginx.pid \    #指向nginx的pid
--lock-path=/var/lock/nginx.lock \    	#锁定安装文件，防止误操作
--error-log-path=/var/log/nginx/error.log \    #错误日志
--http-log-path=/var/log/nginx/access.log \    #日志
--with-http_gzip_static_module \    #启用gzip模块，在线实时压缩输出的数据流
--http-client-body-temp-path=/var/temp/nginx/client \  #客户请求临时目录
--http-proxy-temp-path=/var/temp/nginx/proxy \         #http代理临时目录
--http-fastcgi-temp-path=/var/temp/nginx/fastcgi \     #fastcgi临时目录
--http-uwsgi-temp-path=/var/temp/nginx/uwsgi \    	   #uwsgi临时目录
--http-scgi-temp-path=/var/temp/nginx/scgi			   #scgi临时目录
--with-openssl=/usr/local/openssl-1.1.1   \ #指定openssl路径
--with-http_ssl_module  	#开启ssl模块

./configure --prefix=/usr/local/nginx --pid-path=/var/run/nginx/nginx.pid --lock-path=/var/lock/nginx.lock --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --with-http_gzip_static_module --http-client-body-temp-path=/var/temp/nginx/client --http-proxy-temp-path=/var/temp/nginx/proxy --http-fastcgi-temp-path=/var/temp/nginx/fastcgi --http-uwsgi-temp-path=/var/temp/nginx/uwsgi --http-scgi-temp-path=/var/temp/nginx/scgi --with-openssl=/usr/local/openssl-1.1.1 --with-http_ssl_module




Configuration summary
  + using system PCRE library
  + using OpenSSL library: /usr/local/openssl-1.1.1
  + using system zlib library

  nginx path prefix: "/usr/local/nginx"
  nginx binary file: "/usr/local/nginx/sbin/nginx"
  nginx modules path: "/usr/local/nginx/modules"
  nginx configuration prefix: "/usr/local/nginx/conf"
  nginx configuration file: "/usr/local/nginx/conf/nginx.conf"
  nginx pid file: "/var/run/nginx/nginx.pid"
  nginx error log file: "/var/log/nginx/error.log"
  nginx http access log file: "/var/log/nginx/access.log"
  nginx http client request body temporary files: "/var/temp/nginx/client"
  nginx http proxy temporary files: "/var/temp/nginx/proxy"
  nginx http fastcgi temporary files: "/var/temp/nginx/fastcgi"
  nginx http uwsgi temporary files: "/var/temp/nginx/uwsgi"
  nginx http scgi temporary files: "/var/temp/nginx/scgi"
```

5. 编译 & 安装

```shell
$ make
$ make install

```

6. 启动`nginx`

```bash
$ /usr/local/nginx/sbin/nginx  #启动
# 可能会提示相关temp目录不存在，需手动创建
$ /usr/local/nginx/sbin/nginx -s stop  #停止
$ /usr/local/nginx/sbin/nginx -s reload #重启

# 设置systemctl控制
$ vi /lib/systemd/system/nginx.service

[Unit]
Description=nginx service
After=network.target 
   
[Service] 
Type=forking 
ExecStart=/usr/local/nginx/sbin/nginx
ExecReload=/usr/local/nginx/sbin/nginx -s reload
ExecStop=/usr/local/nginx/sbin/nginx -s quit
PrivateTmp=true 
   
[Install] 
WantedBy=multi-user.target
```

7. 测试

```bash
$ curl http://127.0.0.1:80 -Iv
$ curl -g http://[::1]:80 -Iv

```



## 2.3 可能出现的错误提示

- make 时提示`[/usr/local/openssl1.1.1/.openssl/include/openssl/ssl.h]错误 127`

  解决方法：

  ```bash
  #修改nginx源文件下./auto/lib/openssl/conf文件
  CORE_INCS="$CORE_INCS $OPENSSL/.openssl/include"
  CORE_DEPS="$CORE_INCS $OPENSSL/.openssl/include/openssl/ssl.h"
  CORE_LIBS="$CORE_INCS $OPENSSL/.openssl/lib/libssl.a"
  CORE_LIBS="$CORE_INCS $OPENSSL/.openssl/lib/libcrypto.a"
  CORE_LIBS="$CORE_INCS $NGX_LIBDL"
  >>>>
  CORE_INCS="$CORE_INCS $OPENSSL/include"
  CORE_DEPS="$CORE_INCS $OPENSSL/include/openssl/ssl.h"
  CORE_LIBS="$CORE_INCS $OPENSSL/lib/libssl.a"
  CORE_LIBS="$CORE_INCS $OPENSSL/lib/libcrypto.a"
  CORE_LIBS="$CORE_INCS $NGX_LIBDL"
  #修改之后重新configure make
  ```

- 启动时提示找不到`temp`文件夹

  ```bash
  #手动创建相关文件夹
  mkdir /var/temp/nginx/client
  mkdir /var/temp/nginx/proxy
  mkdir /var/temp/nginx/fastcgi
  mkdir /var/temp/nginx/uwsgi
  mkdir /var/temp/nginx/scgi
  ```

- 开启IPV6监听

```bash
$ vim /usr/local/nginx/conf/nginx.conf
...
server{
	listen 80;
	listen [::]:80 ipv6only=on;
	...
}
...
#设置完后重启
```

- `nginx`重启时提示`nginx.pid`丢失

  在`./conf/nginx.conf`文件中设置

  ```bash
  pid        logs/nginx.pid;
  ```

  

## 2.2	配置

### 2.2.1	默认配置文件

```nginx
user  thorgeng;
worker_processes  1;
#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;
pid        logs/nginx.pid;
events {
    worker_connections  1024;
}
http {
    include       mime.types;
    default_type  application/octet-stream;
    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;
    sendfile        on;
    #tcp_nopush     on;
    #keepalive_timeout  0;
    keepalive_timeout  65;
    #gzip  on;
    server {
        listen       8080; # 监听的端口
		listen 	     [::]:8080 ipv6only=on; # 开启ipv6监听
        server_name  localhost;
        charset utf-8;
        #access_log  logs/host.access.log  main;
        location / {
            #root   html;
            #index  index.html index.htm;
		    include uwsgi_params;
		    uwsgi_pass 127.0.0.1:8000;
        }
		location /static/ {	
			alias /home/thorgeng/django/second_project/user_manage/static/;
			index index.html;
		}
        #error_page  404              /404.html;
        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        #}
        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        # location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /home/thorgeng/wordpress$fastcgi_script_name;
        #    include        fastcgi_params;
        #}
        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }


    # another virtual host using mix of IP-, name-, and port-based configuration
    #
    server {
        listen       80;
    #    listen       somename:8080;
        server_name  localhost;
        charset utf-8;
        location / {
            root   html;
            index  index.html index.htm;
        }
    }
    # HTTPS server   ssl 
    #
    #server {
    #    listen       443 ssl;
    #    server_name  localhost;

    #    ssl_certificate      cert.pem;
    #    ssl_certificate_key  cert.key;

    #    ssl_session_cache    shared:SSL:1m;
    #    ssl_session_timeout  5m;

    #    ssl_ciphers  HIGH:!aNULL:!MD5;
    #    ssl_prefer_server_ciphers  on;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}

}

```



### 2.2.2	反向代理





### 2.2.3	负载均衡







# 3.	MySQL

## 3.1	安装

- 删除`mariadb`

```bash
$ rpm -qa | grep maria*
mariadb-libs-5.5.68-1.el7.x86_64
$ yum erase -y mariadb-libs-5.5.68-1.el7.x86_64
```

- 解压并重命名

```bash
$ tar zxf mysql-8.0.28-el7-x86_64.tar.gz -C /usr/local/
$ cd /usr/local/
$ mv mysql-8.0.28-el7-x86_64/ ./mysql
```

- 创建mysql用户和组

```bash
$ groupadd mysql
$ useradd -r -g mysql -s /sbin/nologin mysql
```

- 创建相关目录，变更权限

```bash
$ mkdir /usr/local/mysql/data
$ mkdir /usr/local/mysql/etc
$ mkdir /usr/local/mysql/log
$ chown -R mysql:mysql /usr/local/mysql/
```

- 编辑mysql配置文件

```bash
$ vim /usr/local/mysql/etc/my.cnf
[mysql]
port = 3306
socket = /usr/local/mysql/data/mysql.sock
[mysqld]
user = mysql
port = 3306
mysqlx_port = 33060
mysqlx_socket = /usr/local/mysql/data/mysqlx.sock
basedir = /usr/local/mysql
datadir = /usr/local/mysql/data
socket = /usr/local/mysql/data/mysql.sock
pid-file = /usr/local/mysql/data/mysqld.pid
log-error = /usr/local/mysql/log/error.log
# 这个就是用之前的身份认证插件
default-authentication-plugin = mysql_native_password
# 保证日志的时间正确
log_timestamps = SYSTEM
```

- 初始化数据库

```bash
$ ./bin/mysqld --initialize --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data
# 若提示缺少libaio.so.1  yum -y install libaio
2022-04-01T14:01:32.086926Z 6 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: So(_W!2f,rWq	#这个密码要记住
```

- 启动`mysql`

```bash
$ ./support-files/mysql.server  start
$ ./support-files/mysql.server  restart
$ ./support-files/mysql.server  stop

# 设置systemd控制
$ vi /lib/systemd/system/mysql.service

[Unit]
Description=mysql service
After=network.target 
   
[Service] 
Type=forking 
ExecStart=/usr/local/mysql/support-files/mysql.server start
ExecReload=/usr/local/mysql/support-files/mysql.server  restart
ExecStop=/usr/local/mysql/support-files/mysql.server  stop
PrivateTmp=true 
   
[Install] 
WantedBy=multi-user.target


```

- 登录`mysql`并配置

```sql
$ ./bin/mysql -u root -p
mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY '*****'; # 重置密码
# 创建远程用户登录
mysql> use mysql

mysql> create user 'root'@'%' identified by 'password';
mysql> grant all privileges on *.* to 'root'@'%' with grant option;
mysql> flush privileges;

# 重启，用Navicat尝试远程连接

```





## 3.2	配置

# 4.	Python

## 4.1	安装python3.9.12

- 安装依赖

```bash
$ yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel libffi-devel xz-devel gdbm-devel

```

- 下载，解压，

- 进入解压目录

```bash
$ ./configure --prefix=/usr/local/python39
#configure 完成后往前翻看是否有modules缺失的信息，若有需安装相应依赖，重新configure
$ make && make install
#安装完成后修改环境变量
$ vi /etc/profile  #添加以下代码
PATH=$PATH:/usr/local/python39:/usr/local/python39/bin
export PATH
$ source /etc/profile
```

可能存在的问题：

CentOS默认安装的`openssl`版本为1.0.2，python3.   要求openssl1.1.1以上



### 4.1.1	安装`zlib `

安装`openssl-1.1.1`后会运行失败 需要提前安装`zlib`

http://www.zlib.net/zlib-1.2.12.tar.gz

```bash
$ tar zxf zlib-1.2.11.tgz -C /tmp/
$ cd /tmp/zlib-1.2.11/
# 安装静态库
$ ./configure  
$ make test
$ make install
# 安装共享库
$ make clean
$ ./configure --shared
$ make test
$ make install
$ cp zutil.h /usr/local/include
$ cp zutil.c /usr/local/include
```



### 4.1.2	安装`openssl`

下载源码https://www.openssl.org/source/openssl-1.1.1n.tar.gz，安装至`/usr/local/openssl-1.1.1`

```bash
$ tar zxf openssl-1.1.1n.tar.gz -C /tmp/
$ cd /tmp/openssl-1.1.1n/
$ ./config --prefix=/usr/local/openssl-1.1.1
$ make && make install 
$ openssl version 
OpenSSL 1.0.2k-fips  26 Jan 2017   #安装未完成，还是老版本
$ /usr/local/openssl-1.1.1/bin/openssl version  #运行新版本报错
error while loading shared libraries: libssl.so.1.1: cannot open shared object file: No such file or directory
# 备份老版本
$ mv /usr/bin/openssl /usr/bin/openssl.bak1.0.2
# /usr/include/下不存在openssl  不用管
$ ln -s /usr/local/openssl-1.1.1/bin/openssl /usr/bin/openssl
# 添加新版的函数库
$ echo "/usr/local/openssl-1.1.1/lib/" >> /etc/ld.so.conf
# 更新函数库
$ ldconfig
$ openssl version
OpenSSL 1.1.1n  15 Mar 2022	# 安装成功
```



## 4.2	配置`django`





# 5.部署`django`

## 5.1 将`django`项目放到`linux`系统中

用ftp将开发环境的`django`代码推送至`linux`服务器(需要开放21端口，且服务器需开启`vsftpd`服务)，或使用git

```bash
$ yum install vsftpd
$ systemctl start vsftpd
```



## 5.2 创建虚拟环境，在虚拟环境中安装所要的`python`第三方库及`uWSGI`

```bash
$ python3 -m venv .venv #创建虚拟环境
(.venv)$ pip3 install uwsgi
(.venv)$ pip3 install -r requirement.txt
(.venv)$ python3 manage.py runserver # 试运行Django项目
```

## 5.3 关联`uWSGI`与`django`

在与`manage.py`同级的目录创建`uWSGI`的配置文件`uwsgi.ini`

```bash
#添加配置选择
[uwsgi]
#配置和nginx连接的socket连接
module=second_project.wsgi:application
socket=127.0.0.1:8000
#配置项目路径，项目的所在目录
chdir=/home/thorgeng/django/second_project
#配置wsgi接口模块文件路径,也就是wsgi.py这个文件所在的目录名
wsgi-file=second_project/wsgi.py
#配置启动的进程数
processes=4
#配置每个进程的线程数
threads=2
#配置启动管理主进程
master=True
#配置存放主进程的进程号文件,视情况设置，不固定
pidfile=/home/thorgeng/django/second_project/uwsgi.pid
#配置dump日志记录,视情况设置，不固定
daemonize=/home/thorgeng/django/second_project/uwsgi.log
# 使用uWSGI启动django
$ uwsgi --ini uswgi.ini
```



## 5.4 关联`Nginx`与`uWSGI`

修改`/usr/local/nginx/conf/nignx.conf`文件

```bash
user thorgeng
server {
        listen       8080;
	    listen 	     [::]:8080 ipv6only=on;
        server_name  localhost;
        charset utf-8;
		
        location / {
	    include uwsgi_params;
		    uwsgi_pass 127.0.0.1:8000;
        }
        # 静态文件设置
        # url后时/static/会读取/home/thorgeng/django/second_project/user_manage/static/文件夹内的内容，如果css样式缺失，可能的原因是权限问题，在nginx.conf文件前加`user name`,name为指向的路径/home/.../static/的所有者,
	    location /static/ {
		    alias /home/thorgeng/django/second_project/user_manage/static/;
		    index index.html;
	}
}

```

## 

## 5.5 可能出现的问题

- 网页无`css`样式

查看`nginx`的`error.log`文件`/var/log/nginx/error.log`

```
2022/04/03 12:24:08 [error] 1978#0: *1 open() "/home/thorgeng/django/second_project/user_manage/static/js/bootstrap.min.js" failed (13: Permission denied), client: 192.168.0.104, server: localhost, request: "GET /static/js/bootstrap.min.js HTTP/1.1", host: "192.168.0.106:8080", referrer: "http://192.168.0.106:8080/"
```

以上提示`Permission denied`没有权限，需更改`nginx.conf`中的`user`设置

# 6 Redis

```bash
# /etc/systemd/system/redis.service
[unit]
Description=redis-server
After=network.target

[Service]
Type=forking
ExecStart=/usr/local/redis6/bin/redis-server /usr/local/redis/redis.conf
ExecStop=/usr/local/redis6/bin/redis-cli  shutdown
PrivateTmp=true
Restart=always
RestartSec=1

[Install]
WantedBy=multi-user.target
```

```bash
# /usr/local/redis/redis.conf
port 6379
daemonize yes   # 后台运行
bind 0.0.0.0
```

