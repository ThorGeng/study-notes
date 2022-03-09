from django.http import HttpResponse
from django.shortcuts import render

# Create your views here.
def index(requset):
    return HttpResponse("欢迎使用")


def user_list(request):
    user = []
    for i in range(20):
        user.append({'username':'jack'+str(i),'age':18+i})
    return render(request,"user_list.html",{'hello':user})

def user_add(request):
    return HttpResponse("添加用户")