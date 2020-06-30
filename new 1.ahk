MouseGetPos, X, Y
MouseMove, %RevX%, %RevY%
sleep, 40
Click, right, %RevX%, %RevY% 

RevA:

MouseMove, %RevX%, %RevY%
Send {XButton2}
ImageSearch, Rs, Sr, tradecenterX + 563, tradecenterY - 30, tradecenterX + 650, tradecenterY + 11, *Trans0x0000FF max.png
if ErrorLevel = 1 
	goto,  RevA

RevStop := 0

Loop {

	if RevStop = 7
		goto, Ok1
	ImageSearch, Rs, Sr, battlemenuX, battlemenuY, battlemenuX + 180, battlemenuY + 150, revOut.png
	if (ErrorLevel = 1) {
	
		MouseMove, %RevX%, %RevY%
		sleep, 40
		Click, right, %RevX%, %RevY% 
	
	}
	else
		goto, Ok1
	RevStop++
	sleep, 70
}

Ok1:

MouseMove, %X%, %Y%














MouseMove, %RevX%, %RevY%
sleep, 240
Click, right, %RevX%, %RevY%
sleep, 50
Send ^{0}

sleep, 250