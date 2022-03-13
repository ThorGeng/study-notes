from pyexpat import model
from django.db import models
from django.forms import CharField
from matplotlib.pyplot import title
from sklearn import model_selection
from sklearn.metrics import max_error

# Create your models here.
class Department(models.Model):
    """部门表"""
    title = models.CharField(verbose_name="部门",max_length=32)
    
    def __str__(self):
        #输出该对象的时候输出结果为  self.title
        return self.title

class UserInfo(models.Model):
    """员工表"""
    name = models.CharField(verbose_name="姓名",max_length=16)
    password = models.CharField(verbose_name="密码",max_length=64)
    age = models.IntegerField(verbose_name="年龄")
    account = models.DecimalField(verbose_name="余额",max_digits=10,decimal_places=2,default=0)
    create_time = models.DateTimeField(verbose_name="入职时间")

    depart = models.ForeignKey(verbose_name="部门",to="Department",to_field="id",on_delete=models.CASCADE)
    #django自动生成depart_id字段
    #
    gender_choices=(
        (1,"男"),
        (2,"女"),
    )
    gender = models.SmallIntegerField(verbose_name="性别",choices=gender_choices)
