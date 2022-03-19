# 1  基础知识

## 1.1  变量

### 1.1.1  强制声明变量

```vb
'强制声明变量，写在模块的第一行
Option Explicit
```

### 1.1.2  定义常量

```
Const 常量名 As 数据类型
```

### 1.1.3  定义变量

```vb
Dim 变量名 As 数据类型
```

## 1.2  判断语句

```vb
If 条件1 Then
    执行语句
ElseIf 条件2 Then
    执行语句
Else
	执行语句
End If
```



## 1.3  循环语句

###  1.3.1   `For`循环

```vb
For 循环变量 = 初值 To 终值 (Step 步长)   '步长客卫负数'
	循环体	'可以嵌套循环
	Exit For  '退出循环
Next
'For循环的另一种写法
For Each obj in Range("A1:A100")   '遍历Range区域内的每一个单元格
	
Next

```

### 1.3.2  `Do While ...Loop` 循环

```vb
Do While 条件
    循环体
Loop
```

## 1.4  工作表对象`sheet`

### 1.4.1  选择工作表

`Select`代表选定对象， `Activate`代表激活对象。
`Select`可以选定多个对象， `Activate`只能激活一个对象 

```vb
Worksheets(1).Select
Worksheets(1).Activate
Sheets("Sheet1").Select
Sheets("Sheet1").Activate
ActiveSheet  '当前工作表	
Sheets.Select   '选定所有工作表
```

### 1.4.2  重命名

```vb
Sheets("sheet1").Name = "孙兴华"
Sheet1.Name = "孙兴华"
```

### 1.4.3  新建工作表 Add

新建工作表后，新建`sheet`为当前工作表

```vb
Sheets.Add
Sheets.Add before:=Sheets("sheet1") '在sheet1前面加一张工作表
Sheets.Add after:=Sheets("sheet1") '在sheet1后面加一张工作表
Sheets.Add before:=Sheets("sheet1"), Count:=3 '在sheet1前面加3张工作表
Sheets.Add(before:=Sheets("sheet1")).Name = "孙兴华"   '新建工作表的同时命名
```

### 1.4.4	删除工作表

```vb
Sheets("sheet1").Delete 	'删除指定工作表
```

### 1.4.4	复制工作表

复制工作表后，复制的`sheet`为当前工作表

```vb
Sheets("sheet1").Copy before:=Sheets(1)
Sheets("sheet1").Copy after:=Sheets(1)
```

### 1.4.5	移动工作表

```vb
sheets("sheet1").move before:=sheet(1)
sheets("sheet1").move after:=sheet(1)
```

### 1.4.6	引用工作表

`worksheets`后只能跟`sheet`对象

`Sheets`后面即可以是`sheet`对象，也可以是宏或图表

```vb
Worksheets("Sheet1").Activate
Sheets("Sheet1").Activate
```



## 1.5	对象

初始化对象 `New`

### 1.5.1	给对象复制

```vb
Set 变量名称 = 要存储的对象名称
```

## 1.6	函数`Function`

### 1.6.1	字符串函数

```vb
Len(String)		'返回字符串的长度
Trim(String)	'删除字符串两头的空格并返回
Replace(String,"a","A")		'将字符串String中的a替换为A
Lcase(String)	'转换为小写
Ucase(String)	'转换为大写
Left(String,num)
Right(String,num)
Mid(String,num1,num2)
Instr(string,)	'寻找字符串出现的位置
Split(string,".")	'分割字符串，返回数组
```



## 1.7	过程`Sub`

# 1  数据库操作



## 1.1  连接数据库

### 1.1.1 连接`Access`数据库

```vb
'建立数据库连接
Set cnn = CreateObject("adodb.connection")
With cnn
    .Provider = "microsoft.ace.oledb.12.0"
    .Open ThisWorkbook.Path & "\时空客商表.accdb"
End With
```

### 1.1.2 连接`SQL Server`数据库

```vb
Set cnn = New ADODB.Connection
cnn.ConnectionString = "Provider=SQLOLEDB;Server=192.168.0.42;Database=AIS20150122160957;Uid=sa;Pwd=123"
'一般情况下连接字符串用这个。若这个提示错误，可以用下面的
'cnn.ConnectionString = "DRIVER={ODBC Driver 18 for SQL Server};Encrypt=yes;TrustServerCertificate=yes;
'Server=192.168.0.42;Database=AIS20150122160957;Uid=sa;Pwd=123"
'需要在微软官网下载安装Microsoft ODBC Driver 18 for SQL Server
cnn.Open
```

## 1.2  生成记录集

```vb
Set rs = CreateObject("adodb.recordset")
rs.Open sql, cnn, adOpenKeyset, adLockOptimistic
```

### 1.2.1  记录集的属性方法

`rs.Fields.Count`---   返回记录集的字段个数

`rs.Fields(i).Name`---  第`i`个字段的名字

`rs.RecordCount` ---  记录集的记录个数

`rs.Addnew` --- 向记录集中添加记录，一般与`update`同时使用完成向数据库中添加数据

`rs.Fields(j) = i` ---  将变量`i`赋值给记录集第`j`个字段，一般在`addnew`，`update`时使用

`rs.Update` ---  将记录集中的数据添加到数据库

`rs.GetRows()`

### 1.2.2  读取记录集的数据

```vb
'读取字段名
For i = 0 To rs.Fields.Count - 1
        Cells(1, i + 1) = rs.Fields(i).Name
Next
'读取记录
Range("A1").CopyFromRecordset rs  '直接复制，不包含字段名（标题行）


```



### 1.2.3  更新记录集

```vb
rs.AddNew
For i = 1 To rs.Fields.Count
rs.Fields(i - 1) = Cells(row_num, i)	'逐字段更新记录集游标所在的行'
Next i
rs.Update
```





## 1.3  关闭连接

```vb
'释放变量空间
rs.Close: Set rs = Nothing
cnn.Close: Set cnn = Nothing
```

# 2  `TreeView`控件

# 10   即拿即用代码

```vb
'工作表选中的单元格发生变化，按钮保持在同一个位置
Private Sub Worksheet_SelectionChange(ByVal Target As Range)
    Button1.Top = Range("A" & ActiveWindow.ScrollRow).Top + 100
    'ActiveWindow.ScrollRow  返回或设置活动窗格或窗口最上面显示的行号
End Sub
```

```vb
'关闭开启屏幕更新
Excel.Application.ScreenUpdating = False
Excel.Application.ScreenUpdating = True
'关闭屏幕提示
Excel.Application.DisplayAlerts = False
Excel.Application.DisplayAlerts = True
```

```vb
'删除当前工作表的所有空行
Sub DeleteBlankRow()
    Dim lngFirstRow As Long
    Dim lngLastRow As Long
    Dim a As Long
    lngFirstRow = ActiveSheet.UsedRange.Row  '已用单元格第一行的行序数
    lngLastRow = lngFirstRow + ActiveSheet.UsedRange.Rows.Count - 1
    'UsedRange.Rows.Count 已用单元格区域的占用的行数
    For a = lngLastRow To lngFirstRow Step -1
        If Application.WorksheetFunction.CountA(Rows(a)) = 0 Then
        'CountA: 返回参数列表中非空的单元格个数
            Rows(a).Delete
        End If
    Next
End Sub
```





