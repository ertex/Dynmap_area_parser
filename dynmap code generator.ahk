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
			

			p := 1, m := "", last_x := 0, last_y := 0
			while p := RegExMatch(Matched, "[-\d\.vhVH]+[,\s][-\d\.]+", m, p + StrLen(m)) ; Extracts the point formated as x.dy,y.dy
			{
			
				RegExMatch(m,  "([-\d\.vhVH]+)[\s,]([-\d\.vhVH]+)",coords)
					
				if			(RegExMatch(coords1,"V") = 1){ ; vertical	
					
					x := last_x
					y := floor((coords2 + offsety)*scaley)
					
				} else if 	(RegExMatch(coords1,"H") = 1){ ; absolute horizontal

					
					y := last_y
					x := floor((coords2 + offsetx)*scalex)
					
				} else {
				
				x := floor((coords1 + offsetx)*scalex)
				y := floor((coords2 + offsety)*scaley)
				
				}
				
				FileAppend, /dmarker addcorner %x% 64 %y% world `n, %A_ScriptDir%\output.txt
			
				last_x := x
				last_y := y
			
			}
		
			
			
		}else{
		
		;alternative case if the char is "m", hence local coordinates should be used

		}
	
	}
	
	if(RegExMatch(A_LoopReadLine,"(id="")([a-zA-Z\d_-]+)(""\s\/>)",Match)){
		FileAppend, /dmarker addarea %Match2% set:"%dataset%" color:ffffff fillcolor:000000 `n`n, %A_ScriptDir%\output.txt
	}
}    
