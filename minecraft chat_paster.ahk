#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#include %A_ScriptDir%\config.txt

sleep 5000
Loop, read, %A_ScriptDir%\output.txt
{
	if %A_ScriptDir%
	{
		send %MinecraftChatKey%
		sleep 100
		send %A_LoopReadLine%
		sleep 100
		send {Enter}
		sleep 50
	}

}
