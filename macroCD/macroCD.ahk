#NoEnv  
; #Warn  
SendMode Input 
SetWorkingDir %A_ScriptDir% 

Tooltip, Adjusting CD's, 100, 100	
FindCD:

ImageSearch, cdmenuX, cdmenuY, 0, 0, A_ScreenWidth, A_ScreenHeight, *100 cdmenu.png
if ErrorLevel = 1
	goto, FindCD

cdmenuX -= 8
cdmenuY -= 8

Tooltip

+Z::

Send ^{9}
CD6:
Send {F6}
ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *100 CD6.png
if ErrorLevel = 0
	goto, CD6
Send ^{8}
CD7: 
Send {F7}
ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *100 CD7.png
if ErrorLevel = 0
	goto, CD7
CD5:
Send {F5}
ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *100 CD5.png
if ErrorLevel = 0
	goto, CD5
CD9:
Send {F9}
ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *100 CD9.png
if ErrorLevel = 0
	goto, CD9
CD8:
Send {F8}
ImageSearch, Rs, Sr, cdmenuX, cdmenuY, cdmenuX + 52, cdmenuY + 340, *100 CD8.png
if ErrorLevel = 0
	goto, CD8
	
Send ^{7}

