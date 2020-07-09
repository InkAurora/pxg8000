#NoEnv  
#SingleInstance, force
; #Warn  
SendMode Input 
SetWorkingDir %A_ScriptDir% 

Gui, Color, 0x272827
Gui, Font, s8, courier
Gui, Add, Button, x10 y10 w90 h20 gConfigure, Configure
Gui, Show, x650 y0 w300 h200, `t
return

^!c::

configure:

Tooltip, Adjusting Screen..., 100, 100

HuntMode := 0

CoordMode, Pixel, Relative

AdjustScreenScale:

ImageSearch, tradecenterX, tradecenterY, 0, 0, A_ScreenWidth, A_ScreenHeight, ./images/tradeCenter1.png
if ErrorLevel = 1
	goto, AdjustScreenScale
	
Sleep, 1000

MouseGetPos, X, Y
MouseMove, tradecenterX, tradecenterY
sleep, 100
Click, down
sleep, 40
MouseMove, 420, 735
sleep, 40
Click, up
MouseMove, X, Y

Tooltip, Acquiring key coordinates..., 100, 100

FindBattleMenu:

ImageSearch, battlemenuX, battlemenuY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 ./images/battlemenu.png
if ErrorLevel = 1
	goto, FindBattleMenu

battlemenuX -= 5

FindMiniMap:
	
ImageSearch, minimapX, minimapY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 ./images/minimap.png
if ErrorLevel = 1
	goto, FindMiniMap	

Tooltip, Adjusting Skills Bar..., 100, 100

FindCD:

ImageSearch, cdmenuX, cdmenuY, 0, 0, A_ScreenWidth, A_ScreenHeight, *50 ./images/cdmenu.png
if (ErrorLevel = 1) {
		goto, FindCD
} else {
	FindTyph:
	ImageSearch typhX, typhY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 ./images/typh.png
	if (ErrorLevel = 0) {
		MouseMove, typhX + 16, typhY + 16
		sleep, 40
		Click, right
		sleep, 600
		MouseMove typhX + 16, typhY + 16
		sleep, 40
		Send {XButton2}

		FindMax:
		ImageSearch, maxX, maxY, 0, 0, A_ScreenWidth, A_ScreenHeight, *Trans0x0000FF ./images/max.png
		If ErrorLevel = 1
			goto, FindMax
		sleep, 300
		MouseMove, typhX + 16, typhY + 16
		sleep, 40
		Click, right
		sleep, 100
	} else
		goto, FindTyph
}

Tooltip

sleep, 600

MouseMove, cdmenuX - 3, cdmenuY - 3
sleep, 40
Click, down
sleep, 40
MouseMove, 1369, 71
sleep, 40
Click, up
MouseMove, X, Y

FindCD1:

ImageSearch, cdmenuX, cdmenuY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 ./images/cdmenu.png
if ErrorLevel = 1
	goto, FindCD1

cdmenuX -= 8
cdmenuY -= 8

Tooltip, Fetching X and Y, 100, 100

RevX := 0 
RevY := 0

CoordMode, Pixel, Relative

Tooltip, Configuring Revive..., 100, 100

RevStart:

ImageSearch, pokemenuX, pokemenuY, 0, 0, A_ScreenWidth, A_ScreenHeight, ./images/pokemonmenu.png
if (ErrorLevel = 0) {
	RevX := pokemenuX
	RevY := pokemenuY
	RevX += 20
	RevY += 75
}

If RevX <> 0
	goto, RevEnd
else if RevX = 0
	goto, RevStart

RevEnd:

Sleep, 200

TC:
ImageSearch, tradecenterX, tradecenterY, 0, 0, A_ScreenWidth, A_ScreenHeight, ./images/tradeCenter1.png
if ErrorLevel = 1
	goto, TC
	
IniWrite, %maxX%, max.ini, vars, maxX
IniWrite, %maxY%, max.ini, vars, maxY
	
Run, Anti-Morte.ahk

Tooltip

return

Home::
if (HuntMode = 0) {
	
	HuntMode := 1
	Tooltip, HuntMode ON, 90, 96
	
} else if (HuntMode = 1) {

	HuntMode := 0
	Tooltip

}

return

^End::Pause

^Esc::
Sleep, 1000
Send ^!{Esc}
Reload
return

MButton::
If (HuntMode = 1) {
	
	MouseGetPos, LootX, LootY
	Send ^{7}
	Click
	
} else if (HuntMode = 0) {
	Send ^{7}
	Click
	
}
	
return

Pause::

MouseGetPos, X, Y
MouseMove, battlemenuX + 20, battlemenuY + 40
sleep, 40
Send {XButton1}
MouseMove, %X%, %Y%
Offensive:
Send ^{9}
ImageSearch, Rs, Sr, pokemenuX, pokemenuY, pokemenuX + 190, pokemenuY + 100, *10 ./images/Offensive.png
if ErrorLevel = 1
	goto, Offensive
CD6:
Send {F6}
ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *10 ./images/CD6.png
if ErrorLevel = 0
	goto, CD6
Send ^{8}
CD7: 
Send {F7}
ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *10 ./images/CD7.png
if ErrorLevel = 0
	goto, CD7
CD5:
Send {F5}
ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *10 ./images/CD5.png
if ErrorLevel = 0
	goto, CD5
CD9:
Send {F9}
ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *10 ./images/CD9.png
if ErrorLevel = 0
	goto, CD9
CD8:
Send {F8}
ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *10 ./images/CD8.png
if ErrorLevel = 0
	goto, CD8

Loop1:

done := 0

MeganiumFound1 := 1
MeganiumFound2 := 0

CoordMode, Pixel, Relative
ImageSearch, Fg, Gf, battlemenuX, battlemenuY, battlemenuX + 180, battlemenuY + 260, *20 ./images/ancientmeganium.png
If ErrorLevel = 1
	MeganiumFound1 = 0
	
if (MeganiumFound1 = 0) {
	
	if (HuntMode = 1) {
	
		MouseGetPos, X, Y
		MouseMove, %RevX%, %RevY%
		sleep, 40
		Click, right, %RevX%, %RevY% 

		Rev1:

		MouseMove, %RevX%, %RevY%
		Send {XButton2}
		ImageSearch, Rs, Sr, maxX - 16, maxY - 3, maxX + 40, maxY + 11, *Trans0x0000FF ./images/max.png
		if ErrorLevel = 1 
			goto,  Rev1

		RevStop := 0

		Loop {

			if RevStop = 7
				goto, Ok1
			ImageSearch, Rs, Sr, battlemenuX + 17, battlemenuY + 24, battlemenuX + 100, battlemenuY + 50, *15 ./images/revOut.png
			if (ErrorLevel = 1) {
			
				MouseMove, %RevX%, %RevY%
				sleep, 40
				Click, right, %RevX%, %RevY% 
			
			}
			else
				goto, Ok1
			RevStop++
		}

		Ok1:
		
		Send ^{0}
		
		MouseMove, %LootX%, %LootY%, 2
		Sleep, 40
		Click, %LootX%, %LootY%
	
		Sleep, 3000
	
		MouseMove,740, 330, 2
		Sleep, 40
		Click, right, 740, 330
	
		MouseMove,800, 330, 2
		Sleep, 40
		Click, right, 800, 330

		MouseMove,860, 330, 2
		Sleep, 40
		Click, right, 860, 330

		MouseMove,740, 390, 2
		Sleep, 40
		Click, right, 740, 390

		MouseMove,860, 390, 2
		Sleep, 40
		Click, right, 860, 390

		MouseMove,740, 450, 2
		Sleep, 40
		Click, right, 740, 450

		MouseMove,800, 450, 2
		Sleep, 40
		Click, right, 800, 450

		MouseMove,860, 450, 2
		Sleep, 40
		Click, right, 860, 450
		
		MouseMove, %X%, %Y%
	
	}
	else if HuntMode = 0
		return

} else if HuntMode = 0
	return	
else
	goto, Loop1	
	
return

Numpad3::

MouseMove, %RevX%, %RevY%
sleep, 60
Click, right, %RevX%, %RevY% 

return

Numpad5::

		MouseMove,740, 330, 2
		Sleep, 40
		Click, right, 740, 330
	
		MouseMove,800, 330, 2
		Sleep, 40
		Click, right, 800, 330

		MouseMove,860, 330, 2
		Sleep, 40
		Click, right, 860, 330

		MouseMove,740, 390, 2
		Sleep, 40
		Click, right, 740, 390

		MouseMove,860, 390, 2
		Sleep, 40
		Click, right, 860, 390

		MouseMove,740, 450, 2
		Sleep, 40
		Click, right, 740, 450

		MouseMove,800, 450, 2
		Sleep, 40
		Click, right, 800, 450

		MouseMove,860, 450, 2
		Sleep, 40
		Click, right, 860, 450

return

Numpad6::

MouseGetPos, X, Y
MouseMove, %RevX%, %RevY%
sleep, 40
Click, right, %RevX%, %RevY% 

Rev2:

MouseMove, %RevX%, %RevY%
Send {XButton2}
sleep, 20
ImageSearch, Rs, Sr, maxX - 16, maxY - 3, maxX + 40, maxY + 11, *Trans0x0000FF ./images/max.png
if ErrorLevel = 1 
	goto,  Rev2

RevStop := 0

Loop {

	if RevStop = 7
		goto, Ok2
	ImageSearch, Rs, Sr, battlemenuX + 17, battlemenuY + 24, battlemenuX + 100, battlemenuY + 50, *15 ./images/revOut.png
	if (ErrorLevel = 1) {
	
		MouseMove, %RevX%, %RevY%
		sleep, 40
		Click, right, %RevX%, %RevY% 
	
	}
	else
		goto, Ok2
	RevStop++
	sleep, 50
}

Ok2:

Send ^{0}
MouseMove, %X%, %Y%

return

^Numpad9::

Sleep, 1600

CoordMode, Pixel, Relative

HuntMode := 1	

AdjustMap:

Send ^{Tab}

sleep, 200

ImageSearch, mapCenterX, mapCenterY, 0, 0, A_ScreenWidth, A_ScreenHeight, ./images/mapcenter.png
if (ErrorLevel = 0) {
	MouseMove, %mapCenterX%, %mapCenterY%
	sleep, 40
	Click
	sleep, 50
	Send {WheelUp}
	sleep, 50
	Send {WheelUp}
	sleep, 50
	Send {WheelUp}
} else 
	goto, AdjustMap
	
Send ^{Tab}

Sleep, 400

ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure1f.png
if ErrorLevel = 0
	NextLure := 2
ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure2f.png
if ErrorLevel = 0
	NextLure := 3
ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure3f.png
if ErrorLevel = 0
	NextLure := 4
ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure4f.png
if ErrorLevel = 0
	NextLure := 5
ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure5f.png
if ErrorLevel = 0
	NextLure := 6
ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure6f.png
if ErrorLevel = 0
	NextLure := 7
ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure7f.png
if ErrorLevel = 0
	NextLure := 1

If NextLure = 1
	goto, Lure1
else if NextLure = 2
	goto, Lure2
else if NextLure = 3
	goto, Lure3
else if NextLure = 4
	goto, Lure4
else if NextLure = 5
	goto, Lure5
else if NextLure = 6
	goto, Lure6
else if NextLure = 7
	goto, Lure7

Lure1:

Tooltip, Searching Next Lure, 50, 50
Send ^{Tab}
Loop {
Sleep, 200
ImageSearch, NextLureX, NextLureY, 0, 0, A_ScreenWidth, A_ScreenHeight, ./images/Lure1.png
if ErrorLevel = 0
	goto, Lure1a
}
Lure1a:
;NextLureX += 10
;NextLureY += 10
MouseMove, %NextLureX%, %NextLureY%, 2
sleep, 400
Click, %NextLureX%, %NextLureY%
sleep, 150
Send ^{Tab}
	Tooltip
	Tooltip, Waiting for battle, 50, 50
	Loop {
		done1 := 0
		ImageSearch, Fg, Gf, battlemenuX, battlemenuY, battlemenuX + 180, battlemenuY + 260, *20 ./images/ancientmeganium.png
		if ErrorLevel = 0
			done1++	
		else {
		ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure1f.png
		if (ErrorLevel = 0) {
			goto, Lure2
		}
		}
		if (done1 >= 1) {
			sleep, 5000
			Send {F10}
			goto, Lure1b
		}	
	}
Lure1b:
Tooltip
Tooltip, Waiting Position, 50, 50
Loop {
ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure1f.png
if ErrorLevel = 0
	goto, Lure1c
}
Lure1c:
Tooltip
MouseMove, 790, 270
sleep, 1500
MouseGetPos, LootX, LootY	
Send ^{7}
Click
sleep, 1000
Send ^{7}
Click
sleep, 2600
NextLure := 2
goto, Begin

Lure2:

Tooltip, Searching Next Lure, 50, 50
Send ^{Tab}
Loop {
Sleep, 200
ImageSearch, NextLureX, NextLureY, 0, 0, A_ScreenWidth, A_ScreenHeight, ./images/Lure2.png
if ErrorLevel = 0
	goto, Lure2a
}
Lure2a:
;NextLureX += 10
;NextLureY += 10
MouseMove, %NextLureX%, %NextLureY%, 2
sleep, 400
Click, %NextLureX%, %NextLureY%
sleep, 150
Send ^{Tab}
	Tooltip
	Tooltip, Waiting for battle, 50, 50
	Loop {
		done1 := 0
		ImageSearch, Fg, Gf, battlemenuX, battlemenuY, battlemenuX + 180, battlemenuY + 260, *20 ./images/ancientmeganium.png
		If ErrorLevel = 0
			done1++	
		else {
		ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure2f.png
		if (ErrorLevel = 0) {
			goto, Lure3
		}
		}
		if (done1 >= 1) {
			sleep, 7000
			Send {F10}
			goto, Lure2b
		}	
	}
Lure2b:
Tooltip
Tooltip, Waiting Position, 50, 50
Loop {
ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure2f.png
if ErrorLevel = 0
	goto, Lure2c
}
Lure2c:
Tooltip
MouseMove, 690, 390
sleep, 1350
MouseGetPos, LootX, LootY	
Send ^{7}
Click
sleep, 4800
NextLure := 3
goto, Begin

Lure3:

Tooltip, Searching Next Lure, 50, 50
Send ^{Tab}
Loop {
Sleep, 200
ImageSearch, NextLureX, NextLureY, 0, 0, A_ScreenWidth, A_ScreenHeight, ./images/Lure3.png
if ErrorLevel = 0
	goto, Lure3a
}
Lure3a:
;NextLureX += 10
;NextLureY += 10
MouseMove, %NextLureX%, %NextLureY%, 2
sleep, 400
Click, %NextLureX%, %NextLureY%
sleep, 150
Send ^{Tab}
	Tooltip
	Tooltip, Waiting for battle, 50, 50
	Loop {
		done1 := 0
		ImageSearch, Fg, Gf, battlemenuX, battlemenuY, battlemenuX + 180, battlemenuY + 260, *20 ./images/ancientmeganium.png
		If ErrorLevel = 0
			done1++	
		else {
		ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure3f.png
		if (ErrorLevel = 0) {
			goto, Lure4
		}
		}
		if (done1 >= 1) {
			sleep, 1500
			Send {F10}
			goto, Lure3b
		}	
	}
Lure3b:
Tooltip
Tooltip, Waiting Position, 50, 50
Loop {
ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure3f.png
if ErrorLevel = 0
	goto, Lure3c
}
Lure3c:
Tooltip
MouseMove, 790, 520
sleep, 1500
MouseGetPos, LootX, LootY	
Send ^{7}
Click
sleep, 1400
Send ^{7}
Click
Sleep, 1000
NextLure := 4
goto, Begin

Lure4:

Tooltip, Searching Next Lure, 50, 50
Send ^{Tab}
Loop {
Sleep, 200
ImageSearch, NextLureX, NextLureY, 0, 0, A_ScreenWidth, A_ScreenHeight, ./images/Lure4.png
if ErrorLevel = 0
	goto, Lure4a
}
Lure4a:
;NextLureX += 10
;NextLureY += 10
MouseMove, %NextLureX%, %NextLureY%, 2
sleep, 400
Click, %NextLureX%, %NextLureY%
sleep, 150
Send ^{Tab}
	Tooltip
	Tooltip, Waiting for battle, 50, 50
	Loop {
		done1 := 0
		ImageSearch, Fg, Gf, battlemenuX, battlemenuY, battlemenuX + 180, battlemenuY + 260, *20 ./images/ancientmeganium.png
		If ErrorLevel = 0
			done1++	
		else {
		ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure4f.png
		if (ErrorLevel = 0) {
			goto, Lure5
		}
		}
		if (done1 >= 1) {
			sleep, 8000
			Send {F10}
			goto, Lure4b
		}	
	}
Lure4b:
Tooltip
Tooltip, Waiting Position, 50, 50
Loop {
ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure4f.png
if ErrorLevel = 0
	goto, Lure4c
}
Lure4c:
Tooltip
MouseMove, 920, 390
sleep, 1500
MouseGetPos, LootX, LootY	
Send ^{7}
Click
sleep, 3000
NextLure := 5
goto, Begin

Lure5:

Tooltip, Searching Next Lure, 50, 50
Send ^{Tab}
Loop {
Sleep, 200
ImageSearch, NextLureX, NextLureY, 0, 0, A_ScreenWidth, A_ScreenHeight, ./images/Lure5.png
if ErrorLevel = 0
	goto, Lure5a
}
Lure5a:
;NextLureX += 10
;NextLureY += 10
MouseMove, %NextLureX%, %NextLureY%, 2
sleep, 400
Click, %NextLureX%, %NextLureY%
sleep, 150
Send ^{Tab}
	Tooltip
	Tooltip, Waiting for battle, 50, 50
	Loop {
		done1 := 0
		ImageSearch, Fg, Gf, battlemenuX, battlemenuY, battlemenuX + 180, battlemenuY + 260, *20 ./images/ancientmeganium.png
		If ErrorLevel = 0
			done1++	
		else {
		ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure5f.png
		if (ErrorLevel = 0) {
			goto, Lure6
		}
		}
		if (done1 >= 1) {
			sleep, 5000
			Send {F10}
			goto, Lure5b
		}	
	}
Lure5b:
Tooltip
Tooltip, Waiting Position, 50, 50
Loop {
ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure5f.png
if ErrorLevel = 0
	goto, Lure5c
}
Lure5c:
Tooltip
MouseMove, 790, 520
sleep, 1500
MouseGetPos, LootX, LootY	
Send ^{7}
Click
sleep, 3600
NextLure := 6
goto, Begin

Lure6:

Tooltip, Searching Next Lure, 50, 50
Send ^{Tab}
Loop {
Sleep, 200
ImageSearch, NextLureX, NextLureY, 0, 0, A_ScreenWidth, A_ScreenHeight, ./images/Lure6.png
if ErrorLevel = 0
	goto, Lure6a
}
Lure6a:
;NextLureX += 10
;NextLureY += 10
MouseMove, %NextLureX%, %NextLureY%, 2
sleep, 400
Click, %NextLureX%, %NextLureY%
sleep, 150
Send ^{Tab}
	Tooltip
	Tooltip, Waiting for battle, 50, 50
	Loop {
		done1 := 0
		ImageSearch, Fg, Gf, battlemenuX, battlemenuY, battlemenuX + 180, battlemenuY + 260, *20 ./images/ancientmeganium.png
		If ErrorLevel = 0
			done1++	
		else {
		ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure6f.png
		if (ErrorLevel = 0) {
			goto, Lure7
		}
		}
		if (done1 >= 1) {
			sleep, 5000
			Send {F10}
			goto, Lure6b
		}	
	}
Lure6b:
Tooltip
Tooltip, Waiting Position, 50, 50
Loop {
ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure6f.png
if ErrorLevel = 0
	goto, Lure6c
}
Lure6c:
Tooltip
MouseMove, 790, 520
sleep, 1500
MouseGetPos, LootX, LootY	
Send ^{7}
Click
sleep, 2800
NextLure := 7
goto, Begin

Lure7:

Tooltip, Searching Next Lure, 50, 50
Send ^{Tab}
Loop {
Sleep, 200
ImageSearch, NextLureX, NextLureY, 0, 0, A_ScreenWidth, A_ScreenHeight, ./images/Lure7.png
if ErrorLevel = 0
	goto, Lure7a
}
Lure7a:
;NextLureX += 10
;NextLureY += 10
MouseMove, %NextLureX%, %NextLureY%, 2
sleep, 400
Click, %NextLureX%, %NextLureY%
sleep, 150
Send ^{Tab}
	Tooltip
	Tooltip, Waiting for battle, 50, 50
	Loop {
		done1 := 0
		ImageSearch, Fg, Gf, battlemenuX, battlemenuY, battlemenuX + 180, battlemenuY + 260, *20 ./images/ancientmeganium.png
		If ErrorLevel = 0
			done1++	
		else {
		ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure7f.png
		if (ErrorLevel = 0) {
			goto, Lure1
		}
		}
		if (done1 >= 1) {
			sleep, 6000
			Send {F10}
			goto, Lure7b
		}	
	}
Lure7b:
Tooltip
Tooltip, Waiting Position, 50, 50
Loop {
ImageSearch, Rs, Sr, minimapX, minimapY, minimapX + 190, minimapY + 210, ./images/Lure7f.png
if ErrorLevel = 0
	goto, Lure7c
}
Lure7c:
Tooltip
MouseMove, 790, 270
sleep, 1500
MouseGetPos, LootX, LootY	
Send ^{7}
Click
sleep, 1500
NextLure := 1
goto, Begin

Begin:

Send ^{9}
CoolD6:
Send {F6}
ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *10 ./images/CD6.png
if ErrorLevel = 0
	goto, CoolD6
Send ^{8}
CoolD7: 
Send {F7}
ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *10 ./images/CD7.png
if ErrorLevel = 0
	goto, CoolD7
CoolD5:
Send {F5}
ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *10 ./images/CD5.png
if ErrorLevel = 0
	goto, CoolD5
CoolD9:
Send {F9}
ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *10 ./images/CD9.png
if ErrorLevel = 0
	goto, CoolD9
CoolD8:
Send {F8}
ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *10 ./images/CD8.png
if ErrorLevel = 0
	goto, CoolD8
	
sleep, 1600

Loop2:

MeganiumFound1 := 1
MeganiumFound2 := 0

CoordMode, Pixel, Relative
ImageSearch, Fg, Gf, battlemenuX, battlemenuY, battlemenuX + 180, battlemenuY + 260, *20 ./images/ancientmeganium.png
If ErrorLevel = 1
	MeganiumFound1 = 0
	
if (MeganiumFound1 = 0) {
	
	if (HuntMode = 1) {
	
		MouseGetPos, X, Y
		MouseMove, %RevX%, %RevY%
		sleep, 40
		Click, right, %RevX%, %RevY% 

		Rev3:
		
		MouseMove, %RevX%, %RevY%
		Send {XButton2}
		ImageSearch, Rs, Sr, maxX - 16, maxY - 3, maxX + 40, maxY + 11, *Trans0x0000FF ./images/max.png
		if ErrorLevel = 1 
			goto,  Rev3

		RevStop := 0

		Loop {

			if RevStop = 7
				goto, Ok3
			ImageSearch, Rs, Sr, battlemenuX + 17, battlemenuY + 24, battlemenuX + 100, battlemenuY + 50, *15 ./images/revOut.png
			if (ErrorLevel = 1) {
			
				MouseMove, %RevX%, %RevY%
				sleep, 80
				Click, right, %RevX%, %RevY% 
			
			}
			else
				goto, Ok3
			RevStop++
		}

		Ok3:
		
		Send ^{0}
		
		MouseMove, %LootX%, %LootY%, 2
		Sleep, 40
		Click, %LootX%, %LootY%
	
		Sleep, 1000
		
		ImageSearch, Rs, Sr, battlemenuX + 17, battlemenuY + 24, battlemenuX + 100, battlemenuY + 50, *15 ./images/revOut.png
		if (ErrorLevel = 1) {
		
			MouseMove, %RevX%, %RevY%
			sleep, 80
			Click, right, %RevX%, %RevY% 	
		}
		
		sleep, 750
	
		MouseMove,740, 330, 2
		Sleep, 40
		Click, right, 740, 330
	
		MouseMove,800, 330, 2
		Sleep, 40
		Click, right, 800, 330

		MouseMove,860, 330, 2
		Sleep, 40
		Click, right, 860, 330

		MouseMove,740, 390, 2
		Sleep, 40
		Click, right, 740, 390

		MouseMove,860, 390, 2
		Sleep, 40
		Click, right, 860, 390

		MouseMove,740, 450, 2
		Sleep, 40
		Click, right, 740, 450

		MouseMove,800, 450, 2
		Sleep, 40
		Click, right, 800, 450

		MouseMove,860, 450, 2
		Sleep, 40
		Click, right, 860, 450
		
		MouseMove, %X%, %Y%
	
	}
} else {
	
		MeganiumFound1 := 1
		MeganiumFound2 := 0

	ImageSearch, Fg, Gf, battlemenuX, battlemenuY, battlemenuX + 180, battlemenuY + 260, *20 ./images/ancientmeganium.png
	If ErrorLevel = 0
		MeganiumFound2 = 1
		
	if (MeganiumFound2 = 1) {
			Send {Numpad6}
			goto, Begin
	} else
		goto, Loop2
}
	
If NextLure = 1
	goto, Lure1
else if NextLure = 2
	goto, Lure2
else if NextLure = 3
	goto, Lure3
else if NextLure = 4
	goto, Lure4
else if NextLure = 5
	goto, Lure5
else if NextLure = 6
	goto, Lure6
else if NextLure = 7
	goto, Lure7
