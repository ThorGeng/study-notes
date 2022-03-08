# 1.连接MySQL

虚拟机IP192.168.0.120  MySQL  root  19950702   

# 2.创建数据库

## 1.查看当前的数据库

```
mysql> show databases; 
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.02 sec)
```

刚安装 MySQL 时，默认有四个数据库，information_schema，mysql，perfomance_schema，sys 。通常情况下，我们不会直接使用这四个数据库，但千万不要把这四个数据库删了，否则会带来很多不必要的麻烦。如果不小心删了，建议是重新安装 MySQL ，在重装之前把自己的数据迁移出来备份好，或者从其他服务器上迁移一个相同的数据库过来。

## 2.新建数据库

```mysql
mysql> create database mydata_one charset utf8;
```

## 3.进入或切换数据库

```mysql
mysql> use mydata_one
Database changed
```

## 4.显示当前数据库

```mysql
mysql> select database();
+------------+
| database() |
+------------+
| mydata_one |
+------------+
1 row in set (0.00 sec)
```

# 3.创建数据表



## 1.查看数据表

```mysql
mysql> show tables;
Empty set (0.00 sec)
```

## 2.创建表

```mysql
mysql> create table first_table(name varchar(10),age int);
```

## 3.显示表信息

```mysql
mysql> show create table first_table;
+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table       | Create Table                                                                                                                                                |
+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------+
| first_table | CREATE TABLE `first_table` (
  `name` varchar(10) DEFAULT NULL,
  `age` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)
```

也可以用desc

```mysql
mysql> desc first_table;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| name  | varchar(10) | YES  |     | NULL    |       |
| age   | int         | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.01 sec)
```

## 4.增加字段

```mysql
mysql> alter table first_table add address varchar(50);
Query OK, 0 rows affected (0.48 sec)
Records: 0  Duplicates: 0  Warnings: 0
mysql> desc first_table;
+---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
+---------+-------------+------+-----+---------+-------+
| name    | varchar(10) | YES  |     | NULL    |       |
| age     | int         | YES  |     | NULL    |       |
| address | varchar(50) | YES  |     | NULL    |       |
+---------+-------------+------+-----+---------+-------+
3 rows in set (0.01 sec)
```

## 5.删除表的字段

```mysql
mysql> alter table first_table drop address;
Query OK, 0 rows affected (1.33 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc first_table;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| name  | varchar(10) | YES  |     | NULL    |       |
| age   | int         | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)
```

## 6.修改字段的数据类型

```mysql
mysql> alter table first_table modify name varchar(20);
Query OK, 0 rows affected (0.20 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc first_table;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| name  | varchar(20) | YES  |     | NULL    |       |
| age   | int         | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)
```

## 7.修改字段的数据类型并且改名

使用 alter table 表名 change 原字段名 新字段名 数据类型; 修改表中现有字段的字段名和类型

# 4.vba连接MySQL

建立连接

```vb

```









