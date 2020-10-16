#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#include %A_ScriptDir%\config.txt

sleep 5000
Loop, read, %A_ScriptDir%\data.txt
{
	if RegExMatch(A_LoopReadLine, "d=""[^""]+,[^""]+""",Matched)   ;REGEX => d=""[^""]+,[^""]+""    Detects the polygon 
	{
        ;msgbox, % Matched  ;%A_LoopReadLine%
		
		p := 1, m := ""
		while p := RegExMatch(Matched, "[-\d\.]+,[-\d\.]+", m, p + StrLen(m)) ; Extracts the point formated as x.dy,y.dy
		{
			;MsgBox , %m%

			coords := StrSplit(m, ",")
			
			x := floor((coords[1] + offsetx)*scalex)
			y := floor((coords[2] + offsety)*scaley)
			;MsgBox, %x%
			;MsgBox, %y%
			FileAppend, \foobar hej %x% 64 %y%.`n, %A_ScriptDir%\output.txt
			
		}
		FileAppend, `n, %A_ScriptDir%\output.txt
	}
}    