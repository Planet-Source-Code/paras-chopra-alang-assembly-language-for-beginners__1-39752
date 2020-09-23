VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "ALang v1.0 - First release"
   ClientHeight    =   7515
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7650
   LinkTopic       =   "Form1"
   ScaleHeight     =   7515
   ScaleWidth      =   7650
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox t 
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   3015
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   2
      Top             =   4200
      Width           =   7335
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Execute"
      Height          =   375
      Left            =   2895
      TabIndex        =   1
      Top             =   3600
      Width           =   1935
   End
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3135
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   240
      Width           =   7335
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command1_Click()
    t.Locked = True
    t.Text = ""
    prog = Text1.Text
    main
End Sub

Private Sub Form_Load()
    inputs = ""
    prev = 0
End Sub

Private Sub t_KeyPress(KeyAscii As Integer)
    On Error GoTo ERRHANDLER
    If t.Locked = False Then
        If KeyAscii = vbKeyReturn Then
            inputs = Mid$(t.Text, prev + 1, Len(t.Text) - prev)
            t.Locked = True
            t.Text = t.Text & vbCrLf
        End If
    End If
    Exit Sub

ERRHANDLER:
    MsgBox "Unexpected error in procedure: t_KeyPress" & vbCrLf & _
    "Error #" & Err.Number & ": " & Err.Description, _
    vbCritical + vbOKOnly, App.Title
End Sub


