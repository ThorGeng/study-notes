import requests #导入requests 模块
from bs4 import BeautifulSoup  #导入BeautifulSoup 模块
import os

class BeautifulPicture():
  def __init__(self):
    self.headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36'}
    self.web_url = 'https://unsplash.com/t/nature'
    self.folder_path = 'D:\BeautifulPicture'

  def request(self,url):
    r=requests.get(url)

    return r

  def mkdir(self,path):
    path = path.strip()
    isExists = os.path.exists(path)
    if not isExists:
      os.makedirs(path)

  def save_img(self,url,name):
    print('开始保存图片---')
    img = self.request(url)
    #time.sleep(5)
    file_name=name+'.jpg'
    with open(file_name,'ab') as f:
      f.write(img.content)

  def get_pic(self):
    r=self.request(self.web_url)
    all_img = BeautifulSoup(r.text, 'lxml').find_all('img', class_='YVj9w')
    self.mkdir(self.folder_path)
    os.chdir(self.folder_path)
    
    for img in all_img:
      img_url=img['src']
      width_pos = img_url.index('?ixlib')
      img_url=img_url[ : width_pos]
      print(img_url)
      name_start_pos = img_url.index('photo')
      img_name = img_url[name_start_pos : ]
      self.save_img(img_url,img_name)

beauty = BeautifulPicture()  #创建一个类的实例
beauty.get_pic()











    
  
