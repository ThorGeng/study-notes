'某一列的最大行数:
Sheet1.Range("A1").CurrentRegion.rows.count

'某一列最后一行空白单元格：
Sheet1.Range("A65536").End(xlUp).Offset(1, 0)


'用ADO连接Excel:



'文本框设置格式：
AmountText = Format(AmountText, "#,##0.00")

'控件得到焦点:
Text.SetFocus


'VBA使用Excel函数：
Application.WorksheetFunction.Match(IDText.Text, Range("D:D"), 0)


'遍历excel每一行:
While Len(Sheet1.Cells(row, 5)) <> 0 '判断第row行第5列是否为空，
		'对每一行数据进行操作
        row = row + 1   
Wend