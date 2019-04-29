SendMode "Input"  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.
/*
~*XButton1::
SendInput("{Blind}{g down}")
sleep 50
SendInput "{Blind}{g up}"
sleep 50
SendInput("{Blind}{g down}")
sleep 50
SendInput "{Blind}{g up}"
return
*/
Joy14::
SendInput("{Blind}{Esc down}")
sleep 100
SendInput("{Blind}{Esc up}")
return

~Joy7::
SendInput("{Blind}{Xbutton1 down}{LButton down}")
KeyWait "Joy7"
SendInput("{Blind}{Xbutton1 up}{LButton up}")
return