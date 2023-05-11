#Requires AutoHotkey v2.0
; This file can be edited even if the "composekey" script is running.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Define Abbreviations Below ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Read the following page for advanced guidance
; on how to write abbreviations:
; https://www.autohotkey.com/docs/v2/Hotstrings.htm

:*:btw::
{
	SendInput "By the way"
	Sleep 300 ; (optional) apt delay/string-size for applications that introduce an input delay (ex: notepad)
	CloseSequence
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    End of Abbreviations    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This script has values and functions catered to Windows 11.
;;; Open issues for suggestions related to other Windows versions.

ToolTipMode:=A_Args[1] ; the parent script, "composekey", decides whether or not we can detect a caret
;; a caret is the "cursor" that shows when inputting text

; if we can see the caret, then inform the user that the script is listening via a tooltip
if ToolTipMode {
	SetTimer WatchCaret, 100
	WatchCaret(){
    	if CaretGetPos(&x, &y) {
			ToolTip "[Esc] Stop Listening For Macro", x, y - 20 ; lifted from documentation, keeps tooltip on caret
    	} else {
			; if the user is no longer focused on a text input, stop listening
			ExitApp
		}
	}

; if we can't access the caret from the start, inform the user using notifications
} else {
	SetTimer NotificationWarning, 5750
	NotificationWarning
}

NotificationWarning()
{
	TrayTip
	TrayTip "Unsupported Application Detected.`nPress [ESC] or enter a pre-defined abbreviation to stop.`nMacro Mode will NOT stop otherwise.", "Macro Mode", "Icon! Mute"
}

; the "Escape" key stops us from listening to abbreviations
Esc::
{
	CloseSequence
}

CloseSequence() {
	Traytip
	ExitApp
}



