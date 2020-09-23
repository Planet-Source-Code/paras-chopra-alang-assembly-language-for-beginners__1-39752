Attribute VB_Name = "Module1"

Type processor
    Z As Boolean
    s As Boolean
    O As Boolean
    M As Boolean
    A As Long
    IP As Long
    DR As Integer
End Type
Global prog As String
Dim cpu As processor
Dim Mem(2 ^ 16) As Long
Global prev As Integer ' IDE dependent
Global inputs As String ' IDE dependent
Sub main()
    On Error GoTo ERRHANDLER
    
    Dim inst() As String
    Dim eop As Boolean
    cpu.IP = 0
    inst = GetTokens(prog, Chr(13))
    eop = False
    
    Do While eop = False
        If LCase(Remo(inst(cpu.IP))) = "eop" Then
            eop = True: GoTo ex
        End If
        execute (Remo(inst(cpu.IP)))
        cpu.IP = cpu.IP + 1
    Loop
ex:
    Exit Sub

ERRHANDLER:
    MsgBox "Unexpected error in procedure: main" & vbCrLf & _
    "Error #" & Err.Number & ": " & Err.Description, _
    vbCritical + vbOKOnly, App.Title
End Sub

Sub syst(intno As Integer)
    On Error GoTo ERRHANDLER
    Select Case intno
    Case 1:
        cpu.A = read()
    Case 2:
        output (CStr(cpu.A))
    End Select
    Exit Sub

ERRHANDLER:
    MsgBox "Unexpected error in procedure: syst" & vbCrLf & _
    "Error #" & Err.Number & ": " & Err.Description, _
    vbCritical + vbOKOnly, App.Title
End Sub

Sub execute(strr As String)
    On Error GoTo ERRHANDLER
    Dim tok() As String
    tok = GetTokens(strr, ",")
    code = Trim(LCase(tok(0)))
    If UBound(tok) > 0 Then
        dat = tok(1)
    End If
    Select Case code
    Case "nop": DoEvents
    Case "sys":
        syst (dat)
    Case "lod": cpu.A = dat
    Case "lodm": cpu.A = Mem(dat)
    Case "stor": Mem(dat) = cpu.A
    Case "add": cpu.A = cpu.A + dat
    Case "addm": cpu.A = cpu.A + Mem(dat)
    Case "sub": cpu.A = cpu.A - dat
    Case "subm": cpu.A = cpu.A - Mem(dat)
    Case "mul": cpu.A = cpu.A * dat
    Case "mulm": cpu.A = cpu.A * Mem(dat)
    Case "div": cpu.A = cpu.A / dat
    Case "divm": cpu.A = cpu.A / Mem(dat)
    Case "mod": cpu.A = cpu.A Mod dat
    Case "modm": cpu.A = cpu.A Mod Mem(dat)
    Case "and": cpu.A = CByte(cpu.A) And CByte(dat)
    Case "andm": cpu.A = CByte(cpu.A) And CByte(Mem(dat))
    Case "or": cpu.A = CByte(cpu.A) Or CByte(dat)
    Case "orm": cpu.A = CByte(cpu.A) Or CByte(Mem(dat))
    Case "cmp":
        Dim temp As Integer
        temp = cpu.A - dat
        If temp = 0 Then
            cpu.Z = True
        ElseIf temp > 0 Then
            cpu.Z = False
            cpu.s = True
        Else
            cpu.Z = False
            cpu.s = False
        End If
    Case "cmpm":
        Dim temp1 As Integer
        temp1 = cpu.A - Mem(dat)
        If temp1 = 0 Then
            cpu.Z = True
        ElseIf temp1 > 0 Then
            cpu.Z = False
            cpu.s = True
        Else
            cpu.Z = False
            cpu.s = False
        End If
    Case "jmp":
        cpu.IP = dat - 2
    Case "jz": If cpu.Z = True Then cpu.IP = dat - 2
    Case "jnz": If cpu.Z = False Then cpu.IP = dat - 2
    Case "ja": If (cpu.Z = False) And (cpu.s = False) Then cpu.IP = dat - 2
    Case "jb": If (cpu.Z = False) And (cpu.s = True) Then cpu.IP = dat - 2
    Case "pri": output (Chr(dat))
    Case "prim": output (Chr(Mem(dat)))
    Case "cha": cpu.A = Asc(dat)
    Case "prn": output (dat)
    Case "nw": output (vbCrLf)
    Case "rem": DoEvents
    Case "str": storestr CStr(dat), cpu.A
    Case "pstr": prntstr (CLng(dat))
    End Select
    Exit Sub

ERRHANDLER:
    MsgBox "Unexpected error in procedure: execute" & vbCrLf & _
    "Error #" & Err.Number & ": " & Err.Description, _
    vbCritical + vbOKOnly, App.Title
End Sub


Function Remo(ByRef strr As String) As String
    On Error GoTo ERRHANDLER
    If Mid(strr, 1, 1) = vbLf Then
        Remo = Mid(strr, 2, Len(strr))
    Else
        Remo = strr
    End If
    Exit Function

ERRHANDLER:
    MsgBox "Unexpected error in procedure: Remo" & vbCrLf & _
    "Error #" & Err.Number & ": " & Err.Description, _
    vbCritical + vbOKOnly, App.Title
End Function

Public Sub output(strr As String)
    On Error GoTo ERRHANDLER
    Form1.t.Text = Form1.t.Text & strr
    prev = Len(Form1.t.Text)
    Exit Sub

ERRHANDLER:
    MsgBox "Unexpected error in procedure: output" & vbCrLf & _
    "Error #" & Err.Number & ": " & Err.Description, _
    vbCritical + vbOKOnly, App.Title
End Sub

Public Function read() As Integer
    On Error GoTo ERRHANDLER
    Form1.t.Locked = False
    Form1.t.SelStart = Len(Form1.t.Text)
    Form1.t.SelLength = 1
    Form1.t.SetFocus
    Do While inputs = ""
        DoEvents
    Loop
    read = inputs
    inputs = ""
    Exit Function

ERRHANDLER:
    MsgBox "Unexpected error in procedure: read" & vbCrLf & _
    "Error #" & Err.Number & ": " & Err.Description, _
    vbCritical + vbOKOnly, App.Title
End Function
Sub storestr(strr As String, memval As Long)
    On Error GoTo ERRHANDLER
    memval = memval - 1
    For i = 1 To Len(strr)
        Mem(memval + i) = Asc(Mid(strr, i, 1))
    Next i
    Mem(memval + i) = Asc(vbNullChar)
    Exit Sub

ERRHANDLER:
    MsgBox "Unexpected error in procedure: storestr" & vbCrLf & _
    "Error #" & Err.Number & ": " & Err.Description, _
    vbCritical + vbOKOnly, App.Title
End Sub

Sub prntstr(memval As Long)
    On Error GoTo ERRHANDLER
    Dim char As String
    Do
        char = Chr(Mem(memval))
        If char <> vbNullChar Then output (char)
        memval = memval + 1
    Loop Until char = vbNullChar
    Exit Sub

ERRHANDLER:
    MsgBox "Unexpected error in procedure: prntstr" & vbCrLf & _
    "Error #" & Err.Number & ": " & Err.Description, _
    vbCritical + vbOKOnly, App.Title
End Sub
