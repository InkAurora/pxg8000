#NoEnv  
#SingleInstance, force
; #Warn  
; SendMode Input 
SetWorkingDir %A_ScriptDir% 
CoordMode, Pixel, Screen
CoordMode, ToolTip, Screen
CoordMode, Mouse, Screen
SetMouseDelay, 15
firstTimeConfigure := 0

global BASE_ADDRESS := 0x007C6320
SetFormat, Integer, hex
BASE_ADDRESS := ReadMemory(BASE_ADDRESS)
SetFormat, Integer, d

global BATTLE_BASE_ADDRESS := 0x007C5CC0
global BATTLE_OFFSETS := [0x9C, 0x54, 0x8, 0x68, 0x4, 0x54, 0x1C, 0x9C, 0x30]
SetFormat, Integer, hex
BATTLE_BASE_ADDRESS := ReadMemory(BATTLE_BASE_ADDRESS)
BATTLE_BASE_ADDRESS := ReadMemory(BATTLE_BASE_ADDRESS + 0x9C)
BATTLE_BASE_ADDRESS := ReadMemory(BATTLE_BASE_ADDRESS + 0x54)
BATTLE_BASE_ADDRESS := ReadMemory(BATTLE_BASE_ADDRESS + 0x8)
BATTLE_BASE_ADDRESS := ReadMemory(BATTLE_BASE_ADDRESS + 0x68)
BATTLE_BASE_ADDRESS := ReadMemory(BATTLE_BASE_ADDRESS + 0x4)
BATTLE_BASE_ADDRESS := ReadMemory(BATTLE_BASE_ADDRESS + 0x54)
BATTLE_BASE_ADDRESS := ReadMemory(BATTLE_BASE_ADDRESS + 0x1C)
BATTLE_BASE_ADDRESS := ReadMemory(BATTLE_BASE_ADDRESS + 0x9C)
SetFormat, Integer, d

global skillX, skillY
global pokeMenuX, pokeMenuY
global maxX, maxY
global divX, divY, playerX, playerY
global imgHandle, imgHandle1, imgHandle2
global border1X, border1Y, border2X, border2Y, border3X, border3Y, border4X, border4Y
global SQM = [] ; [sqmX, sqmY, sqmXCenter, sqmYCenter, sqmXLow, sqmYLow, sqmXHigh, sqmYHigh]
global stopFish

Gui, +AlwaysOnTop
Gui, Color, 0x272827
Gui, Font, s8, sans-serif
Gui, Add, Button, x10 y247 w50 h20 gReload, Reload
Gui, Add, Button, x10 y10 w80 h20 gConfigure, Configure
Gui, Add, Button, x100 y10 w80 h20 gFirstTimeConfigure, New Here?
Gui, Add, StatusBar,, Idle
Gui, Show, x1 y550 w190 h300, `t
return

; Functions
; -------------------------------------------------------------------------------------------------------------------------------------
; -------------------------------------------------------------------------------------------------------------------------------------

calcSQM_X(posX) {

    posX := posX - border1X

    i := 1
    While (i < 16) {
        sqmL := (i - 1) * divX
        sqmH := i * divX
        
        if (posX > sqmL) AND (posX < sqmH) {
            SQM[0] := i
            sqmL := Round(sqmL + border1X)
            sqmH := Round(sqmH + border1X)
            SQM[2] := sqmL + (divX / 2)
            SQM[4] := sqmL
            SQM[6] := sqmH
            return i
        }

        i++
    }

}

calcSQM_Y(posY) {

    posY := posY - border1Y

    i := 1
    While (i < 12) {
        sqmL := (i - 1) * divY
        sqmH := i * divY
        
        if (posY > sqmL) AND (posY < sqmH) {
            SQM[1] := i
            sqmL := Round(sqmL + border1Y)
            sqmH := Round(sqmH + border1Y)
            SQM[3] := sqmL + (divY / 2)
            SQM[5] := sqmL
            SQM[7] := sqmH
            return i
        }

        i++
    }

}

calcCoord_X(X) {

    posX := ReadMemory(BASE_ADDRESS + 0xC)
    posX -= 8
    posX := posX + calcSQM_X(X)

    return posX

}

calcCoord_Y(Y) {

    posY := ReadMemory(BASE_ADDRESS + 0x10)
    posY -= 6
    posY := posY + calcSQM_Y(Y)

    return posY

}

collectLoot(pX, pY, delay = 50) {

    BlockInput, MouseMove

    LOOT := []

    calcSQM_X(pX - divX)
    LOOT[0] := SQM[2]
    calcSQM_Y(pY - divY)
    LOOT[1] := SQM[3]
    calcSQM_X(pX)
    LOOT[2] := SQM[2]
    calcSQM_Y(pY - divY)
    LOOT[3] := SQM[3]
    calcSQM_X(pX + divX)
    LOOT[4] := SQM[2]
    calcSQM_Y(pY - divY)
    LOOT[5] := SQM[3]
    calcSQM_X(pX + divX)
    LOOT[6] := SQM[2]
    calcSQM_Y(pY)
    LOOT[7] := SQM[3]
    calcSQM_X(pX + divX)
    LOOT[8] := SQM[2]
    calcSQM_Y(pY + divY)
    LOOT[9] := SQM[3]
    calcSQM_X(pX)
    LOOT[10] := SQM[2]
    calcSQM_Y(pY + divY)
    LOOT[11] := SQM[3]
    calcSQM_X(pX - divX)
    LOOT[12] := SQM[2]
    calcSQM_Y(pY + divY)
    LOOT[13] := SQM[3]
    calcSQM_X(pX - divX)
    LOOT[14] := SQM[2]
    calcSQM_Y(pY)
    LOOT[15] := SQM[3]

    MouseMove, LOOT[0], LOOT[1], 2
	Sleep, delay
	Click, right, LOOT[0], LOOT[1]

    MouseMove, LOOT[2], LOOT[3], 2
	Sleep, delay
	Click, right, LOOT[2], LOOT[3]

    MouseMove, LOOT[4], LOOT[5], 2
	Sleep, delay
	Click, right, LOOT[4], LOOT[5]

    MouseMove, LOOT[6], LOOT[7], 2
	Sleep, delay
	Click, right, LOOT[6], LOOT[7]

    MouseMove, LOOT[8], LOOT[9], 2
	Sleep, delay
	Click, right, LOOT[8], LOOT[9]

    MouseMove, LOOT[10], LOOT[11], 2
	Sleep, delay
	Click, right, LOOT[10], LOOT[11]

    MouseMove, LOOT[12], LOOT[13], 2
	Sleep, delay
	Click, right, LOOT[12], LOOT[13]

    MouseMove, LOOT[14], LOOT[15], 2
	Sleep, delay
	Click, right, LOOT[14], LOOT[15]

    BlockInput, MouseMoveOff

    return

}

findPokemonPosition() {

    ImageSearch, a, b, border1X, border1Y, border4X, border4Y, *Trans0x0000FF lifeBar2.png
    if ErrorLevel = 0
        ToolTip

    

}

ReadMemory(address, type := "UInt") {

    static aTypeSize := {    "UChar":    1,  "Char":     1
                        ,   "UShort":   2,  "Short":    2
                        ,   "UInt":     4,  "Int":      4
                        ,   "UFloat":   4,  "Float":    4 
                        ,   "Int64":    8,  "Double":   8}  

    if !aTypeSize.hasKey(type)
        return "", ErrorLevel := -2     

    WinGet, pid, PID, ahk_exe pxgclient.exe

    if !pid 
        return

    if !hProcess := DllCall("OpenProcess", "UInt", 24, "Int", False, "UInt", pid, "Ptr") 
        return 

    success := DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", address, type "*", result, "Ptr", aTypeSize[type], "Ptr", 0)
    DllCall("CloseHandle", "Ptr", hProcess)
    
    return success ? result : ""

}


useRevive() {
    RevX := pokeMenuX + 20
    RevY := pokeMenuY + 75

    imgHandle1 := LoadPicture("imagesNew/max.png")

    ImageSearch, Rs, Sr, skillX + 18, skillY + 24, skillX + 32, skillY + 65, *Trans0x0000FF ./imagesNew/revOut.png
    if (ErrorLevel = 0) {
        BlockInput, MouseMove
        MouseGetPos, X, Y
		MouseMove, RevX, RevY
		sleep, 20
		Click, right
    }
    else if (ErrorLevel = 1) {
        BlockInput, MouseMove
        MouseGetPos, X, Y
        MouseMove, RevX, RevY
        sleep, 20
    }

    Rev1:

    Send {XButton2}
	ImageSearch, Rs, Sr, maxX - 2, maxY, maxX + 25, maxY + 9, *Trans0x0000FF HBITMAP:*%imgHandle1%
	if ErrorLevel = 1
		goto,  Rev1

    imgHandle2 := LoadPicture("imagesNew/revOut.png")

	Loop {
		ImageSearch, Rs, Sr, skillX + 18, skillY + 24, skillX + 32, skillY + 65, *Trans0x0000FF HBITMAP:*%imgHandle2%
		if ErrorLevel = 1 
			Click, right
		else
			goto, Ok1
	}

    Ok1:
    MouseMove, X, Y
    BlockInput, MouseMoveOff
}

; Labels
; -------------------------------------------------------------------------------------------------------------------------------------
; -------------------------------------------------------------------------------------------------------------------------------------

GuiClose:
    ExitApp
    return

FirstTimeConfigure:

    firstTimeConfigure := 1

Configure:

    SB_SetText("Finding Screen Border")

    FindScreenBorder:

    ImageSearch, border1X, border1Y, 0, 0, A_ScreenWidth, A_ScreenHeight, *Trans0x0000FF ./imagesNew/screenBorder1.png
    if ErrorLevel = 1
        goto, FindScreenBorder
    border1Y += 12

    SB_SetText("Adjusting Screen Scale")

    AdjustScreenScale:

    ImageSearch, padraoX, padraoY, 0, 0, A_ScreenWidth, A_ScreenHeight, *5 *Trans0x0000FF ./imagesNew/padrao.png
    if (ErrorLevel = 1) {
        ImageSearch, padraoX, padraoY, 0, 0, A_ScreenWidth, A_ScreenHeight, ./imagesNew/padraoLit.png
        if ErrorLevel = 1
            goto, AdjustScreenScale
    }    
        
    Sleep, 1000

    padraoY -= 4 
    BlockInput, MouseMove 
    MouseMove padraoX, border1Y + 100
    sleep, 40  
    MouseGetPos, X, Y
    MouseMove, padraoX, padraoY  
    sleep, 40
    Click, down
    sleep, 40
    MouseMove, border1X + 100, border1Y + 100
    sleep, 25
    MouseMove, padraoX, border1Y + 700
    sleep, 40
    Click, up
    MouseMove, X, Y
    ImageSearch, border1X, border1Y, 0, 0, A_ScreenWidth, A_ScreenHeight, *Trans0x0000FF ./imagesNew/screenBorder1.png
    if ErrorLevel = 1
        goto, FindScreenBorder
    border1X += 18
    border1Y += 9
    ImageSearch, border2X, border2Y, 0, 0, A_ScreenWidth, A_ScreenHeight, *Trans0x0000FF ./imagesNew/screenBorder2.png
    if ErrorLevel = 1
        goto, FindScreenBorder
    border2X += 21
    border2Y += 6
    ImageSearch, border3X, border3Y, 0, 0, A_ScreenWidth, A_ScreenHeight, *Trans0x0000FF ./imagesNew/screenBorder3.png
    if ErrorLevel = 1
        goto, FindScreenBorder
    border3X += 25
    border3Y += 4
    ImageSearch, border4X, border4Y, 0, 0, A_ScreenWidth, A_ScreenHeight, *Trans0x0000FF ./imagesNew/screenBorder4.png
    if ErrorLevel = 1
        goto, FindScreenBorder
    border4X += 26
    border4Y += 7
    BlockInput, MouseMoveOff

    SB_SetText("Adjusting Minimap")

    AdjustMinimap:

    ImageSearch, minimapX, minimapY, 0, 0, A_ScreenWidth, A_ScreenHeight, *Trans0x0000FF ./imagesNew/minimap.png
    if ErrorLevel = 1
        goto, AdjustMinimap

    ImageSearch, a, b, 0, 0, A_ScreenWidth, A_ScreenHeight, *Trans0x0000FF ./imagesNew/minimap2.png
    if ErrorLevel = 1
        goto, AdjustMinimap
 
    b += 47
    BlockInput, MouseMove
    MouseMove, a + 33, b - 35
    sleep, 100
    MouseClick,,,, 2
    MouseClick,,,, 2
    MouseClick,,,, 2
    MouseClick,,,, 2
    MouseClick,,,, 2
    MouseMove, a + 33, b - 15
    sleep, 100
    MouseClick,,,, 3
    sleep, 100
    MouseMove, a, b  
    sleep, 100
    Click, down
    sleep, 100
    MouseMove, border1X + 100, border1Y + 100
    sleep, 25
    MouseMove, a, minimapY + 230
    sleep, 100
    Click, up
    MouseMove, X, Y
    BlockInput, MouseMoveOff

    SB_SetText("Finding Pokemon Menu")

    FindPokeMenu:

    ImageSearch, pokeMenuX, pokeMenuY, 0, 0, A_ScreenWidth, A_ScreenHeight, *Trans0x0000FF ./imagesNew/pokeMenu.png
    if ErrorLevel = 1
        goto, FindPokeMenu

    ToolTip
    
    ImageSearch, a, b, 0, 0, A_ScreenWidth, A_ScreenHeight, ./imagesNew/pokeMenu2.png
    if (ErrorLevel = 0) {
        Tooltip, Equip a Pokemon to proceed, pokeMenuX, pokeMenuY - 30
        sleep, 2000
        goto, FindPokeMenu
    }

    SB_SetText("Finding Battle Menu")

    FindBattleMenu:

    ImageSearch, battleMenuX, battleMenuY, 0, 0, A_ScreenWidth, A_ScreenHeight, *Trans0x0000FF ./imagesNew/battleMenu.png
    if ErrorLevel = 1
        goto, FindBattleMenu

    ImageSearch, a, b, battleMenuX, battleMenuY, battleMenuX + 190, battleMenuY + 40, ./imagesNew/battleMenu2.png
    if (ErrorLevel = 0) {
        BlockInput, MouseMove
        MouseMove, battleMenuX + 75, battleMenuY + 10
        sleep, 40
        Click
        MouseMove, X, Y
        sleep, 100
        BlockInput, MouseMoveOff
    }

    ImageSearch, a, b, battleMenuX, battleMenuY, battleMenuX + 190, battleMenuY + 40, ./imagesNew/battleMenu3.png
    if (ErrorLevel = 0) {
        BlockInput, MouseMove
        MouseMove, battleMenuX + 95, battleMenuY + 10
        sleep, 40
        Click
        MouseMove, X, Y
        sleep, 100
        BlockInput, MouseMoveOff
    }

    SB_SetText("Adjusting Skill Menu")

    FindSkillMenu:

    sleep, 500

    ImageSearch, skillX, skillY, 0, 0, A_ScreenWidth, A_ScreenHeight, *Trans0x0000FF ./imagesNew/skillMenu.png
    if (ErrorLevel = 1) {
        BlockInput, MouseMove
        MouseMove, pokeMenuX + 20, pokeMenuY + 75
        sleep, 40
        MouseClick, Right
        BlockInput, MouseMoveOff
        goto, FindSkillMenu
    }

    skillX -= 18
    skillY -= 24
    BlockInput, MouseMove
    MouseMove, skillX + 2, skillY + 2
    sleep, 40
    Click, down
    MouseMove, border1X + 100, border1Y + 100
    sleep, 25
    MouseMove, border1X + 957, border1Y + 42
    sleep, 40
    Click, up
    sleep, 40
    MouseMove, X, Y
    sleep, 40
    ImageSearch, skillX, skillY, 0, 0, A_ScreenWidth, A_ScreenHeight, *Trans0x0000FF ./imagesNew/skillMenu.png
    if ErrorLevel = 1
        goto, FindSkillMenu
    skillX -= 18
    skillY -= 24
    BlockInput, MouseMoveOff

    SB_SetText("Idle")

    if (firstTimeConfigure = 0) {
        IniRead, maxX, config.ini, vars, maxX, %A_Space%
        IniRead, maxY, config.ini, vars, maxY, %A_Space%
        goto, endConfig
    }

    ;ToolTip, Use a revive to configure, pokeMenuX, pokeMenuY - 30
    MsgBox Use a revive to configure

    ConfigRevive:

    ImageSearch, maxX, maxY, 0, 0, A_ScreenWidth, A_ScreenHeight, *Trans0x0000FF ./imagesNew/max.png
    if ErrorLevel = 1
        goto, ConfigRevive
    
    ToolTip, Success!, pokeMenuX, pokeMenuY - 30
    sleep, 2000
    ToolTip

    IniWrite, %maxX%, config.ini, vars, maxX
    IniWrite, %maxY%, config.ini, vars, maxY

    endConfig:
        divX := (border2X - border1X) / 15
        divY := (border3Y - border1Y) / 11
        playerX := ((border2X - border1X) / 2) + border1X 
        playerY := ((border3Y - border1Y) / 2) + border1Y 
        ;ToolTip, %divX% %divY%
        Gui, Add, Button, x10 y40 w80 h20 gUseRevive, Use revive
        Gui, Add, Button, x10 y70 w80 h20 gCfgFish, Config. Fishing
        Gui, Add, Button, x10 y100 w80 h20 gTest, Test
        return

; -------------------------------------------------------------------------------------------------------------------------------------

UseRevive:

    useRevive()

    return

Test:

    ; collectLoot(playerX, playerY)

    ; Loop {
    ;     MouseGetPos, X, Y
    ;     posX := calcCoord_X(X)
    ;     posY := calcCoord_Y(Y)

    ;     ToolTip, %posX% %posY%
    ;     ; sleep, 100
    ; }

    ; ToolTip, %posX%

    Loop {
    Rs := ReadMemory(BATTLE_BASE_ADDRESS + 0x30)

    Rs -= 308
    Rs := Round(Rs / 25)

    ToolTip, Elementos no Battle: %Rs%, battleMenuX, battleMenuY
    sleep, 200
    }

    return

CfgFish:

    ToolTip, Move the mouse to desired fishing location and press Space, border1X, border1Y

    OkFish:

    sleep, 100
    GetKeyState, gks, Space
    if (gks = "U") {
        goto, OkFish
    }

    MouseGetPos, fX, fY

    ToolTip, Now equip the pokemon you'd like to use and press Space, border1X, border1Y

    sleep, 500

    OkFish1:

    sleep, 100
    GetKeyState, gks, Space
    if (gks = "U") {
        goto, OkFish1
    }

    sleep, 500

    Gui, Add, Button, x100 y70 w80 h20 gFish, Auto Fish
    ToolTip

    return

Fish:

    stopFish := 0

    calcSQM_X(fX)
    calcSQM_Y(fY)
    fX := SQM[2]
    fY := SQM[3]
    a := SQM[4]
    b := SQM[5]
    c := SQM[6]
    d := SQM[7]

    imgHandle1 := LoadPicture("imagesNew/fishReady.png")

    ToolTip, To stop fishing press Ctrl+Space, border1X, border1Y - 20

    sleep, 400
    Click, %playerX%, %playerY%

    StartFish:

    if stopFish = 1
        return

    sleep, 2000

    Send ^{z}
    sleep, 50
    BlockInput, MouseMove
    MouseMove, fX, fY
    sleep, 50
    Click
    BlockInput, MouseMoveOff

    FishLoop:
        ImageSearch, sR, Rs, a, b, c, d, *100 *Trans0x0000FF HBITMAP:*%imgHandle1%
        if ErrorLevel = 0
            goto, DoneFish
        else
            goto, FishLoop

    DoneFish:

    collectLoot(playerX, playerY, 150)

    sleep, 500

    Send ^{z}
    
    goto, StartFish

    return

; Hotkeys
; -------------------------------------------------------------------------------------------------------------------------------------
; -------------------------------------------------------------------------------------------------------------------------------------

; Numpad5::

;     collectLoot(playerX, playerY)

;     return

^Space::

    ToolTip

    stopFish := 1

    return

^Esc::
    Reload:
    sleep, 700
    Reload

    return
