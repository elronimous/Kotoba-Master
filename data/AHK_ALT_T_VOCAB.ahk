#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

global SaveFile := ""

FileEncoding, UTF-8

!t::
{
    global SaveFile

    if (SaveFile = "")
    {
        DefaultName := A_YYYY . A_MM . A_DD . "_" . A_Hour . A_Min . ".txt"

        Gui, New, +AlwaysOnTop, Text File Setup

        Gui, Add, Text,, Filename
        Gui, Add, Edit, vFileName w400, %DefaultName%

        Gui, Add, Text, y+10, Web Address
        Gui, Add, Edit, vWebAddress w400

        Gui, Add, Text, y+10, Title
        Gui, Add, Edit, vTitleText w400

        Gui, Add, Button, gCreateFile xm y+15 w100, OK
        Gui, Add, Button, gResumeFile x+10 w100, Resume
        Gui, Add, Button, gCancelSetup x+10 w100, Cancel

        Gui, Show
        return
    }

    ; hotkey action
    Send, c
    Sleep, 50

    Send, e
    Sleep, 50

    ClipWait, 2

    ; clipboard entry + blank line AFTER it
    FileAppend, %Clipboard%`r`n`r`n, %SaveFile%, UTF-8
}
return


CreateFile:
Gui, Submit

FileSelectFile, ChosenPath, S16, %FileName%, Save Text File, Text Documents (*.txt)

if (ChosenPath = "")
    return

SaveFile := ChosenPath

; initial metadata lines (no extra spacing changes here)
FileAppend, %WebAddress%`r`n, %SaveFile%, UTF-8
FileAppend, %TitleText%`r`n, %SaveFile%, UTF-8

Gui, Destroy

MsgBox, 64, Ready, File created and ready:`n`n%SaveFile%
return


ResumeFile:
FileSelectFile, ChosenPath, 3,, Select Existing Text File, Text Documents (*.txt)

if (ChosenPath = "")
    return

SaveFile := ChosenPath

Gui, Destroy

MsgBox, 64, Resume Mode, Now appending clipboard data to:`n`n%SaveFile%
return


CancelSetup:
GuiClose:
GuiEscape:
Gui, Destroy
return