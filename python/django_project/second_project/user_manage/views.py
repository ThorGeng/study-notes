from pyexpat import model
from django.shortcuts import render,redirect
from matplotlib import widgets
from matplotlib.pyplot import title
from user_manage import models
from django import forms
# Create your views here.

"""注意数据库数据增删改查的语句写法"""

def depart_list(request):
    """部门列表"""
    #数据库中取数
    queryset = models.Department.objects.all()
    
    
    return render(request,"depart_list.html",{"queryset":queryset})

def depart_add(request):
    """添加部门"""
    if request.method =="GET":
        return render(request,"depart_add.html")
    #获取post传递过来的数据
    title = request.POST.get("title")
    #保存到数据库
    #增
    models.Department.objects.create(title=title)

    return redirect("/depart/list/")

def depart_delete(request,nid):
    """删除部门"""
    #删
    models.Department.objects.filter(id=nid).delete()
    #print(nid)
    return redirect("/depart/list/")

def depart_edit(request,nid):
    """编辑部门"""
    if request.method =="GET":
        #查
        queryset = models.Department.objects.filter(id=nid).first()
        return render(request,"depart_edit.html",{"title":queryset})   
    #获取post传递过来的数据
    title = request.POST.get("title")
    
    #改
    models.Department.objects.filter(id=nid).update(title=title)

    return redirect("/depart/list/")

def user_list(request):

    """用户列表"""
    queryset = models.UserInfo.objects.all()
    
    return render(request,"user_list.html",{"queryset":queryset})


class UserModelForm(forms.ModelForm):
    class Meta:
        model=models.UserInfo
        fields=["name","gender","password","age","account","create_time","depart"]    
        # widgets={
        #     "name":forms.TextInput(attrs={"class":"form-control"})
        # }
    def __init__(self,*args,**kwargs):
        super().__init__(*args,**kwargs)
        for name,field in self.fields.items():
            field.widget.attrs={"class":"form-control"}
            


def user_add(request):
    """增加用户"""
    if request.method=="GET":
        form = UserModelForm()
        return render(request,"user_add.html",{"form":form})
    #用户POST提交数据,数据校验
    form= UserModelForm(data=request.POST)
    if form.is_valid():
        #保存到数据库
        #print(form.cleaned_data)
        form.save()
        return redirect('/user/list/')
    #校验失败
    #print(form.errors)
    return render(request,"user_add.html",{"form":form},)

def user_edit(request,nid):
    """修改用户"""
    obj = models.UserInfo.objects.get(id=nid)
    if request.method=="GET":
        form = UserModelForm(instance=obj)
        return render(request,"user_edit.html",{"form":form})
    form = UserModelForm(request.POST,instance=obj)
    if form.is_valid():
        form.save()
        return redirect("/user/list/")    

def user_delete(request,nid):
    """删除用户"""
    models.UserInfo.objects.filter(id=nid).delete()
    #print(nid)
    return redirect("/user/list/")
    
