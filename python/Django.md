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

`manage.py`---项目的管理、启动项目、创建APP、数据管理

`__init__.py`---

`settings.py`---项目配置文件，经常操作

`urls.py`---URL和函数的对应关系，经常操作

`wsgi.py`---接受网络请求

`asgi.py`---接受网络请求

## 1.3 创建数据库

`Django`默认使用`sqlite3`，这里更改为`MySQL`，更改`~/bolg_project/blog/settings.py`文件

```python
DATABASES= {
     'default':{
         'ENGINE':'django.db.backends.mysql', #数据库引擎
         'NAME':'blog_db',
	 'USER':'root',
	 'PASSWORD':'19950702',
         'HOST':'192.168.41.245',
	 'POST':3306,   
     }
}
```

如果提示`Did you install mysqlclient?`，先检查系统环境是否安装`mysqlclient`。

如果系统环境没有安装，则执行以下命令安装`mysqlclient`

```python
yum install python-devel -y
yum install mysql-devel -y
yum install gcc -y
pip3 install mysqlclient
```

若系统环境已安装`mysqlclient`，则在项目的虚拟环境执行

```python
pip3 install mysqlclient
```



创建数据库

```python
(blog_env) [thorgeng@localhost blog_project]$ python3 manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, sessions
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying auth.0001_initial... OK
  Applying admin.0001_initial... OK
  Applying admin.0002_logentry_remove_auto_add... OK
  Applying admin.0003_logentry_add_action_flag_choices... OK
  Applying contenttypes.0002_remove_content_type_name... OK
  Applying auth.0002_alter_permission_name_max_length... OK
  Applying auth.0003_alter_user_email_max_length... OK
  Applying auth.0004_alter_user_username_opts... OK
  Applying auth.0005_alter_user_last_login_null... OK
  Applying auth.0006_require_contenttypes_0002... OK
  Applying auth.0007_alter_validators_add_error_messages... OK
  Applying auth.0008_alter_user_username_max_length... OK
  Applying auth.0009_alter_user_last_name_max_length... OK
  Applying auth.0010_alter_group_name_max_length... OK
  Applying auth.0011_update_proxy_permissions... OK
  Applying auth.0012_alter_user_first_name_max_length... OK
  Applying sessions.0001_initial... OK
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

## 3.1  再写一个页面

## 3.2 templates模板目录

 根据APP的注册顺序，在每个app下的templates目录下寻找对应的html文件

##  3.3 静态文件

































##    2.1 定义模型

在`~/blog_project/blog_app/models.py`文件中添加：

```python
from django.db import models
# Create your models here.
class Topic(models.Model):
    '''用户学习的主题'''
    text = models.CharField(max_length=200)
    date_added = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        '''返回模型的字符串表示'''
        return self.text
```



## 2.2 激活模型

在`~/blog_project/blog/settings.py`文件中添加：

```python
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'blog_app',  #添加创建的应用
]
```

调用`makemigrations`:

```python
(blog_env) [thorgeng@localhost blog_project]$ python3 manage.py makemigrations blog_app
Migrations for 'blog_app':
  blog_app/migrations/0001_initial.py
    - Create model Topic
```

迁移项目：

```python
(blog_env) [thorgeng@localhost blog_project]$ python3 manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, blog_app, contenttypes, sessions
Running migrations:
  Applying blog_app.0001_initial... OK
```

`django`会在数据库中根据`models.py`中定义的`Topic`类新建一个数据表，表名为`应用名_类名`，即`blog_app_topic`。该表有三个字段，`id`,`text`,`date_added` ，对应`Topic`类的两个属性

## 2.3 管理网站

### 2.3.1 创建超级用户

```python
(blog_env) [thorgeng@localhost blog_project]$ python3 manage.py createsuperuser
Username (leave blank to use 'thorgeng'): admin
Email address: 
Password: 
Password (again): 
Superuser created successfully.
```

### 2.3.2 向管理网站注册模型

在`~/blog_project/blog_app/admin.py`文件中添加：

```python
from django.contrib import admin
# Register your models here.
from blog_app.models import Topic
admin.site.register(Topic)
```

浏览器中输入http://localhost:8000/admin，查看效果

### 2.3.3 添加主题

向管理网站注册Topic 后，我们来添加第一个主题。为此，单击Topics进入主题网页，它几乎是空的，这是因为我们还没有添加任何主题。单击Add，你将看到一个用于添加新主
题的表单。在第一个方框中输入Chess ，再单击Save，这将返回到主题管理页面，其中包含刚创建的主题。
下面再创建一个主题，以便有更多的数据可供使用。再次单击Add，并创建另一个主题Rock Climbing 。当你单击Save时，将重新回到主题管理页面，其中包含主题Chess和
Rock Climbing。

## 2.4 定义模型Entry

在`~/blog_project/blog_app/models.py`文件中添加：

```python
class Entry(models.Model):
    """学习到有关某个主题的具体知识"""
    topic = models.ForeignKey(to="Topic",on_delete=models.DO_NOTHING)
    text = models.TextField()
    date_added = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name_plural = 'entries'

    def __str__(self):
        """返回模型的字符串表示"""
        return self.text[:50] + "..."
```

## 2.5 迁移模型Entry

每新增一个模型，都要迁移数据库

```PYTHON
(blog_env) [thorgeng@localhost blog_project]$ python3 manage.py makemigrations blog_app
Migrations for 'blog_app':
  blog_app/migrations/0002_entry.py
    - Create model Entry
(blog_env) [thorgeng@localhost blog_project]$ python3 manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, blog_app, contenttypes, sessions
Running migrations:
  Applying blog_app.0002_entry... OK
```

## 2.6 向网站注册`Entry`

在`~/blog_project/blog_app/admin.py`文件中注册`Entry`：

```python
from django.contrib import admin

# Register your models here.

from blog_app.models import Topic,Entry

admin.site.register(Topic)
admin.site.register(Entry)
```

浏览器中输入http://localhost:8000/admin，查看效果

# 3. 创建网页：学习笔记主页

使用`Django`创建网页的过程通常分三个阶段：定义URL、编写视图和编写模板。

## 3.1 映射URL

在`~/blog_project/blog/urls.py`文件中添加：

```python
from django.contrib import admin
from django.urls import include,path

urlpatterns = [
    path('admin/', admin.site.urls),
    path('',include(('blog_app.urls','blog_app'),namespace='blog_app'))
]
```

在`~/blog_project/blog_app/urls.py`文件中添加:

```python
"""定义blog_app的URL模式"""
from django.conf.urls import url
from . import views

urlpatterns = [
    path('^$',view.index,name='index')
]
```

## 3.2 编写视图

在`~/blog_project/blog_app/views.py`文件中添加:

```python
from django.shortcuts import render

# Create your views here.
def index(request):
    '''学习笔记的主页'''
    return render(request,'blog_app/index.html')

```

## 3.3 编写模板

新建`~/blog_project/blog_app/templates/blog_app/index.html`文件：

‘’



























