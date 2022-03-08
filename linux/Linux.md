Linux

# 1.基本命令安装

## 安装ifconfig

```bash
sudo yum install net-tools
```

## 安装wget

```bash
sudo yum install wget
```

# 2.基本命令的使用

## 查看分区

```bash
fdisk -h
```



# 3.安装nginx

## 配置文件目录

```bash
/etc/nginx/conf.d/nginx.conf
```

## 网页文件目录

```bash
/usr/local/nginx/web/index.html
```

## 设置开机自启

在/etc/rc.d/rc.local文件中加入nginx执行文件

```bash
[root@localhost etc]# vi /etc/rc.d/rc.local
```

加入

```
/usr/local/nginx/sbin/nginx
```

注意：vi /etc/rc.d/rc.local默认没有执行的权限，需要授权

```bash
[root@localhost etc]# chmod +x /etc/rc.d/rc.local
```

# 4. 安装MySQL

提前删除centos自带的Mariadb数据库，运行以下命令，删除mariadb

```bash
[root@localhost thorgeng]# rpm -qa | grep maria*
mariadb-libs-5.5.68-1.el7.x86_64
[root@localhost thorgeng]# rpm -e --nodeps mariadb-libs-5.5.68-1.el7.x86_64
```

下载MySQL

```bash
[root@localhost local]# wget https://downloads.mysql.com/archives/get/p/23/file/mysql-8.0.22-linux-glibc2.12-x86_64.tar.xz
```

解压压缩包，解压tar.xz格式的文件，需要先xz -d xxx.tar.xz 将 xxx.tar.xz解压成 xxx.tar 然后，再用 tar xvf xxx.tar来解包

```bash
[root@localhost local]# xz -d mysql-8.0.22-linux-glibc2.12-x86_64.tar.xz
[root@localhost local]# tar -xvf mysql-8.0.22-linux-glibc2.12-x86_64.tar
```

解压之后的文件夹重命名为mysql

```bash
[root@localhost local]# mv mysql-8.0.22-linux-glibc2.12-x86_64/ mysql
```

新增用户并授权(仅供参考)

```
groupadd mysql
useradd -g mysql -s /sbin/nologin mysql
chown -R mysql:mysql /data
```

在/etc目录中创建my.cnf文件，内容如下：

```
[mysqld]
user=root
port=3306
basedir=/usr/local/mysql
datadir=/usr/local/mysql/data
log-error=/usr/local/mysql/log/mysql-err.log
default_authentication_plugin=mysql_native_password
socket=/tmp/mysql.sock
max_connections=10000
max_connect_errors=10
lower-case-table-names=1
sql-mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
[mysql]

[client]
port=3306

```

初始化MySQL

```bash
[root@localhost mysql]# ./bin/mysqld --initialize --user=mysql --basedir=/usr/local/mysql/ --datadir=/usr/local/mysql/data/
```

配置mysql服务器的启动文件

```bash
[root@localhost mysql]# cp ./support-files/mysql.server /etc/rc.d/init.d/mysqld
[root@localhost mysql]# chmod +x /etc//rc.d/init.d/mysqld 
```

此时mysql server已经交给service和chkconfig管理 

可通过service mysqld start/stop/restart命令控制启动/关闭/重启 

可通过chkconfig mysqld on设置开机自启

添加mysql客户端环境变量,在/etc/profile末尾添加（注意等号两边不要有空格）

```bash
export PATH=$PATH:/usr/local/mysql/bin
```

保存后让其生效

```bash
[root@localhost mysql]# source /etc/profile
```

启动数据库并设置开机自启

```bash
[root@localhost mysql]# service mysqld start
Starting MySQL...... SUCCESS! 
```

查看初始密码

```bash
[root@localhost mysql]# cat /usr/local/mysql/log/mysql-err.log | grep password
2021-02-20T13:52:15.884788Z 6 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: CcqyPW3dxj_v
```

登录mysql

```bash
[root@localhost mysql]# mysql -u root -p
```

修改密码

```
mysql> alter user 'root'@'localhost' identified by '19950702';
```

设置可从其他主机访问

```
mysql> UPDATE mysql.user SET `Host`='%' WHERE User='root';
mysql> flush privileges;
```

还原密码验证插件

```
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'passowrd';
```

开放3306端口

```bash
[root@localhost mysql]# firewall-cmd --permanent --zone=public --add-port=3306/tcp
success
[root@localhost mysql]# firewall-cmd --reload
success

```

