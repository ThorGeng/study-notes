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

1. 去官网http://nginx.org/下载对应的nginx包，推荐使用稳定版本

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
$ tar -zxvf nginx-1.20.2.tar.gz
```

4. 创建`makefile`

```shell
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
--with-openssl=/usr/local/openssl-1.0.1j \ #指定openssl路径
--with-http_ssl_module  	#开启ssl模块

./configure --prefix=/usr/local/nginx --pid-path=/var/run/nginx/nginx.pid --lock-path=/var/lock/nginx.lock --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --with-http_gzip_static_module --http-client-body-temp-path=/var/temp/nginx/client --http-proxy-temp-path=/var/temp/nginx/proxy --http-fastcgi-temp-path=/var/temp/nginx/fastcgi --http-uwsgi-temp-path=/var/temp/nginx/uwsgi --http-scgi-temp-path=/var/temp/nginx/scgi --with-openssl=/usr/local/openssl1.1.1 --with-http_ssl_module
```

5. 编译 & 安装

```shell
$ make
$ make install

```

![1648611626899](E:\git\study-notes\linux\1648611626899.png)

6. 启动`nginx`

```bash
$ /usr/local/nginx/sbin/nginx  #启动
$ /usr/local/nginx/sbin/nginx -s stop  #停止
$ /usr/local/nginx/sbin/nginx -s reload #重启
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
	listen [::1]:80 ipv6only=on;
	...
}
...
#设置完后重启
```



## 2.2	配置

# 3.	MySQL

## 3.1	安装

## 3.2	配置

# 4.	Python

## 4.1	安装

- 安装依赖

```bash
$ yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel libffi-devel

```

- 下载，解压，
- 处理openssl问题

```bash
#修改./Modules/Setup文件

```



- 进入解压目录

```bash
$ ./configure --prefix=/usr/local/python3.10
#configure 完成后往前翻看是否有modules缺失的信息，若有需安装相应文件，重新configure
```

可能存在的问题：

openssl  版本不对

![image-20220330004510776](C:\Users\ThorGeng\AppData\Roaming\Typora\typora-user-images\image-20220330004510776.png)

安装openssl 后运行失败 需要安装zlib  

![image-20220330004532063](C:\Users\ThorGeng\AppData\Roaming\Typora\typora-user-images\image-20220330004532063.png)

### 4.1.1	安装zlib 

安装`openssl `后运行失败 需要提前安装`zlib`

下载源码

安装静态库

安装共享库

### 4.1.2	安装openssl

下载源码，安装，