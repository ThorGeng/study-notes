Attribute VB_Name = "ʱ�տ��̱�"
Option Explicit
'Dim cnn As ADODB.Connection     '���Ӷ������
'Dim rs As ADODB.Recordset           '��¼���������

Sub ���¿��̱�()
    '�����������ݴ�������
    Dim arr '������Ҫ���������
    Dim brr '������δ���������
    Dim str
	Dim cnn
	Dim rs
    arr = Sheets("���̱�ά��").Range("A1").CurrentRegion
    
    
    '�������ݿ�����
    Set cnn = CreateObject("adodb.connection")
    With cnn
        .Provider = "microsoft.ace.oledb.12.0"
        .Open ThisWorkbook.Path & "\ʱ�տ��̱�.accdb"
    End With
    
    Dim myTable As String, sql As String
    myTable = "ʱ�տ��̱�"        'ָ�����ݱ���
    Dim i As Integer, j As Integer
    For i = 2 To UBound(arr)
        If arr(i, 2) <> "" Then
                'MsgBox arr(i, 1) & "  ��λ����в���Ϊ��!!", vbInformation, "��ʾ"
                'continue
                'cnn.Close
                'Set cnn = Nothing
                'Exit Sub
            sql = "select * from " & myTable _
                & " where dwmc='" & arr(i, 1) & "'"
            Set rs = CreateObject("adodb.recordset")
            rs.Open sql, cnn, 1, 3
            
            If rs.RecordCount = 0 Then
                '������ݱ���û�й�������ĳ�����ݣ����������
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
                '������ݱ����й�������ĳ�����ݣ��ͽ����ݽ��и���
                'For j = 1 To rs.Fields.Count
                '    rs.Fields(j - 1) = arr(i, j)
                'Next j
                'rs.Update
                MsgBox arr(i, 1) & " �Ѵ���δ����"
            End If
            rs.Close
            Set rs = Nothing
        Else
            MsgBox arr(i, 1) & "  ��λ����в���Ϊ��!!", vbInformation, "��ʾ"
            str = str + arr(i, 1) + ","
            
        End If
    Next i
    MsgBox "������ϡ�", vbInformation, "��ʾ"
    Sheets("���̱�ά��").Range("2:" & Rows.Count).Clear
    If str <> "" Then
        brr = VBA.Split(str, ",")
        Debug.Print UBound(brr)
        Sheets("���̱�ά��").Range("A2").Resize(UBound(brr), 1) = Application.WorksheetFunction.Transpose(brr)
    End If
        
    
    cnn.Close
    Set cnn = Nothing
    Call ��ѯ���̱�
    
End Sub

Sub ��ѯ���̱�()
	Dim cnn
	Dim rs
    Dim sh As Worksheet
    Dim bool_skksb, bool_ksbwh As Boolean
    bool_skksb = False
    bool_ksbwh = False
    For Each sh In Worksheets
        If sh.Name = "ʱ�տ��̱�" Then
            bool_skksb = True
        End If
        If sh.Name = "���̱�ά��" Then
            bool_ksbwh = True
        End If
    Next
    
    If bool_skksb = False Then
        Worksheets.Add
        ActiveSheet.Name = "ʱ�տ��̱�"
    End If
    If bool_ksbwh = False Then
        Worksheets.Add
        ActiveSheet.Name = "���̱�ά��"
        ActiveSheet.Range("A1") = "��λ����"
        ActiveSheet.Range("B1") = "��λ���"
    End If
    Dim arr
	Set cnn = CreateObject("adodb.connection")
    With cnn
        .Provider = "microsoft.ace.oledb.12.0"
        .Open ThisWorkbook.Path & "\ʱ�տ��̱�.accdb"
    End With
    
    Dim sql As String
    sql = "select * from ʱ�տ��̱� order by lrrq "
    'ִ��SQL����֮����ȡ�������ݻᱻ���ص��ڴ���
    'Set rs = New ADODB.Recordset
	Set rs = CreateObject("adodb.recordset")
    'rs = cnn.Execute(sql)       '����¼���浽rs��
    rs.Open sql, cnn, 1, 3
    Sheets("ʱ�տ��̱�").Rows.Clear
    '��ȡ�ֶ�����ʹ��ѭ��
    Dim i As Integer
    For i = 0 To rs.Fields.Count - 1
        Sheets("ʱ�տ��̱�").Cells(1, i + 1) = rs.Fields(i).Name
    Next
    arr = Application.Transpose(rs.GetRows(, 1, Array("dwmc", "dwbh", "lrrq"))) '��¼��������
    Sheets("ʱ�տ��̱�").Range("A2").Resize(UBound(arr), 3) = arr
    '����¼��rs�е����ݷ��ص�������
    'Sheets("ʱ�տ��̱�").Range("A2").CopyFromRecordset rs
    MsgBox "ʱ�տ��̱���ˢ��"
    '4���ͷŶ�������ռ�
    rs.Close: Set rs = Nothing
    cnn.Close: Set cnn = Nothing

End Sub

'
'Sub ����()
'     Dim cnn
'	 Dim rs
'	 Set cnn = CreateObject("adodb.connection")
'    'Set cnn = New ADODB.Connection
'    With cnn
'        .Provider = "microsoft.ace.oledb.12.0"
'        .Open ThisWorkbook.Path & "\ʱ�տ��̱�.accdb"
'    End With
'
'    Dim sql As String
'    sql = "update ʱ�տ��̱� set lrrq = '" & Application.Text(Now(), "yyyy-mm-dd hh:mm:ss") & "'"
'    'ִ��SQL����֮����ȡ�������ݻᱻ���ص��ڴ���
'    'Set rs = New ADODB.Recordset
'     Set rs = CreateObject("adodb.recordset")
'    'rs = cnn.Execute(sql)       '����¼���浽rs��
'    rs.Open sql, cnn, adOpenKeyset, adLockOptimistic
'    'rs.Close: Set rs = Nothing
'    cnn.Close: Set cnn = Nothing
'
'End Sub

Sub ���½����Ӧ��()
    Dim cnn
    Dim rs
    Dim mrows,sql
    '���ӽ����Ӧ�̱�
	mrows = Sheets("��Ӧ��").UsedRange.rows.Count
    If mrows <= 1 Then
        mrows = 2
    End If
    Sheets("��Ӧ��").Range("2:" & mrows).Clear
    '�������ݿ�����
    Set cnn = CreateObject("adodb.connection")
    
    cnn.ConnectionString = "DRIVER={ODBC Driver 18 for SQL Server};Encrypt=yes;TrustServerCertificate=yes;Server=192.168.0.42;Database=AIS20150122160957;Uid=sa;Pwd=123"
    cnn.Open
    'MsgBox "�ɹ�"
    sql = "select Fname,F_102,Fnumber from t_supplier"
    Set rs = CreateObject("adodb.recordset")
    rs.Open sql, cnn, 1, 3
    Sheets("��Ӧ��").Range("A2").CopyFromRecordset rs
    
    rs.Close
    Set rs = Nothing
    cnn.Close
    Set cnn = Nothing

    'ɾ���ո�
    Sheets("��Ӧ��").Activate
    Sheets("��Ӧ��").Columns("A:A").Select
    Selection.Replace What:=" ", Replacement:="", LookAt:=xlPart, _
        SearchOrder:=xlByRows, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    '��ʾ
    MsgBox "�Ѹ���"
End Sub

Sub ���½���ͻ�()
    Dim cnn
    Dim rs
    Dim mrows,sql
    '���ӽ���ͻ���
	mrows = Sheets("�ͻ�").UsedRange.rows.Count
    If mrows <= 1 Then
        mrows = 2
    End If
    Sheets("�ͻ�").Range("2:" & mrows).Clear
    '�������ݿ�����
    Set cnn = CreateObject("adodb.connection")
    
    cnn.ConnectionString = "DRIVER={ODBC Driver 18 for SQL Server};Encrypt=yes;TrustServerCertificate=yes;Server=192.168.0.42;Database=AIS20150122160957;Uid=sa;Pwd=123"
    cnn.Open
    'MsgBox "�ɹ�"
    sql = "select Fname,F_102,Fnumber from t_Organization"
    Set rs = CreateObject("adodb.recordset")
    rs.Open sql, cnn, 1, 3
    Sheets("�ͻ�").Range("A2").CopyFromRecordset rs
    
    rs.Close
    Set rs = Nothing
    cnn.Close
    Set cnn = Nothing
    
    'ɾ���ո�
    Sheets("�ͻ�").Activate
    Sheets("�ͻ�").Columns("A:A").Select
    Selection.Replace What:=" ", Replacement:="", LookAt:=xlPart, _
        SearchOrder:=xlByRows, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    
    MsgBox "�Ѹ���"
End Sub





