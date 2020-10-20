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
        
		
		if (RegExMatch(Matched,"M") = 4)
		{
			

			p := 1, m := ""
			while p := RegExMatch(Matched, "[-\d\.vhVH]+[,\s][-\d\.vhVH]+", m, p + StrLen(m)) ; Extracts the point formated as x.dy,y.dy
			{
				
				coords := StrSplit(m, ",")
				
					x := floor((coords[1] + offsetx)*scalex)
					y := floor((coords[2] + offsety)*scaley)

				;MsgBox, %x%
				;MsgBox, %y%
				FileAppend, /dmarker addcorner %x% 64 %y% world `n, %A_ScriptDir%\output.txt
			
			}
		
			FileAppend, /dmarker addarea Area%A_Index% set:"%dataset%" `n`n, %A_ScriptDir%\output.txt
		}else{

		
		;alternative case if the char is "m", hence local coordinates should be used

        	p := 1, m := "", x_orig = 0, y_orig = ""
			while p := RegExMatch(Matched, "[-\d\.vhVH]+[,\s][-\d\.vhVH]+", m, p + StrLen(m)) ; Extracts the point formated as x.dy,y.dy
			{
				coords := StrSplit(m, ",")
				
				x := floor((coords[1] + offsetx)*scalex + x_orig)
				y := floor((coords[2] + offsety)*scaley + y_orig)
				;MsgBox, % coords[2]
				;MsgBox, % coords[1]
				
				;MsgBox, % x
				
				FileAppend, /dmarker addcorner %x% 64 %y% world `n, %A_ScriptDir%\output.txt
				
				if(!y_orig)
				{
					x_orig := x
					y_orig := y
					FileAppend, Setting the origin , %A_ScriptDir%\output.txt
					MsgBox, setting the y_orig
				}
			}
		
			FileAppend, /dmarker addarea Area%A_Index% set:"%dataset%" `n`n, %A_ScriptDir%\output.txt

		}
	
	}
}    
