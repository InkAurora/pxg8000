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
global divX, divY, playerX, playerY, centerX, centerY
global imgHandle, imgHandle1, imgHandle2
global border1X, border1Y, border2X, border2Y, border3X, border3Y, border4X, border4Y
global playerCoord := []
global SQM = [] ; [sqmX, sqmY, sqmXCenter, sqmYCenter, sqmXLow, sqmYLow, sqmXHigh, sqmYHigh]
global STOP
global RouteName, MaxLure, CheckLoot, CheckRevive, CheckDefenseCd, DefenseSkill
global CheckSkill1, CheckSkill2, CheckSkill3, CheckSkill4, CheckSkill5, CheckSkill6, CheckSkill7, CheckSkill8, CheckSkill9, CheckSkill10
global CDOrder

Gui, Main:New, +AlwaysOnTop
Gui, Main:Color, 0x353535
Gui, Main:Font, s8, sans-serif
Gui, Main:Add, Button, x10 y267 w40 h20 gReload, Reload
Gui, Main:Add, Button, x10 y10 w80 h20 gConfigure, Configure
Gui, Main:Add, Button, x100 y10 w80 h20 gFirstTimeConfigure, New Here?
Gui, Main:Add, StatusBar,, Idle
Gui, Main:Show, x1 y550 w190 h320, `t

; Skills Offsets
; -------------------------------------------------------------------------------------------------------------------------------------

global SKILL_1 := 0x007C5CC0
SetFormat, Integer, hex
SKILL_1 := ReadMemory(SKILL_1)
SKILL_1 := ReadMemory(SKILL_1 + 0x9C)
SKILL_1 := ReadMemory(SKILL_1 + 0x60)
SKILL_1 := ReadMemory(SKILL_1 + 0x0)
SKILL_1 := ReadMemory(SKILL_1 + 0x28)
SKILL_1 := ReadMemory(SKILL_1 + 0x54)
SKILL_1 := ReadMemory(SKILL_1 + 0x0)
SKILL_1 := ReadMemory(SKILL_1 + 0x9C)

global SKILL_2 := 0x007C5CC0
SKILL_2 := ReadMemory(SKILL_2)
SKILL_2 := ReadMemory(SKILL_2 + 0x9C)
SKILL_2 := ReadMemory(SKILL_2 + 0x54)
SKILL_2 := ReadMemory(SKILL_2 + 0x28)
SKILL_2 := ReadMemory(SKILL_2 + 0x54)
SKILL_2 := ReadMemory(SKILL_2 + 0x4)
SKILL_2 := ReadMemory(SKILL_2 + 0x54)
SKILL_2 := ReadMemory(SKILL_2 + 0x0)

global SKILL_3 := 0x007C5CC0
SKILL_3 := ReadMemory(SKILL_3)
SKILL_3 := ReadMemory(SKILL_3 + 0x9C)
SKILL_3 := ReadMemory(SKILL_3 + 0x60)
SKILL_3 := ReadMemory(SKILL_3 + 0x0)
SKILL_3 := ReadMemory(SKILL_3 + 0x28)
SKILL_3 := ReadMemory(SKILL_3 + 0x54)
SKILL_3 := ReadMemory(SKILL_3 + 0x8)
SKILL_3 := ReadMemory(SKILL_3 + 0x9C)

global SKILL_4 := 0x007C5CC0
SKILL_4 := ReadMemory(SKILL_4)
SKILL_4 := ReadMemory(SKILL_4 + 0x9C)
SKILL_4 := ReadMemory(SKILL_4 + 0x54)
SKILL_4 := ReadMemory(SKILL_4 + 0x28)
SKILL_4 := ReadMemory(SKILL_4 + 0x54)
SKILL_4 := ReadMemory(SKILL_4 + 0xC)
SKILL_4 := ReadMemory(SKILL_4 + 0x54)
SKILL_4 := ReadMemory(SKILL_4 + 0x0)

global SKILL_5 := 0x007C5CC0
SKILL_5 := ReadMemory(SKILL_5)
SKILL_5 := ReadMemory(SKILL_5 + 0x54)
SKILL_5 := ReadMemory(SKILL_5 + 0x0)
SKILL_5 := ReadMemory(SKILL_5 + 0x60)
SKILL_5 := ReadMemory(SKILL_5 + 0x0)
SKILL_5 := ReadMemory(SKILL_5 + 0x28)
SKILL_5 := ReadMemory(SKILL_5 + 0x54)
SKILL_5 := ReadMemory(SKILL_5 + 0x10)
SKILL_5 := ReadMemory(SKILL_5 + 0x9C)

global SKILL_6 := 0x007C5CC0
SKILL_6 := ReadMemory(SKILL_6)
SKILL_6 := ReadMemory(SKILL_6 + 0x9C)
SKILL_6 := ReadMemory(SKILL_6 + 0x54)
SKILL_6 := ReadMemory(SKILL_6 + 0x28)
SKILL_6 := ReadMemory(SKILL_6 + 0x54)
SKILL_6 := ReadMemory(SKILL_6 + 0x14)
SKILL_6 := ReadMemory(SKILL_6 + 0x60)
SKILL_6 := ReadMemory(SKILL_6 + 0x0)
SKILL_6 := ReadMemory(SKILL_6 + 0x0)

global SKILL_7 := 0x007C5CC0
SKILL_7 := ReadMemory(SKILL_7)
SKILL_7 := ReadMemory(SKILL_7 + 0x9C)
SKILL_7 := ReadMemory(SKILL_7 + 0x60)
SKILL_7 := ReadMemory(SKILL_7 + 0x0)
SKILL_7 := ReadMemory(SKILL_7 + 0x28)
SKILL_7 := ReadMemory(SKILL_7 + 0x54)
SKILL_7 := ReadMemory(SKILL_7 + 0x18)
SKILL_7 := ReadMemory(SKILL_7 + 0x54)
SKILL_7 := ReadMemory(SKILL_7 + 0x0)

global SKILL_8 := 0x007C5CC0
SKILL_8 := ReadMemory(SKILL_8)
SKILL_8 := ReadMemory(SKILL_8 + 0x9C)
SKILL_8 := ReadMemory(SKILL_8 + 0x54)
SKILL_8 := ReadMemory(SKILL_8 + 0x28)
SKILL_8 := ReadMemory(SKILL_8 + 0x54)
SKILL_8 := ReadMemory(SKILL_8 + 0x1C)
SKILL_8 := ReadMemory(SKILL_8 + 0x44)
SKILL_8 := ReadMemory(SKILL_8 + 0x14)
SKILL_8 := ReadMemory(SKILL_8 + 0x9C)

global SKILL_9 := 0x007C5CC0
SKILL_9 := ReadMemory(SKILL_9)
SKILL_9 := ReadMemory(SKILL_9 + 0x9C)
SKILL_9 := ReadMemory(SKILL_9 + 0x54)
SKILL_9 := ReadMemory(SKILL_9 + 0x28)
SKILL_9 := ReadMemory(SKILL_9 + 0x54)
SKILL_9 := ReadMemory(SKILL_9 + 0x20)
SKILL_9 := ReadMemory(SKILL_9 + 0x60)
SKILL_9 := ReadMemory(SKILL_9 + 0x0)
SKILL_9 := ReadMemory(SKILL_9 + 0x0)

global SKILL_10 := 0x007C5CC0
SKILL_10 := ReadMemory(SKILL_10)
SKILL_10 := ReadMemory(SKILL_10 + 0x9C)
SKILL_10 := ReadMemory(SKILL_10 + 0x60)
SKILL_10 := ReadMemory(SKILL_10 + 0x0)
SKILL_10 := ReadMemory(SKILL_10 + 0x28)
SKILL_10 := ReadMemory(SKILL_10 + 0x54)
SKILL_10 := ReadMemory(SKILL_10 + 0x24)
SKILL_10 := ReadMemory(SKILL_10 + 0x54)
SKILL_10 := ReadMemory(SKILL_10 + 0x0)

global IS_ON_BATTLE := 0x007C5820
IS_ON_BATTLE := ReadMemory(IS_ON_BATTLE)
IS_ON_BATTLE := ReadMemory(IS_ON_BATTLE + 0x124)
IS_ON_BATTLE := ReadMemory(IS_ON_BATTLE + 0x0)
IS_ON_BATTLE := ReadMemory(IS_ON_BATTLE + 0x1C)

SetFormat, Integer, d

return

; -------------------------------------------------------------------------------------------------------------------------------------

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

calcScreenCoordByCoordX(X) {

    a := ReadMemory(BASE_ADDRESS + 0xC)

    if (a > X) {
        a := centerX - (divX * (a - X))
        return a
    }
    if (a <= X) {
        a := centerX + (divX * (X - a))
        return a
    }

    return

}

calcScreenCoordByCoordY(Y) {

    a := ReadMemory(BASE_ADDRESS + 0x10)

    if (a > Y) {
        a := centerY - (divY * (a - Y))
        return a
    }
    if (a <= Y) {
        a := centerY + (divY * (Y - a))
        return a
    }

    return

}

collectLoot(X, Y, mode = 1, delay = 50) {

    if (mode = 2) {
        a := calcScreenCoordByCoordX(X)
        b := calcScreenCoordByCoordY(Y)

        getPlayerCoord()
        oldCoordX := playerCoord[0]
        oldCoordY := playerCoord[1]

        BlockInput, MouseMove
        MouseMove, a, b
        sleep, 40
        Click

        Loop {
            getPlayerCoord()
            Rs := playerCoord[0]
            Sr := playerCoord[1]
            if (Rs = X AND Sr = Y) {
                sleep, 2500
                break
            }
        }

        BlockInput, MouseMoveOff
    }

    getPlayerCoord()
    pX := centerX
    pY := centerY

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

    if (mode = 2) {
        a := calcScreenCoordByCoordX(oldCoordX)
        b := calcScreenCoordByCoordY(oldCoordY)

        BlockInput, MouseMove
        MouseMove, a, b
        sleep, 40
        Click

        Loop {
            getPlayerCoord()
            Rs := playerCoord[0]
            Sr := playerCoord[1]
            if (Rs = oldCoordX AND Sr = oldCoordY) {
                break
            }
        }
    }

    BlockInput, MouseMoveOff

    return

}

findPokemonPosition() {

    ImageSearch, a, b, border1X, border1Y, border4X, border4Y, *Trans0x0000FF lifeBar2.png
    if ErrorLevel = 0
        ToolTip

    

}

findRouteName(name) {



}

getBattleElements() {

    battleElements := ReadMemory(BATTLE_BASE_ADDRESS + 0x30)
    battleElements -= 308
    battleElements := Round(battleElements / 25)

    return battleElements

}

getPlayerCoord() {

    playerCoord[0] := ReadMemory(BASE_ADDRESS + 0xC)
    playerCoord[1] := ReadMemory(BASE_ADDRESS + 0x10)

    return

}

isOnBattle() {

    a := ReadMemory(IS_ON_BATTLE + 0x4)
    if (a = 1) {
        return 0
    } else if (a = 2) {
        return 1
    }

}

loopParseMatch(var, match) {
    Loop, parse, match, `,
    {
        if var = %A_LoopField%
            return 1
    }

    return 0
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
	ImageSearch, Rs, Sr, maxX - 10, maxY, maxX + 35, maxY + 9, *Trans0x0000FF HBITMAP:*%imgHandle1%
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

useSkills(cds := "") {

    StartCD:

    Loop, Parse, cds, `,
    {
        SetFormat, Integer, hex
        if (A_LoopField != "") {
            Loop {
                Send {F%A_LoopField%}
                if ReadMemory(SKILL_%A_LoopField% + 0x2C0, "UFloat") != 100
                    break
            }
        }
        SetFormat, Integer, d
    }

    return

}

; Labels
; -------------------------------------------------------------------------------------------------------------------------------------
; -------------------------------------------------------------------------------------------------------------------------------------

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

    ImageSearch, padraoX, padraoY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 *Trans0x0000FF ./imagesNew/padrao.png
    if (ErrorLevel = 1) {
        ImageSearch, padraoX, padraoY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 ./imagesNew/padraoLit.png
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

    ImageSearch, minimapX, minimapY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 *Trans0x0000FF ./imagesNew/minimap.png
    if ErrorLevel = 1
        goto, AdjustMinimap

    ImageSearch, a, b, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 *Trans0x0000FF ./imagesNew/minimap2.png
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

    ImageSearch, pokeMenuX, pokeMenuY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 *Trans0x0000FF ./imagesNew/pokeMenu.png
    if ErrorLevel = 1
        goto, FindPokeMenu

    ToolTip
    
    ImageSearch, a, b, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 ./imagesNew/pokeMenu2.png
    if (ErrorLevel = 0) {
        Tooltip, Equip a Pokemon to proceed, pokeMenuX, pokeMenuY - 30
        sleep, 2000
        goto, FindPokeMenu
    }

    SB_SetText("Finding Battle Menu")

    FindBattleMenu:

    ImageSearch, battleMenuX, battleMenuY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 *Trans0x0000FF ./imagesNew/battleMenu.png
    if ErrorLevel = 1
        goto, FindBattleMenu

    ImageSearch, a, b, battleMenuX, battleMenuY, battleMenuX + 190, battleMenuY + 40, *10 ./imagesNew/battleMenu2.png
    if (ErrorLevel = 0) {
        BlockInput, MouseMove
        MouseMove, battleMenuX + 75, battleMenuY + 10
        sleep, 40
        Click
        MouseMove, X, Y
        sleep, 100
        BlockInput, MouseMoveOff
    }

    ImageSearch, a, b, battleMenuX, battleMenuY, battleMenuX + 190, battleMenuY + 40, *10 ./imagesNew/battleMenu3.png
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

    ImageSearch, skillX, skillY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 *Trans0x0000FF ./imagesNew/skillMenu.png
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
    MouseMove, border2X + 4, border2Y + 50
    sleep, 40
    Click, up
    sleep, 40
    MouseMove, X, Y
    sleep, 40
    ImageSearch, skillX, skillY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 *Trans0x0000FF ./imagesNew/skillMenu.png
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

    ImageSearch, maxX, maxY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 *Trans0x0000FF ./imagesNew/max.png
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
        centerX := ((border2X - border1X) / 2) + border1X 
        centerY := ((border3Y - border1Y) / 2) + border1Y 
        ;ToolTip, %divX% %divY%
        Gui, Main:Add, Button, x10 y40 w80 h20 gUseRevive, Use revive
        Gui, Main:Add, Button, x10 y70 w80 h20 gCfgFish, Config. Fishing
        Gui, Main:Add, Button, x10 y100 w80 h20 gNewRoutePrompt, New Route
        Gui, Main:Add, Button, x100 y100 w80 h20 gStartRoutePrompt, Start Route
        Gui, Main:Add, GroupBox, x10 y130 w170 h1
        Gui, Main:Add, Button, x10 y145 w80 h20 gTest, Test

return

; -------------------------------------------------------------------------------------------------------------------------------------

MainGuiClose:
    ExitApp
return

StartRouteGuiClose:
    STOP := 1
    Gui, StartRoute:Cancel
return

ASDSeilaMermao:
    startRoute := 1
return

ConfigureNewRoute:

    a := 0
    b := 0
    oldCoordX := 0
    oldCoordY := 0
    STOP := 0

    Gui, NewRoute:Submit
    if (STOP = 1 AND RouteName != "") {
        return
    } else if (RouteName = "") {
        MsgBox Empty route name!
        ToolTip
        return
    }

    IniWrite, %RouteName%, routes.rte, routes, %RouteName%

    STOP := 0

    ToolTip, Recording new route`nPress Ctrl+Space to stop, border1X, border1Y - 40

    Click, %centerX%, %centerY%

    Loop {

    sleep, 100
    
    playerX := ReadMemory(BASE_ADDRESS + 0xC)
    playerY := ReadMemory(BASE_ADDRESS + 0x10)

    if (playerX != oldCoordX OR playerY != oldCoordY) {
        IniWrite, %playerX%, routes.rte, %RouteName%X, x%a%
        IniWrite, %playerY%, routes.rte, %RouteName%Y, y%a%
        a++
        oldCoordX := playerX
        oldCoordY := playerY
    }

    if (STOP = 1) {
        IniWrite, 0, routes.rte, %RouteName%X, x%a%
        IniWrite, 0, routes.rte, %RouteName%Y, y%a%
        break
    }

    }

    MsgBox, Route created succesfully!

return

NewRoutePrompt:

    Gui, NewRoute:New, +AlwaysOnTop
    Gui, NewRoute:Color, 0x353535
    Gui, NewRoute:Add, Edit, Limit32 VRouteName x10 y10 w180, Route Name
    Gui, NewRoute:Add, Button, x10 y70 w180 gConfigureNewRoute, Create New Route
    Gui, NewRoute:Show, x400 y400 w200 h100, `t

return

StartRoute:

    Gui, StartRoute:Submit
    IniRead, Route, routes.rte, routes, %RouteName%, 0

    a := 0

    if (Route = 0) {
        MsgBox Wrong route name!
        return
    }

    Click, %centerX%, %centerY%

    if (CheckDefenseCd) {
        EnableDefense := 1
    }

    Loop {
        IniRead, targetX, routes.rte, %Route%X, x%a%, 0
        IniRead, targetY, routes.rte, %Route%Y, y%a%, 0

        if (targetX = 0 OR targetY = 0) {
            ;MsgBox, error %Route% %targetX% %targetY%
            return
        }

        Loop {
            playerX := ReadMemory(BASE_ADDRESS + 0xC)
            playerY := ReadMemory(BASE_ADDRESS + 0x10)

            if (playerX < targetX) {
                Send {Right}
            } else if (playerX > targetX) {
                Send {Left}
            }

            if (playerY < targetY) {
                Send {Down}
            } else if (playerY > targetY) {
                Send {Up}
            }

            if (playerX = targetX AND playerY = targetY) {
                break
            }
        }

        if (isOnBattle() AND EnableDefense AND getBattleElements() >= 3) {
            useSkills(DefenseSkill)
            EnableDefense := 0
        }

        if (getBattleElements() >= MaxLure + 1) {

            a -= 2
            IniRead, oldCoordX, routes.rte, %Route%X, x%a%, 0
            IniRead, oldCoordY, routes.rte, %Route%Y, y%a%, 0
            a += 2

            X := calcScreenCoordByCoordX(oldCoordX)
            Y := calcScreenCoordByCoordY(oldCoordY)

            BlockInput, MouseMove
            MouseMove, X, Y
            sleep, 40
            Send {MButton}
            BlockInput, MouseMoveOff

            sleep, 4000

            useSkills(CDOrder)

            Loop {
                if (isOnBattle()) {

                } else {
                    break
                }
            }

            if (CheckLoot = 1) {
                collectLoot(oldCoordX, oldCoordY, 2)
            }

            if (CheckRevive = 1) {
                useRevive()
            }

            if (CheckDefenseCd) {
                EnableDefense := 1
            }

        }

        a++

    }

return

StartRoutePrompt:

    CDOrder := ""
    STOP := 0
    startRoute := 0

    Gui, StartRoute:New, +AlwaysOnTop
    Gui, StartRoute:Color, 0x353535
    Gui, StartRoute:Font, s8 cFFFFFF, sans-serif
    Gui, StartRoute:Add, Edit, Limit32 vRouteName c000000 x10 y10 w180, Route Name
    Gui, StartRoute:Add, Text, x10 y40, Max Pokemons to lure:
    Gui, StartRoute:Add, DropDownList, vMaxLure, 1|2|3|4||5|6|7|8
    Gui, StartRoute:Add, Checkbox, vCheckLoot Checked0, Collect Loot?
    Gui, StartRoute:Add, Checkbox, vCheckSkill1 Checked0 x145 y43, Skill 1
    Gui, StartRoute:Add, Checkbox, vCheckSkill2 Checked0 x145 y62, Skill 2
    Gui, StartRoute:Add, Checkbox, vCheckSkill3 Checked0 x145 y81, Skill 3
    Gui, StartRoute:Add, Checkbox, vCheckSkill4 Checked0 x145 y100, Skill 4
    Gui, StartRoute:Add, Checkbox, vCheckSkill5 Checked0 x145 y119, Skill 5
    Gui, StartRoute:Add, Checkbox, vCheckSkill6 Checked0 x145 y138, Skill 6
    Gui, StartRoute:Add, Checkbox, vCheckSkill7 Checked0 x145 y157, Skill 7
    Gui, StartRoute:Add, Checkbox, vCheckSkill8 Checked0 x145 y176, Skill 8
    Gui, StartRoute:Add, Checkbox, vCheckSkill9 Checked0 x145 y195, Skill 9
    Gui, StartRoute:Add, Checkbox, vCheckSkill10 Checked0 x145 y214, Skill 10
    Gui, StartRoute:Add, Checkbox, vCheckRevive Checked0 x10 y105, Use Revive?
    Gui, StartRoute:Add, Checkbox, vCheckDefenseCd Checked0 x10 y124, Use Defense Skill?
    Gui, StartRoute:Add, DropDownList, vDefenseSkill x10 y143, 1|2|3|4|5|6|7|8|9|10
    ; Gui, StartRoute:Add, Edit, Limit32 vCDOrder c000000 x10 y170 w120, Skill Order
    Gui, StartRoute:Add, Button, x10 y370 w180 gASDSeilaMermao, Start Route
    Gui, StartRoute:Show, x%border1X% y%border1Y% w200 h400, `t

    goto, LoopOrderCD

return

LoopOrderCD:

Loop {
    if (STOP) {
        return
    }

    if (startRoute) {
        break
    }

    Gui, StartRoute:Submit, NoHide

    i := 1
    While (i <= 10) {
        if (CheckSkill%i% = 1) {
            a := loopParseMatch(i, CDOrder)
            if (a = 0) {
                CDOrder = %CDOrder%%i%,
            }
            ToolTip, %a% %CDOrder%
        }

        i++
    }
    
}

goto, StartRoute

return

UseRevive:

    useRevive()

return

Test:

    ; Click, %centerX%, %centerY%

    ; ToolTip, a
    ; sleep, 2000
    ; ToolTip

    ; useSkills("6 7 5 8")

    a := "a,b,0,d,e,0,f"
    b := 1
    c := ReadMemory(SKILL_2 + 0x2C0, "UFloat")
    ToolTip, a %c%

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

    Gui, Main:Add, Button, x100 y70 w80 h20 gFish, Auto Fish
    ToolTip

return

Fish:

    STOP := 0

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
    Click, %centerX%, %centerY%

    StartFish:

    if STOP = 1
        return

    sleep, 2000

    Send ^{z}
    sleep, 50
    BlockInput, MouseMove
    MouseMove, fX, fY
    sleep, 50
    Click
    BlockInput, MouseMoveOff

    sleep, 3000

    collectLoot(centerX, centerY, 1, 250)

    FishLoop:
        ImageSearch, sR, Rs, a, b, c, d, *110 *Trans0x0000FF HBITMAP:*%imgHandle1%
        if ErrorLevel = 0
            goto, DoneFish
        else
            goto, FishLoop

    DoneFish:

    sleep, 500

    Send ^{z}
    
    goto, StartFish

return

; Hotkeys
; -------------------------------------------------------------------------------------------------------------------------------------
; -------------------------------------------------------------------------------------------------------------------------------------

Numpad4::

    collectLoot(centerX, centerY)

return

Numpad5::

    useRevive()

return

^Space::

    ToolTip

    STOP := 1

return

^Esc::
    Reload:
    sleep, 700
    Reload

return
