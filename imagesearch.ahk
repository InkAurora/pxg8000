Loop {

ImageSearch, Rs, Sr, 0, 0, A_ScreenWidth, A_ScreenHeight, *Trans0x0000FF max.png	
if ErrorLevel = 0
	Tooltip, Found!, 100, 100
if ErrorLevel = 1
	Tooltip, Not Found!, 100, 100
	
sleep, 20

}