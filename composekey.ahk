#Requires AutoHotkey v2.0
#Include <GetCaret>

AppsKey:: ; AppsKey is the "Menu" key on the keyboard
{
	if GetCaret()
		Run "compose.ahk 1"
	else
		Run "compose.ahk 0"
}