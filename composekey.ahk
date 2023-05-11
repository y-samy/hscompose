#Requires AutoHotkey v2.0

AppsKey:: ; AppsKey is the "Menu" key on the keyboard
{
	if CaretGetPos()
		Run "compose.ahk 1"
	else
		Run "compose.ahk 0"
}