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
			while p := RegExMatch(Matched, "[-\d\.vhVH]+[,\s][-\d\.]+", m, p + StrLen(m)) ; Extracts the point formated as x.dy,y.dy
			{
			
				RegExMatch(m,  "([-\d\.vhVH]+)[\s,]([-\d\.vhVH]+)",coords)
					
					
				
				x := floor((coords1 + offsetx)*scalex)
				y := floor((coords2 + offsety)*scaley)

				
				FileAppend, /dmarker addcorner %x% 64 %y% world `n, %A_ScriptDir%\output.txt
			
			}
		
			FileAppend, /dmarker addarea Area%A_Index% set:"%dataset%" `n`n, %A_ScriptDir%\output.txt
			
		}else{

		
		;alternative case if the char is "m", hence local coordinates should be used

        	p := 1, m := "", x_orig = 0, y_orig = ""
			while p := RegExMatch(Matched, "[-\d\.vhVH]+[,\s][-\d\.]+", m, p + StrLen(m)) ; Extracts the point formated as x.dy,y.dy
			{
				RegExMatch(m,  "([-\d\.vhVH]+)[\s,]([-\d\.vhVH]+)",coords)
				
				if			(RegExMatch(coords1,"v" = 1)){ ; relative vertical
				
					x := last_x
					y := floor((coords2 + offsety)*scaley + last_y)
				
				} else if 	(RegExMatch(coords1,"V" = 1)){ ; absolute vertical
					
					x := last_x
					y := floor((coords2 + offsety)*scaley)
				
				} else if 	(RegExMatch(coords1,"h" = 1)){ ; relative horizontal
					
					y := last_y
					x := floor((coords2 + offsetx)*scalex + last_x)
				
				} else if 	(RegExMatch(coords1,"H" = 1)){ ; absolute horizontal
				
					y := last_y
					x := floor((coords2 + offsetx)*scalex)
				
				} else{
				
					x := floor((coords1 + offsetx)*scalex + x_orig)
					y := floor((coords2 + offsety)*scaley + y_orig)
				
				}
				
				FileAppend, /dmarker addcorner %x% 64 %y% world `n, %A_ScriptDir%\output.txt
				
				if(!y_orig)
				{
					x_orig := x
					y_orig := y
				}
				
				last_x := x
				last_y := y
			}
		
			FileAppend, /dmarker addarea Area%A_Index% set:"%dataset%" `n`n, %A_ScriptDir%\output.txt

		}
	
	}
}    
