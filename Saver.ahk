;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.
#include ThreadManager.ahk

global save_dir:=A_AppData "\Sekiro\76561198096954600\"
global original_save_name:="S0000.sl2"

~$f4::
Save()
return

~$f8::
Load()
return

Save()
{
global
Critical "On"
n:=1
while(FileExist(Format(save_dir "Autosave\" n ".sl2")))
{
n++
}
	FileCopy Format(save_dir original_save_name), Format(save_dir "Autosave\" n ".sl2")  , 0
SoundBeep(880,200)

Critical "Off"
return
}

Load()
{
global
Critical "On"
FileList := ""
Loop Files, save_dir "Autosave\*.sl2"
    FileList .= A_LoopFileTimeModified "`t" A_LoopFileName "`n"
FileList := Sort(FileList,"R")  ; Sort by date.
Loop Parse, FileList, "`n"
{
    if A_LoopField = "" ; Omit the last linefeed (blank item) at the end of the list.
        continue
    FileItem := StrSplit(A_LoopField, A_Tab)  ; Split into two parts at the tab char.
	if( FileExist( save_dir "Autosave\" FileItem[2]))
	{
	FileCopy save_dir "Autosave\" FileItem[2], save_dir original_save_name , 1
	SoundBeep(440.200)
SoundBeep(880,200)
Critical "Off"
return
	}
}
SoundBeep(880,200)
SoundBeep(440.200)
Critical "Off"
return
}

