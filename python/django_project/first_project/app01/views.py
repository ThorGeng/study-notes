from django.http import HttpResponse
from django.shortcuts import render

# Create your views here.
def index(requset):
    return HttpResponse("欢迎使用")


def user_list(request):
    return render(request,"user_list.html")

def user_add(request):
    return HttpResponse("添加用户")