#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

X := 0
Y := 0
sX := 0
sY := 0

^!C::

MouseGetPos, X, Y
return

^!F::

MouseGetPos, sX, sY
return

^Numpad5::
	
	L00p:
	
	Loop {

		PixelSearch, Ab, Ba, X - 40, Y - 27, X - 20, Y + 23, 0x05dbf6, 10, Fast RGB
		if ErrorLevel
			sleep, 1
		else 
			goto, Pescar
		PixelSearch,  Cd, Dc, sX - 30, sY - 5, sX + 30, sY + 5, 0xbf0a0a, 0, Fast RGB
		if ErrorLevel
			sleep, 1
		else 
			goto, Emergency		
	}
	
	Emergency:
	
	Send {F5}
	Sleep, 600
	Send {F6}
	Sleep, 600
	Send {F7}
	Sleep, 600
	Send {F8}
	
	goto, L00p

	Pescar:

	Sleep, 400

	Send ^{z}

	Sleep, 2500
	
	Send ^{z}
	MouseMove, %X%, %Y%, 2
	sleep, 90
	Click, %X%, %Y% 
	
	goto, L00p

return



