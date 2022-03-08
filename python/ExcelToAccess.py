import xlrd
import os
import win32com.client
"""
    将增值税发票服务平台导出的发票数据导入Access数据库
"""

def readExcel(path):
    """
    根据excel文件路径读取文件内容
    
    """
    xls_file = path
    print(path)
    workbook = xlrd.open_workbook(xls_file)
    sheet1 = workbook.sheet_by_name("发票信息")
    sheet2 = workbook.sheet_by_name("货物信息")
    nrows = sheet1.nrows
    ncols = sheet1.ncols
    nrows2 = sheet2.nrows
    ncols2=sheet2.ncols
    
    fplx = sheet1.cell_value(0,0)
    
    """    读取货物信息    """
    hwxx={}   
    for i in range(2,nrows2):
        hw=[]
        if sheet2.cell_value(i,1)+sheet2.cell_value(i,2) in hwxx:
            for j in range(3,ncols2):
                hw.append(sheet2.cell_value(i,j))
            hwxx[sheet2.cell_value(i,1)+sheet2.cell_value(i,2)].append(hw)
        else:
            hwxx[sheet2.cell_value(i,1)+sheet2.cell_value(i,2)]= []
            for j in range(3,ncols2):
                hw.append(sheet2.cell_value(i,j))
            hwxx[sheet2.cell_value(i,1)+sheet2.cell_value(i,2)].append(hw)
                 
    """读取发票信息"""  
    fpxx={}
    for i in range(2,nrows):
        fp=[]
        if sheet1.cell_value(i,12) in fpxx:
            continue
        else:
            
            for j in range(1,ncols):
                fp.append(sheet1.cell_value(i,j))
            fpxx[sheet1.cell_value(i,12)] = fp
    writeAccess(fplx,fpxx,hwxx)
    
def searchWithSuffixxes(base_path,suffixes):
    """
    查找当前路径之下所有的特定后缀(suffixes)的文件
    """
    for lists in os.listdir(base_path):
        path = os.path.join(base_path,lists)
        if os.path.isfile(path):  
            if path.endswith(suffixes):
                readExcel(path)
        if os.path.isdir(path):
            searchWithSuffixxes(path,suffixes)
            
def connectAccess():
    """连接Access数据库"""
    global conn
    conn = win32com.client.Dispatch(r"ADODB.Connection")
    #rs = win32com.client.Dispatch(r"ADODB.Recordset")
    DSN = 'PROVIDER = Microsoft.ace.oledb.12.0;DATA SOURCE = "F:\明康财务.accdb"'
    conn.Open(DSN)
    print("连接成功")
        
def closeAccess():
    conn.Close()
   
def writeAccess(fplx,fpxx,hwxx):
    
    
    
    for jym in fpxx.keys():
        #print(jym)
        sql = "select * from 发票信息 where 校验码='" + jym + "'"
        rs= win32com.client.Dispatch(r"ADODB.Recordset")
        rs.Open(sql,conn,1,3)
        #print(rs.RecordCount)
        if rs.RecordCount == 0:
            #print(sr[2]+"未导入")
            rs.AddNew()
            if fplx =="增值税普通发票（电子）":
                for i in range(rs.Fields.Count-5):
                    #print(i)
                    rs.Fields.Item(i).value=fpxx[jym][i]
                rs.Fields.Item(18).value=fpxx[jym][19]
                rs.Fields.Item(19).value=fpxx[jym][20]
                rs.Fields.Item(20).value=fpxx[jym][21]
                rs.Fields.Item(22).value=fpxx[jym][18]
            else:
                for i in range(rs.Fields.Count-2):
                    rs.Fields.Item(i).value=fpxx[jym][i]            
            rs.Fields.Item(rs.Fields.Count-2).value=fplx
            rs.Update()
            
            sql = "select * from 货物信息 where 发票号码 = '"+ fpxx[jym][1] +"'"
            rs_hw= win32com.client.Dispatch(r"ADODB.Recordset")
            rs_hw.Open(sql,conn,1,3)
            
            dmhm = fpxx[jym][0]+fpxx[jym][1]
            #print(len(hwxx[dmhm]))
            for i in range(len(hwxx[dmhm])):
                #print(len(hwxx[dmhm][i]))
                rs_hw.AddNew()
                rs_hw.Fields.Item(0).value=fpxx[jym][0]
                rs_hw.Fields.Item(1).value=fpxx[jym][1]
                #print(
                for j in range(2,rs_hw.Fields.Count):
                    #print(j)
                    rs_hw.Fields.Item(j).value = hwxx[dmhm][i][j-2]
            rs_hw.Update()
            
base_path = os.getcwd()
connectAccess()
searchWithSuffixxes(base_path,'.xls')
closeAccess()

















