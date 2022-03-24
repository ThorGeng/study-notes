import requests        #导入requests包
import json
def get_translate_date(word=None):
    url = 'http://fanyi.youdao.com/translate'
    From_data={'i':word,
               'from':'AUTO',
               'to':'AUTO',
               'smartresult':'dict',
               'client':'fanyideskweb',
               'salt':'16481053795914',
               'sign':'72be41b60338b7f79271fb326fb7ef7b',
               'lts':'1648105379591',
               'bv':'e2a78ed30c66e16a857c5b6486a1d326',
               'doctype':'json',
               'version':'2.1',
               'keyfrom':'fanyi.web',
               'action':'FY_BY_REALTIME'
               }
     #请求表单数据
    response = requests.post(url,data=From_data)
    #将Json格式字符串转字典
    content = json.loads(response.text)
    print(content)
    #打印翻译后的数据
    #print(content['translateResult'][0][0]['tgt'])
if __name__=='__main__':
    get_translate_date('Today')
