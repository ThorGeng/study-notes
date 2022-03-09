from django.http import HttpResponse
from django.shortcuts import render
import requests
# Create your views here.
def index(requset):
    return HttpResponse("欢迎使用")


def user_list(request):
    user = []
    for i in range(20):
        user.append({'username':'jack'+str(i),'age':i})
    return render(request,"user_list.html",{'hello':user})

def user_add(request):
    return HttpResponse("添加用户")

def login(request):
    return render(request,"login.html")

# def news(request):
#     #伪联通新闻中心
#     #Request URL: http://www.chinaunicom.com.cn/api/article/NewsByIndex/2/2022/03/news
#     res = requests.get("http://www.chinaunicom.com.cn/api/article/NewsByIndex/2/2022/03/news")
#     data_list= res.json()
#     print(data_list)
#     return render(request,"news.html")