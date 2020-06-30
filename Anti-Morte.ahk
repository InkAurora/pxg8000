#NoEnv  
; #Warn  
SendMode Input 
SetWorkingDir %A_ScriptDir%  

IniRead, maxX, max.ini, vars, maxX
IniRead, maxY, max.ini, vars, maxY

CoordMode, Pixel, Relative

Tooltip, Finding BattleMenu, 100, 121

FindBattleMenu:

ImageSearch, battlemenuX, battlemenuY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 battlemenu.png
if ErrorLevel = 1
	goto, FindBattleMenu

battlemenuX -= 5

Tooltip, Finding CD's, 100, 121

FindCD:

ImageSearch, cdmenuX, cdmenuY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 cdmenu.png
if ErrorLevel = 1
	goto, FindCD
	
Tooltip, Finding Pokemon's Bag, 100, 121

FindWhiteBag:

ImageSearch, whitebagX, whitebagY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 WhiteBag.png
if ErrorLevel = 1
	goto, FindWhiteBag
	
whitebagX -= 8
whitebagY -= 8

RevX := 0 
RevY := 0

CoordMode, Pixel, Relative

Tooltip, Finding Revive Slot, 100, 121

RevStart:

ImageSearch, pokemenuX, pokemenuY, 0, 0, A_ScreenWidth, A_ScreenHeight, pokemonmenu.png
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
	
Tooltip

Loop1:

CoordMode, Pixel, Relative
FindTyph:
ImageSearch, typhX, typhY, pokemenuX, pokemenuY, pokemenuX + 190, pokemenuY + 100, *10 typh.png
if ErrorLevel = 0
	goto, FindCast
else
	goto, FindTyph
FindCast:
ImageSearch, castX, castY, whitebagX, whitebagY, whitebagX + 185, whitebagY + 65, *10 cast.png
if (ErrorLevel = 0) {
	MouseMove, castX + 15, castY + 15
	sleep, 40
	Click, down
	sleep, 40
	MouseMove, whitebagX + 22, whitebagY + 41
	sleep, 40
	Click, up
	sleep, 600
	goto, ChangePoke
} else{
	goto, FindCast
}
	
ChangePoke:

ImageSearch, castX, castY, whitebagX, whitebagY, whitebagX + 185, whitebagY + 65, *10 cast.png
if ErrorLevel = 1 
	goto, ChangePoke
		
typhX += 15
typhY += 15
castX += 15
castY += 15
	
Tooltip, Anti-Dead Ready. Waiting., 100, 121
start:
ImageSearch, Rs, Sr, battlemenuX, battlemenuY, battlemenuX + 180, battlemenuY + 150, revOut.png
if (ErrorLevel = 1) {
	start1:
	ImageSearch, Rs, Sr, 1380, 280, 1599, 489, zeroLife.png
	if (ErrorLevel = 0) {
		Send ^{End}
		MouseMove, castX, castY
		sleep, 40
		Click, down
		MouseMove, typhX, typhY
		sleep, 40
		Click, up
		Click, right
		goto, CDS
	} else
		goto, start1
} else 
	goto, start
	
CDS:
Tooltip
FindTyphBag:
Send {F2}
sleep, 2400
	MouseMove, typhX, typhY
	sleep, 40
	Click, right
	sleep, 40
	MouseMove, castX, castY
	sleep, 40
	Click, down
	sleep, 40
	MouseMove, typhX, typhY
	sleep, 40
	Click, up
	sleep, 100

	MouseGetPos, X, Y

	Rev2:

	MouseMove, %RevX%, %RevY%
	Send {XButton2}
	ImageSearch, Rs, Sr, maxX - 16, maxY - 3, maxX + 40, maxY + 11, *Trans0x0000FF max.png
	if ErrorLevel = 1 
		goto,  Rev2

	RevStop := 0

	Loop {

		if RevStop = 7
			goto, Ok2
		ImageSearch, Rs, Sr, battlemenuX + 17, battlemenuY + 24, battlemenuX + 100, battlemenuY + 50, *15 revOut.png
		if (ErrorLevel = 1) {
		
			MouseMove, %RevX%, %RevY%
			sleep, 40
			Click, right, %RevX%, %RevY% 
		
		}
		else
			goto, Ok2
		RevStop++
	}

	Ok2:
	
	MouseGetPos, X, Y
	MouseMove, battlemenuX + 20, battlemenuY + 40
	sleep, 40
	Send {XButton1}
	MouseMove, %X%, %Y%
	Offensive:
	Send ^{9}
	ImageSearch, Rs, Sr, pokemenuX, pokemenuY, pokemenuX + 190, pokemenuY + 100, *10 Offensive.png
	if ErrorLevel = 1
		goto, Offensive
	CD6:
	Send {F6}
	ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *10 CD6.png
	if ErrorLevel = 0
		goto, CD6
	Send ^{8}
	CD7: 
	Send {F7}
	ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *10 CD7.png
	if ErrorLevel = 0
		goto, CD7
	CD5:
	Send {F5}
	ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *10 CD5.png
	if ErrorLevel = 0
		goto, CD5
	CD9:
	Send {F9}
	ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *10 CD9.png
	if ErrorLevel = 0
		goto, CD9
	CD8:
	Send {F8}
	ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *10 CD8.png
	if ErrorLevel = 0
		goto, CD8
	
	sleep, 1000
	
	Tooltip, Resetting..., 100, 121
	goto, reset

reset:

offbattle := 0

ImageSearch, Fg, Gf, typhX - 100, typhY - 100, typhX + 50, typhY + 100, offbattle2.png
if ErrorLevel = 0
	offbattle++
if (offbattle >= 1) {
	MouseMove, typhX, typhY
	sleep, 40
	Click, right
	sleep, 40
	MouseMove, castX, castY
	sleep, 40
	Click, down
	sleep, 40
	MouseMove, typhX, typhY
	sleep, 40
	Click, up
	sleep, 200

	MouseGetPos, X, Y
	MouseMove, %RevX%, %RevY%

	sleep, 300
	Send {XButton2}

	sleep, 500
	MouseMove, castX, castY
	sleep, 40
	Click, down
	sleep, 40
	MouseMove, typhX, typhY
	sleep, 40
	Click, up
	sleep, 40
	Click, right
	sleep, 40
	Send ^{End}
} else
	goto, reset
	
goto, Loop1

^!Esc::
ExitApp
