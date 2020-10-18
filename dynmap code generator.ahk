#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#include %A_ScriptDir%\config.txt

FileSelectFile, File

Loop, read, %File%
{
	if RegExMatch(A_LoopReadLine, "d=""[^""]+,[^""]+""",Matched)   ;REGEX => d=""[^""]+,[^""]+""    Detects the polygon 
	{
        ;msgbox, % Matched  ;%A_LoopReadLine%
		
		if (SubStr(m,4,1) = "M")
		{

			p := 1, m := ""
			while p := RegExMatch(Matched, "[-\d\.]+,[-\d\.]+", m, p + StrLen(m)) ; Extracts the point formated as x.dy,y.dy
			{
				;MsgBox , %m%

				coords := StrSplit(m, ",")
			
				x := floor((coords[1] + offsetx)*scalex)
				y := floor((coords[2] + offsety)*scaley)
				;MsgBox, %x%
				;MsgBox, %y%
				FileAppend, /dmarker addcorner %x% 64 %y% world `n, %A_ScriptDir%\output.txt
			
			}
		
			FileAppend, /dmarker addarea Area%A_Index% set:"%dataset%" `n`n, %A_ScriptDir%\output.txt
		}else{

		MsgBox %substr(m,4,1)%
		;alternative case if the char is "m", hence local coordinates should be used

        		p := 1, m := "", x_orig = 0, y_orig = 0
			while p := RegExMatch(Matched, "[-\d\.]+,[-\d\.]+", m, p + StrLen(m)) ; Extracts the point formated as x.dy,y.dy
			{
				;MsgBox , %m%

				coords := StrSplit(m, ",")
			
				x := floor((coords[1] + offsetx)*scalex + x_orig)
				y := floor((coords[2] + offsety)*scaley + y_orig)
				;MsgBox, %x%
				;MsgBox, %y%
				FileAppend, /dmarker addcorner %x% 64 %y% world `n, %A_ScriptDir%\output.txt
				
				if(x = 0)
				{
					x_orig := x
					y_orig := y
				}
			}
		
			FileAppend, /dmarker addarea Area%A_Index% set:"%dataset%" `n`n, %A_ScriptDir%\output.txt

		}
	
	}
}    
