Attribute VB_Name = "时空客商表"
Option Explicit
'Dim cnn As ADODB.Connection     '连接对象变量
'Dim rs As ADODB.Recordset           '记录集对象变量

Sub 更新客商表()
    '将工作表数据存入数组
    Dim arr '保存需要导入的数据
    Dim brr '有问题未导入的数据
    Dim str
	Dim cnn
	Dim rs
    arr = Sheets("客商表维护").Range("A1").CurrentRegion
    
    
    '建立数据库连接
    Set cnn = CreateObject("adodb.connection")
    With cnn
        .Provider = "microsoft.ace.oledb.12.0"
        .Open ThisWorkbook.Path & "\时空客商表.accdb"
    End With
    
    Dim myTable As String, sql As String
    myTable = "时空客商表"        '指定数据表名
    Dim i As Integer, j As Integer
    For i = 2 To UBound(arr)
        If arr(i, 2) <> "" Then
                'MsgBox arr(i, 1) & "  单位编号列不能为空!!", vbInformation, "提示"
                'continue
                'cnn.Close
                'Set cnn = Nothing
                'Exit Sub
            sql = "select * from " & myTable _
                & " where dwmc='" & arr(i, 1) & "'"
            Set rs = CreateObject("adodb.recordset")
            rs.Open sql, cnn, 1, 3
            
            If rs.RecordCount = 0 Then
                '如果数据表中没有工作表中某行数据，则添加数据
                rs.AddNew
                For j = 1 To rs.Fields.Count
                    'rs.Fields(j - 1) = arr(i, j)
                    If j = 3 Then
                        rs.Fields(j - 1) = Application.Text(Now(), "yyyy-mm-dd hh:mm:ss")
                    Else
                        rs.Fields(j - 1) = arr(i, j)
                    End If
                Next j
                rs.Update
            Else
                '如果数据表中有工作表中某行数据，就将数据进行更新
                'For j = 1 To rs.Fields.Count
                '    rs.Fields(j - 1) = arr(i, j)
                'Next j
                'rs.Update
                MsgBox arr(i, 1) & " 已存在未保存"
            End If
            rs.Close
            Set rs = Nothing
        Else
            MsgBox arr(i, 1) & "  单位编号列不能为空!!", vbInformation, "提示"
            str = str + arr(i, 1) + ","
            
        End If
    Next i
    MsgBox "保存完毕。", vbInformation, "提示"
    Sheets("客商表维护").Range("2:" & Rows.Count).Clear
    If str <> "" Then
        brr = VBA.Split(str, ",")
        Debug.Print UBound(brr)
        Sheets("客商表维护").Range("A2").Resize(UBound(brr), 1) = Application.WorksheetFunction.Transpose(brr)
    End If
        
    
    cnn.Close
    Set cnn = Nothing
    Call 查询客商表
    
End Sub

Sub 查询客商表()
	Dim cnn
	Dim rs
    Dim sh As Worksheet
    Dim bool_skksb, bool_ksbwh As Boolean
    bool_skksb = False
    bool_ksbwh = False
    For Each sh In Worksheets
        If sh.Name = "时空客商表" Then
            bool_skksb = True
        End If
        If sh.Name = "客商表维护" Then
            bool_ksbwh = True
        End If
    Next
    
    If bool_skksb = False Then
        Worksheets.Add
        ActiveSheet.Name = "时空客商表"
    End If
    If bool_ksbwh = False Then
        Worksheets.Add
        ActiveSheet.Name = "客商表维护"
        ActiveSheet.Range("A1") = "单位名称"
        ActiveSheet.Range("B1") = "单位编号"
    End If
    Dim arr
	Set cnn = CreateObject("adodb.connection")
    With cnn
        .Provider = "microsoft.ace.oledb.12.0"
        .Open ThisWorkbook.Path & "\时空客商表.accdb"
    End With
    
    Dim sql As String
    sql = "select * from 时空客商表 order by lrrq "
    '执行SQL命令之后，提取到的数据会被加载到内存中
    'Set rs = New ADODB.Recordset
	Set rs = CreateObject("adodb.recordset")
    'rs = cnn.Execute(sql)       '将记录集存到rs中
    rs.Open sql, cnn, 1, 3
    Sheets("时空客商表").Rows.Clear
    '获取字段名，使用循环
    Dim i As Integer
    For i = 0 To rs.Fields.Count - 1
        Sheets("时空客商表").Cells(1, i + 1) = rs.Fields(i).Name
    Next
    arr = Application.Transpose(rs.GetRows(, 1, Array("dwmc", "dwbh", "lrrq"))) '记录存入数组
    Sheets("时空客商表").Range("A2").Resize(UBound(arr), 3) = arr
    '将记录集rs中的数据返回到工作表
    'Sheets("时空客商表").Range("A2").CopyFromRecordset rs
    MsgBox "时空客商表已刷新"
    '4、释放对象变量空间
    rs.Close: Set rs = Nothing
    cnn.Close: Set cnn = Nothing

End Sub

'
'Sub 调试()
'     Dim cnn
'	 Dim rs
'	 Set cnn = CreateObject("adodb.connection")
'    'Set cnn = New ADODB.Connection
'    With cnn
'        .Provider = "microsoft.ace.oledb.12.0"
'        .Open ThisWorkbook.Path & "\时空客商表.accdb"
'    End With
'
'    Dim sql As String
'    sql = "update 时空客商表 set lrrq = '" & Application.Text(Now(), "yyyy-mm-dd hh:mm:ss") & "'"
'    '执行SQL命令之后，提取到的数据会被加载到内存中
'    'Set rs = New ADODB.Recordset
'     Set rs = CreateObject("adodb.recordset")
'    'rs = cnn.Execute(sql)       '将记录集存到rs中
'    rs.Open sql, cnn, adOpenKeyset, adLockOptimistic
'    'rs.Close: Set rs = Nothing
'    cnn.Close: Set cnn = Nothing
'
'End Sub

Sub 更新金蝶供应商()
    Dim cnn
    Dim rs
    Dim mrows,sql
    '连接金蝶供应商表
	mrows = Sheets("供应商").UsedRange.rows.Count
    If mrows <= 1 Then
        mrows = 2
    End If
    Sheets("供应商").Range("2:" & mrows).Clear
    '建立数据库连接
    Set cnn = CreateObject("adodb.connection")
    
    cnn.ConnectionString = "DRIVER={ODBC Driver 18 for SQL Server};Encrypt=yes;TrustServerCertificate=yes;Server=192.168.0.42;Database=AIS20150122160957;Uid=sa;Pwd=123"
    cnn.Open
    'MsgBox "成功"
    sql = "select Fname,F_102,Fnumber from t_supplier"
    Set rs = CreateObject("adodb.recordset")
    rs.Open sql, cnn, 1, 3
    Sheets("供应商").Range("A2").CopyFromRecordset rs
    
    rs.Close
    Set rs = Nothing
    cnn.Close
    Set cnn = Nothing

    '删除空格
    Sheets("供应商").Activate
    Sheets("供应商").Columns("A:A").Select
    Selection.Replace What:=" ", Replacement:="", LookAt:=xlPart, _
        SearchOrder:=xlByRows, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    '提示
    MsgBox "已更新"
End Sub

Sub 更新金蝶客户()
    Dim cnn
    Dim rs
    Dim mrows,sql
    '连接金蝶客户表
	mrows = Sheets("客户").UsedRange.rows.Count
    If mrows <= 1 Then
        mrows = 2
    End If
    Sheets("客户").Range("2:" & mrows).Clear
    '建立数据库连接
    Set cnn = CreateObject("adodb.connection")
    
    cnn.ConnectionString = "DRIVER={ODBC Driver 18 for SQL Server};Encrypt=yes;TrustServerCertificate=yes;Server=192.168.0.42;Database=AIS20150122160957;Uid=sa;Pwd=123"
    cnn.Open
    'MsgBox "成功"
    sql = "select Fname,F_102,Fnumber from t_Organization"
    Set rs = CreateObject("adodb.recordset")
    rs.Open sql, cnn, 1, 3
    Sheets("客户").Range("A2").CopyFromRecordset rs
    
    rs.Close
    Set rs = Nothing
    cnn.Close
    Set cnn = Nothing
    
    '删除空格
    Sheets("客户").Activate
    Sheets("客户").Columns("A:A").Select
    Selection.Replace What:=" ", Replacement:="", LookAt:=xlPart, _
        SearchOrder:=xlByRows, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    
    MsgBox "已更新"
End Sub





