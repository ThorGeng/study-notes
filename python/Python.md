# 1	变量
## 1.1 定义规则
1、在程序全局使用的变量，尽量定义在文件头
2、变量名只能是字母、下划线、数字的任意组合，其他形式不合法
3、变量名的第一个字符不能是数字
## 1.2 命名规范
驼峰体：
```python
AgeOfOldboy = 18
```
下划线：
```python
age_of_oldboy = 18
```
首字母大写是用来定义类名的
## 1.3 变量的修改和删除
```python
name = "ThorGeng"
name = "thor"
#"ThorGeng" 还存在在内存中，只是将name指向了"thor"的地址
#删除变量
del name
```
# 2	数据类型 
## 2.1 整型int
```python
>>> age = 26
>>> type(age)
<class 'int'>
>>> long = 100000000
>>> type(long)
<class 'int'>
```
## 2.2 浮点型float
```python
>>> num = 2.312312
>>> type(num)
<class 'float'>
```
## 2.3 字符串
```python
>>> name = "thorgeng"
>>> type(name)
<class 'str'>
#字符串的拼接，只能是双方都是字符串，不能跟数字或其他类型拼接
>>> first_name = 'thor'
>>> second_name = 'geng'
>>> first_name + second_name
'thorgeng'
>>> first_name * 3
'thorthorthor'
>>> print(name.center(50,"-")) #填充
---------------------thorgeng---------------------
>>> print(name.count("g")) #某个字符在字符串中出现的次数
2
>>> print(name.endswith("g")) #判断字符串以什么结尾
True
>>> print(name.find("o"))  #查找
2
>>> print(name.isdigit())  #判断是否是数字
False
>>> print(name.replace("o","q"))  #替换
thqrgeng
>>> print(name.split())  #字符串分割成列表
['thorgeng']
>>> print(name.upper())
THORGENG
>>> print(name.title())
Thorgeng
>>> print("正在录入凭证:{}---->{}".format(old_id,new_id))	#格式化输出字符串
>>>	print(datetime.strftime('%Y-%m-%d'))	#格式化输出日期

```
## 2.4 布尔型
`True`
`False`

## 2.5 列表list[]
```python
>>> names= []
>>> type(names)
<class 'list'>
>>> names = ["Alex","jack","Rain","Thor"]
#取值
>>> names[0]
'Alex'
>>> names[-1]	#-1表示倒数第一个
'Thor'
#修改列表内元素
>>> names[3] = "ThorGeng"
>>> names
['Alex', 'jack', 'Rain', 'ThorGeng']
#向列表内插入元素
>>> names.insert(2,"Vivianna")
>>> names
['Alex', 'jack', 'Vivianna', 'Rain', 'ThorGeng']
#追加元素
>>> names.append("Sun")
>>> names
['Alex', 'jack', 'Vivianna', 'Rain', 'ThorGeng', 'Sun']
#删除元素  pop() 删除列表的最后一个值并返回该值
>>> names.remove('Vivianna') #从左删除第一 个
>>> names
['Alex', 'jack', 'Rain', 'ThorGeng', 'Sun']
>>> del names[4]
>>> names
['Alex', 'jack', 'Rain', 'ThorGeng']
#判断某元素是否在列表里
>>> 'Alex' in names
True
>>> 'Sun' in names
False
>>> names.sort()  #列表排序
>>> names
['Alex', 'Rain', 'Thor', 'jack']
>>> names.reverse()  #列表反转
>>> names
['jack', 'Thor', 'Rain', 'Alex']
>>> for i in names: #列表循环
	print(i)
jack
Thor
Rain
Alex
>>> for i in enumerate(names):  #列表循环，打印索引
	print(i)
(0, 'jack')
(1, 'Thor')
(2, 'Rain')
(3, 'Alex')
```
## 2.6 元组tuple()
## 2.7 字典dictionary{}
`{key1:value1, key2:value2}`
- 特性
  - key-value结构
  - key必须为不可变数据类型，必须唯一
  - 可以存放多个value、可修改、可以不唯一
  - 无序
  - 查询速度快
- 增加操作
```python
>>> mes ={
	"alex":[23,"CEO",66000],
	"黑姑娘":[18,"行政",4000],
	}
>>> mes["佩奇"]=[24,"讲师",40000]
>>> mes
{'alex': [23, 'CEO', 66000], '黑姑娘': [18, '行政', 4000], '佩奇': [24, '讲师', 40000]}
```
- 删除操作 
```python
>>>mes.pop("佩奇")
>>>del names("黑姑娘")
>>>mames.clear()
```
- 查找操作
```python
>>>dic['key']  #返回字典中key对应的值 
>>>dic.get(key,default=None) #返回字典中key对应的值，若key不再字典中，则返回default的值
>>>'key' in dic  #存在则返回True，不存在则返回False
>>>dic.keys() #返回一个包含字典所有key的列表
>>>dic.values() #返回一个包含字典所有value的列表
>>>dic.items()	#返回一个包含所有(键，值)元组的列表
```
- 修改操作
```python
>>>dic['key']='new_value'
```
- 循环
```python
>>> for k in dic.keys() #遍历字典的键
>>> for k in dic  #推荐使用这种，效率速度快
>>> for k,v in dic.items()	#遍历字典的键值对，并以列表形式返回

```
- 嵌套
```python
>>>dic['key'] = {key1:value1,key2:value2}
```
## 2.8 集合

类似于列表，但每个元素都是唯一的

# 3	运算符
## 3.1 算术运算
以下假设变量:`a = 10,b = 20`
| <span style="display:inline-block;width:100px">运算符</span> | 描述               | 实例                                |
| :--------------- | :---------------------------- | ---------- |
| +     | 两个对象相加         | a + b输出结果 30                    |
| -      | 得到负数或是一个数减去另一个数   | a - b输出结果 -20                   |
| *      | 两个数相乘或是返回一个被重复若干次的字符串 | a * b输出结果 200                   |
| /      | x除以y                                     | b / a 输出结果 2                    |
| %      | 取模 - 返回除法的余数                      | b % a 输出结果 0                    |
| **     | 幂 -返回x的y次幂                           | a ** b为10的20次方                  |
| //     | 取整除 - 返回商的整数部分                  | 9//2输出结果 4，9.0//2.0输出结果4.0 |

## 3.2 比较运算

| <span style="display:inline-block;width:100px">运算符</span> | 描述                   |
| :----------------------------------------------------------- | :--------------------- |
| ==                                                           | 比较对象是否相等       |
| !=                                                           | 比较两个对象是否不相等 |
| >                                                            | 返回x是否大于y         |
| <                                                            | 返回x是否小于y         |
| >=                                                           | 返回x是否大于等于y     |
| <=                                                           | 返回x是否小于等于y     |

## 3.3 逻辑运算

以下假设变量：`a = 10, b = 20`

| <span style="display:inline-block;width:60px">运算符</span> | 描述                               | 实例                      |
| :---------------------------------------------------------- | :--------------------------------- | ------------------------- |
| and                                                         | 判断多个条件均为真时，返回真       | a>10 and b>10 结果为false |
| or                                                          | 判断多个条件任意条件为真时，返回真 | a>10 or b > 10 结果为true |
| not                                                         | 取反                               | not a >b 结果为true       |

## 3.4 赋值运算

## 3.5 成员运算   

| <span style="display:inline-block;width:60px">运算符</span> | 描述                                                | 实例 |
| :---------------------------------------------------------- | :-------------------------------------------------- | ---- |
| in                                                          | 如果在指定的序列中找到值返回True，否则返回False     |      |
| not in                                                      | 如果在指定的序列中没有找到值返回True，否则返回False |      |

# 4	流程控制

## 4.1 单分支

```python
if 条件：
	满足条件后要执行的代码
```

## 4.2 双分支

```python
if 条件：
	满足条件后要执行的代码
else:
    不满条条件后要执行的代码
#Python代码缩进的原则：
#---顶级代码必须顶行写
#---同一级别的代码，缩进必须一致
#---官方建议缩进用4个空格，但是用2个也可以，不过不建议使用
```

## 4.3 多分支

```python
if 条件：
	满足条件执行代码
elif 条件:
    满条条件执行代码，前提是上一层的if条件不满足
elif 条件：
	满条条件执行代码，前提是上一层的elif条件不满足
elif 条件：
	满条条件执行代码，前提是上一层的elif条件不满足
else:
    上面的所有条件都不满足执行该段代码
#程序由上往下执行，发现一个条件满足就执行，不再往下判断
```

#  5	循环语句

## 5.1 `For`循环   

```python
>>> for i in range(3):
	print(i)
0
1
2
>>> for i in "banana":
	print(i)
b
a
n
a
n
a
>>> 
```

## 5.2 `While`循环

```python
while 条件：
	print("满足条件！")
```

## 5.3 `break` & `continue`语句

1. `contiune`的语法作用：循环遇到`continue`，终止本次循环，进入下一次循环

2. `break`的语法作用：循环遇到`break`，终止当前循环

## 5.4 实例

- 99乘法表

```python
>>> for row in range(1,10):
		for col in range(1,row + 1):
			print(f"{row}x{col}={row * col}",end=" ")#print不换行在后面加end
		print("")
	
1x1=1 
2x1=2 2x2=4 
3x1=3 3x2=6 3x3=9 
4x1=4 4x2=8 4x3=12 4x4=16 
5x1=5 5x2=10 5x3=15 5x4=20 5x5=25 
6x1=6 6x2=12 6x3=18 6x4=24 6x5=30 6x6=36 
7x1=7 7x2=14 7x3=21 7x4=28 7x5=35 7x6=42 7x7=49 
8x1=8 8x2=16 8x3=24 8x4=32 8x5=40 8x6=48 8x7=56 8x8=64 
9x1=9 9x2=18 9x3=27 9x4=36 9x5=45 9x6=54 9x7=63 9x8=72 9x9=81 
>>> 
```

- 京牌摇号小程序

```python
import string
import random
count = 0 
while count < 3:
    car_nums = []
    for i in range(20):
        str1 = random.choice(string.ascii_uppercase)
        str2 = "".join(random.sample(string.ascii_uppercase+string.digits,5))
        c_num = f"京{str1}-{str2}"
        print(i+1,c_num)

    choice = input("请输入喜欢的车牌号：").strip()
    if choice in car_nums:
        print(f"恭喜您选择了新车牌号：{choice}")
        exit("Good Luck!!")
    else:
        print("不合法的选择！！！")
    count +=1
```

  

- `string`模块

```python
  >>> import string
  >>> string.ascii_letters 
  'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
  >>> string.ascii_uppercase  #大写字母
  'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  >>> string.ascii_lowercase  #小写字母
  'abcdefghijklmnopqrstuvwxyz'
  >>> string.punctuation  #特殊字符
  '!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~'
  >>> string.digits   #数字
  '0123456789'
```
# 6	文件操作
## 6.1 文件操作流程
```python
>>>f=open(filename)  #打开文件
>>>f.write("我是程序员！") #写操作
>>>f.read()  #读操作
>>>f.readline() #读一行
>>>f.readlines() 
>>>f.close() #保存并关闭
```
文件打开模式：
- r 只读模式
- w 创建模式，若文件已存在，则覆盖旧文件
- a 追加模式，新数据写在文件末尾，只能写不能读
- w+ 写读  先写在读  只能读写的内容
- r+ 读写 可以读已经存在的内容，写的内容写在了末尾
- a+ 追加读
## 6.2  循环文件
```python
f.open("filename")
for line in f:
    line = line.split()  #将一行转换为列表
    print(line)
```
## 6.3 二进制模式操作文件
```python
f.open("454454.jpg",encoding="gbk") #以哪种编码模式打开文件
f.open("454454.jpg","rb") #二进制只读模式打开文件
```
- rb 二进制只读模式
- wb 二进制创建模式
- ab  二进制追加模式
## 6.4 其他功能
```python
f.seek()  #移动文件读取指针到文件指定位置
f.tell()  #返回光标当前位置
f.flush() #刷新缓存区，强制把数据写入文件 
```

## 6.5 修改文件

```python
f = open('filename','r+')

#1、加载到内存
data=f.read()
new_data=data.replace("old_char","new_char")

#2、清空文件
f.seek(0)
f.truncate()

#3、把新内容写回硬盘
f.write(new_data)

f.close()
```

## 6.6	实例

- 全局文本检索替换

```python
import sys

old_str = sys.argv[1]
new_str = sys.argv[2]
filename = sys.argv[3]
#1、打开文件
f = open(filename,'r+')
data = f.read()
#2、计数
old_str_count=data.count(old_str)
new_data=data.replace(old_str,new_str)
#3、清空文件
f.seek(0)
f.truncate()
4、写入文件
f.write(new_data)
f.close()

print(f"成功替换{old_str}为{new_str},共{old_str_count}次")
```

- 用户认证登录

```python
f = open("account.db","r")
accounts={}
for line in f:
    line=line.strip().split(",")  #strip去掉换行符
    accounts[line[0]]=line


while True:
    user=input("请输入用户名：").strip()
    if user not in accounts:
        print("该用户未注册、、、")
    elif accounts[user][2]=='1':
        print(f"{user}已被锁定，请联系管理员")
        
    else:
        count = 0
        while count < 3:
            pwd=input("请输入密码：").strip()
            if pwd == accounts[user][1]:
                print(f"{user}登陆成功！")
                exit()
            else:
                print("密码输入错误！")
                count+=1
                if count==3:
                    print(f"输错了{user}密码，需要锁定帐号")
                    accounts[user][2]="1"
                    f2=open("account.db","w")
                    for val in accounts.values():
                        line=','.join(val)+"\n"
                        f2.write(line)
                    f2.close()
                continue
        
         
#rint(accounts)a
f.close()
```
- 读写`json`文件

```python
import json

#读取json文件，有中文必须加参数encoding='utf-8'
with open("settings.json",'r',encoding='utf-8') as f:
        info = json.load(f)

#写入json文件，有中文必须加参数encoding='utf-8'，ensure_ascii=False
#indent=4  缩进4   输出美观
with open ('settings.json','w',encoding="utf-8") as f:
    json.dump(account_info,f,ensure_ascii=False,indent=4)

```

  

# 7	函数编程

## 7.1 函数的特性
- 减少重复代码
- 使程序变得可扩展
- 使程序变得可维护
## 7.2 函数的参数
- 形参、实参
```python
def calc(x,y):	#形参
	res =x**y
	print(res)

a=4
b=4

calc(a,b)	#实参
```
- 默认参数
	定义参数时给形参赋值，调用函数时可以不传入该参数，一般把默认参数放在最后面
- 关键字参数
	关键参数必须放在位置参数之后，调用时必须写明参数名
- 非固定参数
```python
def stu_register(name,age,*args):	#*args会把多传入的参数变成一个元组形式
	print(name,age,args)
def stu_register(name,age,**kwargs):	#**kwargs会把多传入的参数变成一个字典形式
	print(name,age,**kwargs)
```
## 7.3 函数的返回值`return`
返回结果
函数遇到`return`代表函数结束
若函数中未指定`return`，则函数的返回值为`None`
## 7.4 局部变量 & 全局变量
- 在函数中定义的变量成为局部变量，在程序的一开始定义的变量为全局变量
- 全局变量的作用域是整个程序，局部变量的作用域是定义该变量的函数
- 变量的查找顺序是**局部变量**>**全局变量**
- 当全局变量与局部变量同名时，在定义局部变量的函数内，局部变量起作用，在其他地方全局变量起作用
- 在函数里是不能直接修改全局变量的，一定要修改的话，在函数内部使用关键字`global`
## 7.5 函数传递列表、字典的注意事项
将列表或字典传递给函数，函数能改变列表或字典里元素的值

若要函数不修改列表的值，可以使用以下句式

```python
def function_name(listname[:])	#向函数传递列表的副本
```

虽然向函数传递列表的副本可保留原始列表的内容，但除非有充分的理由需要传递副本，否则还是应该将原始列表传递给函数，因为让函数使用现成列表可避免花时间和内存创建副本，从而提高效率，在处理大型列表时尤其如此。



## 7.6 内置函数
```python
abs()	#取绝对值
all()	#全部为True返回True
any()	#任意一个为True返回True
chr()	#返回数值对应的ascii码
dict()	#生成字典
dir()	#打印当前程序的所有变量名
locals()	#打印当前作用域的所有变量名和变量值
map()	#
max()	#求可迭代对象的最大值
min()
sum()
ord()	#打印ascii字符对应的十进制数字
enumerate()	#打印索引和值
round()		#
str()	#转换为字符串
type()	#返回变量的数据类型
zip()	#配对
filter()	#把迭代器的每一个元素交给第一个参数，若结果为真，则保留这个值

```

# 8	类与继承

## 8.1	定义类

```python
class Dog():
    def __init__(self,name,age):
        self.name = name
        self.age = age
    def sit(self):
        print(f"{self.name.title()} is now sitting.")
        
```

## 8.2	类的实例化

```python
class Dog():
    --snip---

my_dog = Dog("Willie",6)
my_dog.sit()
'''
输出结果：

'''
```
## 8.3 继承
创建子类时，父类必须包含在当前文件中，且位于子类前面
```python
class Car():
    def __init__(self, make, model, year):
        self.make = make
        self.model = model
        self.year = year
    def get_descriptive_name(self):
        long_name=str(self.year)+" "+self.make+" "+self.model
        return print(long_name.title())

#将实例用作属性
class Battery():
    def __init__(self,battery_size = 70):
        '''初始化电瓶的属性'''
        self.battery_size  = battery_size
    def describle_battery(self):
        print(f"This car has a {str(self.battery_size)}-kWh battery")     

class ElectricCar(Car):
    def __init__(self, make, model, year):
        #初始化父类的属性
        super().__init__(make, model, year)
        '''
        #子类特有的属性
        self.battery_size = 70
        '''
        #将实例用作属性
        self.battery =Battery()		
'''
    def describle_battery(self):
        #子类特有的方法
        print(f"This car has a {str(self.battery_size)}-kWh battery")
'''

my_tesla = ElectricCar("tesla", 'model S', 2016)
my_tesla.get_descriptive_name()
#my_tesla.describle_battery()
my_tesla.battery.describle_battery()
```

# 9	`os`

```
os.getcwd()		返回当前路径
os.path
```





# 10	`openpyxl`

## 10.1	`Workbook`对象

### 10.1.1	属性

```python
wb.sheetnames		#工作簿的所有工作表名
```



### 10.1.2	方法

```python
create_sheet(title,index)	#在index位置创建sheet
```





## 10.2	`Sheet`对象

```python
ws = wb["sheet1"]
max = ws.max_row	#工作表使用的最大行，可能会包含显示为空的行 
ws = iter_rows(min_row=None, max_row=None, min_col=None, max_col=None)
#返回指定单元格区域

wb.sheetnames	
```



## 10.3	`Cell`对象

```python
cell(row,col).value	#单元格的值
```





## 10.4	操作`Excel`文件

```python
import openpyxl 

wb=Workbook()	#新建工作簿
wb=load_workbook(path)	#打开工作簿
#打开xlsm格式的excel
wb = openpyxl.load_workbook(path, keep_vba=True, data_only=True)

print(wb.sheetnames)

ws = wb.active		#选定工作表
ws = wb["Sheet1"]	#选定工作表
ws = wb.get_sheet_by_name("Sheet1")	#选定工作表
ws = wb.create_sheet("Sheet2")	#创建工作表
ws = wb.create_sheet("Sheet2",0)	#在第一个位置创建工作表

ws['A1']=  "Hello,World!"	#写入数据
ws.append=[1,2,3,4]

```





# 11	`PyMuPDF`



# 12	`Pymouse`与`Pykeyboard`

## 12.1	安装

```bash
$ pip install PyUserInput
```

## 12.2	使用

```python
from pymouse import PyMouse
from pykeyboard import PyKeyboard
mouse = PyMouse()
keyboard = PyKeyboard()
#鼠标操作
mouse.click(113,240,1)	#点击鼠标
mouse.position()		#返回鼠标位置

#键盘操作
keyboard.tap_key(keyboard.enter_key)	#按下回车
keyboard.press_key(keyboard.control_key)		#
keyboard.tap_key('v')							#
keyboard.release_key(keyboard.control_key)		#Ctrl+V
keyboard.type_string(string)			#输入字符串，仅支持英文数字，不支持中文


#想要输入汉字需要配合pyperclip和ctrl+v使用
import pyperclip
pyperclip.copy(string)
keyboard.press_key(keyboard.control_key)
keyboard.tap_key('v')
keyboard.release_key(keyboard.control_key)

```



# 13	`requests`

- `GET`请求

```python
import requests
response = requests.get("https://www.baidu.com")
print(response)               # <Response [200]>  200表示成功
"""
response.text 	读取服务器响应的内容,一般为网页源码
response.encoding 	获取文本编码，utf-8/ISO-8859-1
response.content 获取响应内容的二进制形式，一般图片、音视频等使用此方式获取
response.status_code 获取当前请求的响应码
response.headers 获取响应的响应头
response.cookies 获取响应的cookies内容
response.url 获取请求的url
"""
```
```python
"""带请求头的请求"""
headers = {"User-Agent":'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36'}
requests.get(url, headers=headers)
```
```python
import requests
headers = {"User-Agent": "ozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.162 Safari/537.36"}

"""带参数的请求"""
#方法一
url = 'https://www.baidu.com/s?wd=Python'
# url中包含了请求参数，即在请求链接处？位置后面就是携带的参数
response = requests.get(url, headers=headers)
print(response.text)
#方法二
url = 'https://www.baidu.com/s' 
# 请求参数是一个字典 即wd=Python和pn=10
params = {'wd':'Python','pn':10} 
# 在params上设置字典
response = requests.get(url, headers=headers, params=params) 
print(response.text)
```

- `POST`请求

用法：

```python
response = requests.post(url, data = 字典类型的参数,headers=字典类型的请求头)
```

```python
import requests  
# 字典类型的表单参数
data = {
    'a': '好好学习，天天向上！',
    'b': '强身健体，天天Happy'
}
response = requests.post('http://httpbin.org/post', data=data)
print(response.json()) #打印转换后的响应数据
```

- 代理`IP`的使用

**为什么要使用代理？**

为了让服务器认为不是同一个客户端在请求，因为同一个客户端的ip地址是固定不变的，使用ip代理就可以不断的切换ip地址，这样就可以防止我们的真实地址被泄露，甚至被追究。

```python
import requests
import random

url = "https://www.baidu.com"
# 获取的代理ip地址，放在一个字典中，可以写多个使用随机数不断变化选取
# 注意：免费代理的地址是有失效时间的，自己可以去上面网站找合适的
ips = ['221.222.84.131:9000','124.42.7.103:80','116.214.32.51:8080','222.73.68.144:8090','117.121.100.9:3128']
proxy = {
    'http': random.choice(ips),
}
response = requests.get(url, proxies=proxy)
print(response.text)
```



# 附录	即拿即用函数

1. 判断字符是否是中文？：

   ```python
   def is_chinese_char(k):
       """判断字符是否是中文，是则返回True"""
       cp = ord(k)
       if ((cp >= 0x4E00 and cp <= 0x9FFF) or  #
               (cp >= 0x3400 and cp <= 0x4DBF) or  #
               (cp >= 0x20000 and cp <= 0x2A6DF) or  #
               (cp >= 0x2A700 and cp <= 0x2B73F) or  #
               (cp >= 0x2B740 and cp <= 0x2B81F) or  #
               (cp >= 0x2B820 and cp <= 0x2CEAF) or
               (cp >= 0xF900 and cp <= 0xFAFF) or  #
               (cp >= 0x2F800 and cp <= 0x2FA1F)):  #
           return True
   
       return False
   ```

   


















