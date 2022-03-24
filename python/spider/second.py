#coding=utf-8
import requests
from bs4 import BeautifulSoup

resp=requests.get('https://www.baidu.com') #请求百度首页
print(resp) #打印请求结果的状态码
#print(resp.content) #打印请求到的网页源码

bsobj=BeautifulSoup(resp.content,'lxml') #将网页源码构造成BeautifulSoup对象，方便操作
"""
a_list=bsobj.find_all('a') #获取网页中的所有a标签对象
text=""
for a in a_list:
    href=a.get('href')#打印a标签对象的href属性，即这个对象指向的链接地址
    text+=href+'\n' #加入到字符串中，并换行
with open('url.txt','w') as f: #在当前路径下，以写的方式打开一个名为'url.txt'，如果不存在则创建
    f.write(text) #将
"""
p_list=bsobj.find_all('p')
for p in p_list:
    print(p.string)
for parent in bsobj.parents:
    if parent is None:
        print(parent)
    else:
        print(parent.name)
