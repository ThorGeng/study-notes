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

urls.py---URL和函数的对应关系（路由），经常操作

wsgi.py---接受网络请求

asgi.py---接受网络请求
```





# 2. 创建APP

进入`Django`项目目录`first_project`，创建一个APP，会生成APP文件夹，目录结构如下：


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

  ```python
  INSTALLED_APPS = [
      'django.contrib.admin',
      'django.contrib.auth',
      'django.contrib.contenttypes',
      'django.contrib.sessions',
      'django.contrib.messages',
      'django.contrib.staticfiles',
      'app01.apps.App01Config', #注册创建的APP
  ]
  ```

  

- 编写URL和视图函数的对应关系【`.\first_project\urls.py`】(根路由)

  ```PYTHON
  from django.contrib import admin
  from django.urls import path
  from app01 import views   
  
  urlpatterns = [
      path('admin/', admin.site.urls),
      path('index/', views.index),  #浏览器网址url为index/时，执行app01中views.py内的index函数
      path('user/list/',views.user_list),
      path('user/add/',views.user_add),
      path('login/',views.login),  
  ]
  ```

  `views.py`

  ```python
  from django.http import HttpResponse
  from django.shortcuts import render
  import requests
  # Create your views here.
  def index(requset):
      return render(request,"index.html")   #调用html文件
  ```

  

- 编写视图函数【`views.py`】

  `urls.py`中定义`url`（网址）与views中函数（`views.py`中的函数）的对应关系，

  `views.py`中定义函数，`return` 通过`render(request,"index.html")`调用html文件

  `index.html`存放在`templates`目录中，调用时，根据APP的注册顺序在每个app下的templates目录下寻找对应的html文件

## 3.1  再写一个页面

## 3.2 templates模板目录

 根据APP的注册顺序，在每个app下的`templates`目录下寻找对应的html文件

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

## 4.4	创建数据表

在`models.py`文件中添加类：

```python
from django.db import models

# Create your models here.
class UserInfo(models.Model):
    name = models.CharField(max_length=32)
    password = models.CharField(max_length=64)
    age = models.IntegerField()
```

`ORM`会根据上述类的定义，在数据库中建立对应的表，表名为`APP名_类名`，即`app01_userinfo`

同时同时会自动生成定义的字段

执行命令生成表：

```bash
$ python manage.py makemigrations
$ python manage.py migrate
```

## 4.5	操作表中的数据

```python
from user_manage import models
# 查询user_manage中的全部数据
queryset=models.Department.objects.all()
#增加数据
models.Department.objects.create(title=title)
#删除数据
models.Department.objects.filter(id=nid).delete()
#更改数据
models.Department.objects.filter(id=nid).update(title=title)
```

## 4.6 `ModelForm`表单

```python
class UserModelForm(forms.ModelForm):
    class Meta:
        model=models.UserInfo
        fields=["name","gender","password","age","account","create_time","depart"]
        # fields="__all__"
        # widgets={
        #     "name":forms.TextInput(attrs={"class":"form-control"})
        # }
    def __init__(self,*args,**kwargs):
        #为ModelForm设置样式
        super().__init__(*args,**kwargs)
        for name,field in self.fields.items():
            field.widget.attrs={"class":"form-control"}
```

























