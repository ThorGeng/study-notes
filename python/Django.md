# 1. 创建项目 

## 1.1安装Django

```bash
$ pip3 install django
```

## 1.2 在Django中创建项目

进入存放项目的目录，执行`django-admin` 命令，生成项目文件夹，生成下列文件.

```bash
$ django-admin.py startproject first_project  
$ ls
first_project   manage.py
$ ls first_project 
asgi.py  __init__.py  settings.py  urls.py  wsgi.py
```

```
manage.py---项目的管理、启动项目、创建APP、数据管理

__init__.py---

settings.py---项目配置文件，经常操作

urls.py---URL和函数的对应关系，经常操作

wsgi.py---接受网络请求

asgi.py---接受网络请求
```





# 2. 创建APP

进入`Django`项目目录，创建一个APP，会生成APP文件夹，目录结构如下：


```python
$ python3 manage.py startapp app01
$ ls
first_project  app01  manage.py
$ ls app01/
admin.py  apps.py  __init__.py  migrations  models.py  tests.py  views.py   
```

`migrations`---数据库字段变更

`apps.py`---APP启动类

`views.py`---函数【重要】

`models.py`---对数据库操作【重要】

# 3  快速入手

- 确保APP已注册

  `settings.py`中的`INSTALLED_APPS`

- 编写URL和视图函数的对应关系【urls.py】

- 编写视图函数【views.py】

  `urls.py`中定义`url`（网址）与views中函数（`views.py`中的函数）的对应关系，

  `views.py`中定义函数，`return` 通过`render(request,"index.html")`调用html文件

  `index.html`存放在`templates`目录中，调用时，根据APP的注册顺序在每个app下的templates目录下寻找对应的html文件

## 3.1  再写一个页面

## 3.2 templates模板目录

 根据APP的注册顺序，在每个app下的templates目录下寻找对应的html文件

##  3.3 静态文件

默认情况下存放在APP下的`/static/`文件夹下

##  3.4  模板文件语法

本质上：在HTML中写一些占位符，由数据对这些占位符进行替换

`views.py`：

```python
from django.http import HttpResponse
from django.shortcuts import render

def user_list(request):
    user = []
    for i in range(20):
        user.append({'username':'jack'+str(i),'age':i})
    return render(request,"user_list.html",{'hello':user})
	#传递了参数｛'hello':user｝，运行过程中会将user_list.html文件中的hello替换为传递的user变量，
```

`user_list.html`:

```html
<!DOCTYPE html>
<html lang='en'>
    <head>
        <title>User List</title>
    </head>
    <body>
        {% for row in hello %}
        <!--for row in hello 相当于 for row in user ,user为views.py中传递过来的列表user-->
			<h1>{{row.username}}---{{row.age}}</h1>
		{% endfor %}
        
    </body>
</html>
```



# 4.数据库操作

## 4.1安装mysqlclient

```bash
$ pip install mysqlclient
```

## 4.2 创建数据库

```sql
CREATE DATABASE `first_project_data` CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';
```



## 4.3 配置数据库

`Django`默认使用`sqlite3`，要更改为`MySQL`，需在更改`.\first_project\settings.py`文件

```python
DATABASES= {
     'default':{
     'ENGINE':'django.db.backends.mysql', #数据库引擎
     'NAME':'blog_db',
	 'USER':'root',
	 'PASSWORD':'19950702',
     'HOST':'192.168.0.120',
	 'POST':3306,   
     }
}
```

## 4.4 创建数据表

在`models.py`文件中添加类：

```python
from django.db import models

# Create your models here.
class UserInfo(models.Model):
    name = models.CharField(max_length=32)
    password = models.CharField(max_length=64)
    age = models.IntegerField()
```

ORM会根据上述类的定义，在数据库中建立对应的表，表名为`APP名_类名`，即`app01_userinfo`

执行命令生成表：

```bash
$ python manage.py makemigrations
$ python manage.py migrate
```

## 4.5 操作表中的数据























