Attribute VB_Name = "Module1"
Sub multiYearStocks():
'Headers for multiple worksheets

For Each ws In Worksheets
    ws.Range("I1").Value = "Ticker"
    ws.Range("P1").Value = "Ticker"
    ws.Range("J1").Value = "Yearly Change"
    ws.Range("K1").Value = "Percent Change"
    ws.Range("L1").Value = "Total Stock Volume"
    ws.Range("Q1").Value = "Value"
    ws.Range("O2").Value = "Greatest % Increase"
    ws.Range("O3").Value = "Greatest % Decrease"
    ws.Range("O4").Value = "Greatest Total Volume"
    
    
'Dimensionng of variables
'variable i
Dim i As Long
'variable tickerName
Dim tickerName As String
'Variable OpenYearly
Dim openYearly As Double
'variable totalvolume
Dim totalVolume As Double
totalVolume = 0
'variable totalyearly
Dim totalYearly As Double
totalYearly = 0
'variable percentChange
Dim percentChange As Double
Dim tickerRow As Long
tickerRow = 2
'determine lastrow
Dim lastRow As Long
lastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row

'Create a for loop
For i = 2 To lastRow
openYearly = ws.Cells(tickerRow, 3).Value

    If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
        tickerName = ws.Cells(i, 1).Value
        ws.Range("I" & tickerRow).Value = tickerName
    
        totalYearly = totalYearly + (ws.Cells(i, 6).Value - openYearly)
        ws.Range("J" & tickerRow).Value = totalYearly
    
        percentChange = (totalYearly / openYearly)
        ws.Range("K" & tickerRow).Value = percentChange
        ws.Range("K" & tickerRow).Style = "Percent"
        
        totalVolume = totalVolume + ws.Cells(i, 7).Value
        ws.Range("L" & tickerRow).Value = totalVolume
        
        'Reset
        tickerRow = tickerRow + 1
        totalYearly = 0
        totalVolume = 0
        openYearly = ws.Cells(tickerRow, 3).Value
    Else
        totalVolume = totalVolume + ws.Cells(i, 7).Value
    End If
Next i

'interior cell formatting
Dim yearLastRow As Long
yearLastRow = ws.Cells(Rows.Count, 10).End(xlUp).Row

'Add Loop for cell formatting
For i = 2 To yearLastRow

'Add Conditional for cell formatting
    If ws.Cells(i, 10).Value >= 0 Then
        ws.Cells(i, 10).Interior.ColorIndex = 4
    Else
        ws.Cells(i, 10).Interior.ColorIndex = 3
    End If
Next i
    
'dimension variables for finding max & min
Dim percentLastRow As Long
percentLastRow = ws.Cells(Rows.Count, 11).End(xlUp).Row
Dim percent_max As Double
percent_max = 0
Dim percent_min As Double
percent_min = 0

'Add Loop for finding max & min
For i = 2 To percentLastRow

'Add Conditional for max & min
    If percent_max < ws.Cells(i, 11).Value Then
        percent_max = ws.Cells(i, 11).Value
        ws.Range("Q2").Value = percent_max
        ws.Range("Q2").Style = "Percent"
        ws.Range("P2").Value = ws.Cells(i, 9).Value
    ElseIf percent_min > ws.Cells(i, 11).Value Then
        percent_min = ws.Cells(i, 11).Value
        ws.Cells(3, 17).Value = percent_min
        ws.Cells(3, 17).Style = "Percent"
        ws.Cells(3, 16).Value = ws.Cells(i, 9).Value
    End If
Next i

'Dimension variable for greatest total volume
Dim totalVolumeRow As Long
totalVolumeRow = ws.Cells(Rows.Count, 12).End(xlUp).Row
Dim totalVolumeMax As Double
totalVolumeMax = 0

'Add Loop for finding greatest total volume
For i = 2 To totalVolumeRow

'Add Conditional for greatest total volume
    If totalVolumeMax < ws.Cells(i, 12).Value Then
        totalVolumeMax = ws.Cells(i, 12).Value
        ws.Cells(4, 17).Value = totalVolumeMax
        ws.Cells(4, 16).Value = ws.Cells(i, 9).Value
    End If
Next i
    
Next ws

End Sub
