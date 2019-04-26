;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.
;#include ThreadManager.ahk

global save_dir:=A_AppData "\Sekiro\76561198096954600\"
global max_auto_save:=20
global original_save_name:="S0000.sl2"
global auto_save_interval:=1000*60*2

DirCreate Format(save_dir "\Autosave")

/*
#Persistent
SetTimer("AutoSave",auto_save_interval)
return
*/

~$f4::
Save()
return

~f8::
Load()
return

~f9::
AutoLoad()
return

~f5::
AutoSave()
return


Save()
{
Critical "On"
n:=1
while(FileExist(Format(save_dir "Autosave\n" n ".sl2")))
{
n++
}
	FileCopy Format(save_dir original_save_name), Format(save_dir "Autosave\n" n ".sl2")  , 0
SoundBeep(880,200)

Critical "Off"
return
}

AutoSave()
{
Critical "On"
n:=1
while(FileExist(Format(save_dir "Autosave\a" n ".sl2")))
{
n++
}
if(n<=max_auto_save)
	FileCopy Format(save_dir original_save_name), Format(save_dir "Autosave\a" n ".sl2")  , 0
else
{
FileList := ""
Loop Files, save_dir "Autosave\a*.sl2"
    FileList .= A_LoopFileTimeModified "`t" A_LoopFileName "`n"
FileList := Sort(FileList,"R")  ; Sort by date.
Loop Parse, FileList, "`n"
{
    if A_LoopField = "" ; Omit the last linefeed (blank item) at the end of the list.
        continue
    FileItem := StrSplit(A_LoopField, A_Tab)  ; Split into two parts at the tab char.
	if( FileExist( save_dir "Autosave\" FileItem[2]))
	{
	foundPos := InStr(FileItem[2],".sl2")
	auto_index:=SubStr(FileItem[2],2,foundPos-2)+1
	if(auto_index>max_auto_save)
	auto_index:=1
	FileCopy  save_dir original_save_name, save_dir "Autosave\a" auto_index ".sl2", 1
SoundBeep(880,200)
SoundBeep(880,200)
Critical "Off"
return
	}
}


}
SoundBeep(880,200)
SoundBeep(880,200)
Critical "Off"
return
}

Load()
{
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

AutoLoad()
{
Critical "On"
FileList := ""
Loop Files, save_dir "Autosave\a*.sl2"
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

