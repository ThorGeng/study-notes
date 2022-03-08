import shutil
import zipfile
from xml.dom.minidom import parse


def unzip_file(zip_path, unzip_path=None):
    """
    :param zip_path: ofd格式文件路径
    :param unzip_path: 解压后的文件存放目录
    :return: unzip_path
    """
    if not unzip_path:
        unzip_path = zip_path.split('.')[0]
    with zipfile.ZipFile(zip_path, 'r') as f:
        for file in f.namelist():
            f.extract(file, path=unzip_path)

    return unzip_path

def get_info(dir_path, unzip_file_path=None, removed=True):
    """
    :param dir_path: 压缩文件路径
    :param unzip_file_path: 解压后的文件路径
    :param removed: 是否删除解压后的目录
    :return: ofd_info，字典形式的发票信息
    """
    file_path = unzip_file(dir_path, unzip_file_path)
    io = f"{file_path}/OFD.xml"
    element = parse(io).documentElement
    nodes = element.getElementsByTagName('ofd:CustomDatas')
    ofd_info = {}
    for i in range(len(nodes)):
        sun_node = nodes[i].childNodes
        for j in range(len(sun_node)):
            name = sun_node[j].getAttribute('Name')
            value = sun_node[j].firstChild.data
            ofd_info[name] =value
    if removed:
        shutil.rmtree(file_path)
    return ofd_info
    
print(get_info(r"D:\Administrator\下载\电子发票\041002100113_04420071 - 副本.ofd"))

