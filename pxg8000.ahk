#include <CGdipSnapshot>
#NoEnv  
#SingleInstance, force
; #Warn  
; SendMode Input 
SetWorkingDir %A_ScriptDir% 
CoordMode, Pixel, Screen
CoordMode, ToolTip, Screen
CoordMode, Mouse, Screen
SetBatchLines, 10ms
SetMouseDelay, 15
firstTimeConfigure := 0
BlockInput, MouseMove
BlockInput, MouseMoveOff
BlockInput, Send
ListLines Off

global BASE_ADDRESS := 0x007C5328
SetFormat, Integer, hex
BASE_ADDRESS := ReadMemory(BASE_ADDRESS)
SetFormat, Integer, d

global skillX, skillY
global pokeMenuX, pokeMenuY, battleMenuX, battleMenuY
global maxX, maxY
global divX, divY, playerX, playerY, centerX, centerY
global imgHandle, imgHandle1, imgHandle2
global border1X, border1Y, border2X, border2Y, border3X, border3Y, border4X, border4Y
global playerCoord := []
global SQM := [] ; [sqmX, sqmY, sqmXCenter, sqmYCenter, sqmXLow, sqmYLow, sqmXHigh, sqmYHigh]
global POKEBAG := []
global POKEBAG_SNAPSHOTS := []
global POKEBAG_TEMP := []
global STOP
global RouteName, MaxLure, CheckLoot, CheckRevive, CheckDefenseCd, DefenseSkill, BushName, BushLaps, Logout
global pokestop, offensiveAssist, LootDelayAssist, CDOrderAssist, defensiveAssist, safeModeAssist, loadSkillsAssist
global CheckSkill1, CheckSkill2, CheckSkill3, CheckSkill4, CheckSkill5, CheckSkill6, CheckSkill7, CheckSkill8, CheckSkill9, CheckSkill10
global CDOrder, isMounted
global BATTLE_BASE_ADDRESS
global IS_ON_BATTLE
global POKE_IS_OUT

global MaxSkill := 10

Gui, Main:New, +AlwaysOnTop
Gui, Main:Color, 0x353535
Gui, Main:Font, s8, sans-serif
Gui, Main:Add, Button, x10 y267 w40 h20 gReload, Reload
Gui, Main:Add, Button, x10 y10 w80 h20 gConfigure, Configure
Gui, Main:Add, Button, x100 y10 w80 h20 gFastConfigure, Fast Configure
Gui, Main:Add, StatusBar,, Idle
Gui, Main:Show, x1 y550 w190 h320, `t

return

; Functions
; -------------------------------------------------------------------------------------------------------------------------------------
; -------------------------------------------------------------------------------------------------------------------------------------

updateOffsets() {

    global SKILL_1 := 0x007C4CC0
    global SKILL_2 := 0x007C4CC0
    global SKILL_3 := 0x007C4CC0
    global SKILL_4 := 0x007C4CC0
    global SKILL_5 := 0x007C4CC0
    global SKILL_6 := 0x007C4CC0
    global SKILL_7 := 0x007C4CC0
    global SKILL_8 := 0x007C4CC0
    global SKILL_9 := 0x007C4CC0
    global SKILL_10 := 0x007C4CC0
    BATTLE_BASE_ADDRESS := 0x007C4CC0
    IS_ON_BATTLE := 0x007C4820
    POKE_IS_OUT := 0x007C4CC0

    SetFormat, Integer, hex

    SKILL_1 := ReadMemory(SKILL_1)
    SKILL_1 := ReadMemory(SKILL_1 + 0x9C)
    SKILL_1 := ReadMemory(SKILL_1 + 0x44)
    SKILL_1 := ReadMemory(SKILL_1 + 0x14)
    SKILL_1 := ReadMemory(SKILL_1 + 0x54)
    SKILL_1 := ReadMemory(SKILL_1 + 0x28)
    SKILL_1 := ReadMemory(SKILL_1 + 0x54)
    SKILL_1 := ReadMemory(SKILL_1 + 0x0)
    SKILL_1 := ReadMemory(SKILL_1 + 0x9C)

    SKILL_2 := ReadMemory(SKILL_2)
    SKILL_2 := ReadMemory(SKILL_2 + 0x9C)
    SKILL_2 := ReadMemory(SKILL_2 + 0x54)
    SKILL_2 := ReadMemory(SKILL_2 + 0x28)
    SKILL_2 := ReadMemory(SKILL_2 + 0x54)
    SKILL_2 := ReadMemory(SKILL_2 + 0x4)
    SKILL_2 := ReadMemory(SKILL_2 + 0x44)
    SKILL_2 := ReadMemory(SKILL_2 + 0x14)
    SKILL_2 := ReadMemory(SKILL_2 + 0x9C)

    SKILL_3 := ReadMemory(SKILL_3)
    SKILL_3 := ReadMemory(SKILL_3 + 0x9C)
    SKILL_3 := ReadMemory(SKILL_3 + 0x54)
    SKILL_3 := ReadMemory(SKILL_3 + 0x28)
    SKILL_3 := ReadMemory(SKILL_3 + 0x54)
    SKILL_3 := ReadMemory(SKILL_3 + 0x8)
    SKILL_3 := ReadMemory(SKILL_3 + 0x60)
    SKILL_3 := ReadMemory(SKILL_3 + 0x0)
    SKILL_3 := ReadMemory(SKILL_3+ 0x0)

    SKILL_4 := ReadMemory(SKILL_4)
    SKILL_4 := ReadMemory(SKILL_4 + 0x9C)
    SKILL_4 := ReadMemory(SKILL_4 + 0x54)
    SKILL_4 := ReadMemory(SKILL_4 + 0x28)
    SKILL_4 := ReadMemory(SKILL_4 + 0x54)
    SKILL_4 := ReadMemory(SKILL_4 + 0xC)
    SKILL_4 := ReadMemory(SKILL_4 + 0x60)
    SKILL_4 := ReadMemory(SKILL_4 + 0x0)
    SKILL_4 := ReadMemory(SKILL_4 + 0x0)

    SKILL_5 := ReadMemory(SKILL_5)
    SKILL_5 := ReadMemory(SKILL_5 + 0x9C)
    SKILL_5 := ReadMemory(SKILL_5 + 0x54)
    SKILL_5 := ReadMemory(SKILL_5 + 0x28)
    SKILL_5 := ReadMemory(SKILL_5 + 0x54)
    SKILL_5 := ReadMemory(SKILL_5 + 0x10)
    SKILL_5 := ReadMemory(SKILL_5 + 0x44)
    SKILL_5 := ReadMemory(SKILL_5 + 0x14)
    SKILL_5 := ReadMemory(SKILL_5 + 0x9C)

    SKILL_6 := ReadMemory(SKILL_6)
    SKILL_6 := ReadMemory(SKILL_6 + 0x9C)
    SKILL_6 := ReadMemory(SKILL_6 + 0x54)
    SKILL_6 := ReadMemory(SKILL_6 + 0x28)
    SKILL_6 := ReadMemory(SKILL_6 + 0x54)
    SKILL_6 := ReadMemory(SKILL_6 + 0x14)
    SKILL_6 := ReadMemory(SKILL_6 + 0x60)
    SKILL_6 := ReadMemory(SKILL_6 + 0x0)
    SKILL_6 := ReadMemory(SKILL_6 + 0x0)

    SKILL_7 := ReadMemory(SKILL_7)
    SKILL_7 := ReadMemory(SKILL_7 + 0x9C)
    SKILL_7 := ReadMemory(SKILL_7 + 0x54)
    SKILL_7 := ReadMemory(SKILL_7 + 0x28)
    SKILL_7 := ReadMemory(SKILL_7 + 0x54)
    SKILL_7 := ReadMemory(SKILL_7 + 0x18)
    SKILL_7 := ReadMemory(SKILL_7 + 0x60)
    SKILL_7 := ReadMemory(SKILL_7 + 0x0)
    SKILL_7 := ReadMemory(SKILL_7 + 0x0)

    SKILL_8 := ReadMemory(SKILL_8)
    SKILL_8 := ReadMemory(SKILL_8 + 0x9C)
    SKILL_8 := ReadMemory(SKILL_8 + 0x60)
    SKILL_8 := ReadMemory(SKILL_8 + 0x0)
    SKILL_8 := ReadMemory(SKILL_8 + 0x28)
    SKILL_8 := ReadMemory(SKILL_8 + 0x54)
    SKILL_8 := ReadMemory(SKILL_8 + 0x1C)
    SKILL_8 := ReadMemory(SKILL_8 + 0x58)
    SKILL_8 := ReadMemory(SKILL_8 + 0x0)

    SKILL_9 := ReadMemory(SKILL_9)
    SKILL_9 := ReadMemory(SKILL_9 + 0x9C)
    SKILL_9 := ReadMemory(SKILL_9 + 0x54)
    SKILL_9 := ReadMemory(SKILL_9 + 0x28)
    SKILL_9 := ReadMemory(SKILL_9 + 0x54)
    SKILL_9 := ReadMemory(SKILL_9 + 0x20)
    SKILL_9 := ReadMemory(SKILL_9 + 0x44)
    SKILL_9 := ReadMemory(SKILL_9 + 0x14)
    SKILL_9 := ReadMemory(SKILL_9 + 0x9C)

    SKILL_10 := ReadMemory(SKILL_10)
    SKILL_10 := ReadMemory(SKILL_10 + 0x9C)
    SKILL_10 := ReadMemory(SKILL_10 + 0x60)
    SKILL_10 := ReadMemory(SKILL_10 + 0x0)
    SKILL_10 := ReadMemory(SKILL_10 + 0x28)
    SKILL_10 := ReadMemory(SKILL_10 + 0x54)
    SKILL_10 := ReadMemory(SKILL_10 + 0x24)
    SKILL_10 := ReadMemory(SKILL_10 + 0x58)
    SKILL_10 := ReadMemory(SKILL_10 + 0x0)

    BATTLE_BASE_ADDRESS := ReadMemory(BATTLE_BASE_ADDRESS)
    BATTLE_BASE_ADDRESS := ReadMemory(BATTLE_BASE_ADDRESS + 0x9C)
    BATTLE_BASE_ADDRESS := ReadMemory(BATTLE_BASE_ADDRESS + 0x68)
    BATTLE_BASE_ADDRESS := ReadMemory(BATTLE_BASE_ADDRESS + 0x8)
    BATTLE_BASE_ADDRESS := ReadMemory(BATTLE_BASE_ADDRESS + 0x68)
    BATTLE_BASE_ADDRESS := ReadMemory(BATTLE_BASE_ADDRESS + 0x4)
    BATTLE_BASE_ADDRESS := ReadMemory(BATTLE_BASE_ADDRESS + 0x58)
    BATTLE_BASE_ADDRESS := ReadMemory(BATTLE_BASE_ADDRESS + 0x1C)
    BATTLE_BASE_ADDRESS := ReadMemory(BATTLE_BASE_ADDRESS + 0x9C)

    IS_ON_BATTLE := ReadMemory(IS_ON_BATTLE)
    IS_ON_BATTLE := ReadMemory(IS_ON_BATTLE + 0x124)
    IS_ON_BATTLE := ReadMemory(IS_ON_BATTLE + 0x0)
    IS_ON_BATTLE := ReadMemory(IS_ON_BATTLE + 0x1C)
    
    POKE_IS_OUT := ReadMemory(POKE_IS_OUT)
    POKE_IS_OUT := ReadMemory(POKE_IS_OUT + 0x9C)
    POKE_IS_OUT := ReadMemory(POKE_IS_OUT + 0x54)
    POKE_IS_OUT := ReadMemory(POKE_IS_OUT + 0x28)

    SetFormat, Integer, d

    return

}

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

changePokemon(pokemonToEquip) {

    SetBatchLines, -1
    SetMouseDelay, -1

    MouseGetPos, X, Y

    snapPokebag0 := new CGdipSnapshot(pokeMenuX + 7, pokeMenuY + 61, 28, 28)
    snapPokebag0.TakeSnapshot()
    snapPokebag1 := new CGdipSnapshot(pokeMenuX + 7, pokeMenuY + 126, 28, 28)
    snapPokebag1.TakeSnapshot()
    snapPokebag2 := new CGdipSnapshot(pokeMenuX + 41, pokeMenuY + 126, 28, 28)
    snapPokebag2.TakeSnapshot()
    snapPokebag3 := new CGdipSnapshot(pokeMenuX + 75, pokeMenuY + 126, 28, 28)
    snapPokebag3.TakeSnapshot()
    snapPokebag4 := new CGdipSnapshot(pokeMenuX + 109, pokeMenuY + 126, 28, 28)
    snapPokebag4.TakeSnapshot()

    POKEBAG_TEMP[0] := snapPokebag0
    POKEBAG_TEMP[1] := snapPokebag1
    POKEBAG_TEMP[2] := snapPokebag2
    POKEBAG_TEMP[3] := snapPokebag3
    POKEBAG_TEMP[4] := snapPokebag4

    if (isMounted) {
        mount()
        isMounted := 0
        sleep, 450
    }

    MouseMove, pokeMenuX + 20, pokeMenuY + 75
    takePokeIn()

    i := 0
    While (i < 5) {
        if (pokemonToEquip = POKEBAG[i]) {
            j := 0
            While (j < 5) {
                if (POKEBAG_SNAPSHOTS[i].Compare(POKEBAG_TEMP[j], 80)) {
                    MouseMove, POKEBAG_TEMP[j]._Coords.x + 14, POKEBAG_TEMP[j]._Coords.y + 14
                    sleep, 100
                    MouseClick,,,,,, D
                    MouseMove, pokeMenuX + 20, pokeMenuY + 75
                    sleep, 100
                    MouseClick,,,,,, U
                    takePokeOut()
                    MouseMove, X, Y
                    return 1
                }
                j++
            }
        }
        i++
    }

    takePokeOut()

    MouseMove, X, Y

    return 0

}

collectLoot(X, Y, mode = 1, delay = 50) {

    SetMouseDelay, -1

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
                sleep, 500
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

compareSnap(X, Y, snap1, snap2, tolerance) {

    SetBatchLines, -1

    i := X
    k := 0
    Loop % snap2._Coords.w {
        j := Y
        l := 0
        Loop % snap2._Coords.h {
            if (!snap1.PixelSnap[i, j].Compare(snap2.PixelSnap[k, l], tolerance)) {
                return 0
            }
            j++
            l++
        }
        i++
        k++
    }

    return 1

}

findPath() {

    

}

getBattleElements() {

    updateOffsets()

    battleElements := ReadMemory(BATTLE_BASE_ADDRESS + 0x30)
    battleElements -= 318
    battleElements := Round(battleElements / 25)

    return battleElements

}

getPlayerCoord() {

    playerCoord[0] := ReadMemory(BASE_ADDRESS + 0xC)
    playerCoord[1] := ReadMemory(BASE_ADDRESS + 0x10)

    return

}

getPokeHealth() {

    a := ReadMemory(BASE_ADDRESS + 0x3E0, "Double") 
    b := ReadMemory(BASE_ADDRESS + 0x3E8, "Double")

    a := a / b
    a := a * 100

    return a

}

getSlotCoords(byref X, byref Y, slot) {



}

imageFind(byref X, byref Y, X1, Y1, X2, Y2, snapshot, tolerance) {

    SetBatchLines, -1

    X2 := X2 - X1
    Y2 := Y2 - Y1

    snapTemp := new CGdipSnapshot(X1, Y1, X2, Y2)
    snapTemp.TakeSnapshot()

    i := 0
    Loop % snapTemp._Coords.w {
        j := 0
        Loop % snapTemp._Coords.h {
            if (snapTemp.PixelSnap[i, j].Compare(snapshot.PixelSnap[0, 0], tolerance)) {
                if (compareSnap(i, j, snapTemp, snapshot, tolerance)) {
                    X := i + X1
                    Y := j + Y1
                    return 1
                }
            }
            j++
        }
        i++
    }

    return 0

}

isOnBattle() {

    updateOffsets()

    a := ReadMemory(IS_ON_BATTLE + 0x4)
    if (a = 1) {
        return 0
    } else if (a = 2) {
        return 1
    }

}

loopParseMatch(var, match) {
    Loop, parse, match, >
    {
        if var = %A_LoopField%
            return 1
    }

    return 0
}

mount() {

    MouseGetPos, X, Y

    if (isMounted != 1) {
        While (isOnBattle()) {

        }
    }

    Send ^{7}

    if (isMounted != 1) {
        isMounted := 1
    }

    return    

}

pokeIsOut() {

    updateOffsets()

    a := ReadMemory(POKE_IS_OUT + 0x3C)
    if (a = 1) {
        return 0
    } else if (a = 257) {
        return 1
    }

}

QPX( N=0 ) { ; Wrapper for QueryPerformanceCounter()by SKAN | CD: 06/Dec/2009
	Static F,A,Q,P,X ; www.autohotkey.com/forum/viewtopic.php?t=52083 | LM: 10/Dec/2009
	If	( N && !P )
		Return	DllCall("QueryPerformanceFrequency",Int64P,F) + (X:=A:=0) + DllCall("QueryPerformanceCounter",Int64P,P)
	DllCall("QueryPerformanceCounter",Int64P,Q), A:=A+Q-P, P:=Q, X:=X+1
	Return	( N && X=N ) ? (X:=X-1)<<64 : ( N=0 && (R:=A/X/F) ) ? ( R + (A:=P:=X:=0) ) : 1
}

ReadMemory(address, type := "UInt") {

    SetBatchLines, -1

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

takePokeIn() {
    
    SetBatchLines, -1
    SetMouseDelay, -1

    RevX := pokeMenuX + 20
    RevY := pokeMenuY + 75
    MouseGetPos, X, Y

    BlockInput, MouseMove
    if (pokeIsOut()) {
        MouseMove, RevX, RevY
        Loop {
            sleep, 30
            Click, right
            Loop, 50 {
                if (!pokeIsOut()) {
                    break 2
                }
                sleep, 10
            }
        }
    } else if (!pokeIsOut()) {
        BlockInput, MouseMoveOff
        return
    }

    MouseMove, X, Y
    BlockInput, MouseMoveOff

    return

}


takePokeOut() {

    SetBatchLines, -1
    SetMouseDelay, -1

    RevX := pokeMenuX + 20
    RevY := pokeMenuY + 75
    MouseGetPos, X, Y

    BlockInput, MouseMove
    if (!pokeIsOut()) {
		Loop {
            MouseMove, RevX, RevY
            sleep, 30
            Click, right
            Loop, 50 {
                if (pokeIsOut()) {
                    break 2
                }
                sleep, 10
            }
        }
    } else if (pokeIsOut()) {
        BlockInput, MouseMoveOff
        return
    }

    MouseMove, X, Y
    BlockInput, MouseMoveOff

    return

}

validateSkills(skillCount := 10) {

    i := 1
    a := 0

    if (skillCount = 0) {
        return 0
    }

    updateOffsets()

    While (i <= skillCount) {
        if (ReadMemory(SKILL_%i% + 0x2C0, "UFloat") != 100) {
            a++
        }

        i++
    }

    if (a = 0) {
        return 0
    } else {
        return a
    }

}

useMedicine() {

    SetBatchLines, -1
    SetMouseDelay, -1

    BlockInput, MouseMove
    MouseGetPos, X, Y
    MouseMove, battleMenuX + 15, battleMenuY + 35
    sleep, 40
    Send {XButton1}
    MouseMove, X, Y
    BlockInput, MouseMoveOff

    return
}

useRevive(defense := 0, skills := 0, safeMode := 0) {

    SetBatchLines, -1

    pokeHealth := (ReadMemory(BASE_ADDRESS + 0x3E0, "Double") / ReadMemory(BASE_ADDRESS + 0x3E8, "Double")) * 100
    if (pokeHealth > 40 AND getBattleElements() > 1 AND safeMode = 1 AND isOnBattle()) {
        ToolTip, Death risk detected`, press again to use revive, border1X, border1Y
        sleep, 600
        a := 0
        Loop, 100 {
            sleep, 25
            if (GetKeyState("Numpad6", "P")) {
                ToolTip
                a := 1
                break
            }
        }
        if (a = 0) {
            ToolTip
            return
        }
    }

    RevX := pokeMenuX + 20
    RevY := pokeMenuY + 75
    a := 10

    imgHandle1 := LoadPicture("imagesNew/max.png")

    if (pokeIsOut() = 1) {
        BlockInput, MouseMove
        MouseGetPos, X, Y
		MouseMove, RevX, RevY
		sleep, 20
		Click, right
    }
    else if (pokeIsOut() = 0) {
        BlockInput, MouseMove
        MouseGetPos, X, Y
        MouseMove, RevX, RevY
        sleep, 20
    }

    QPX(True)

    Rev:

    Send {XButton2}
	ImageSearch, Rs, Sr, maxX - 10, maxY, maxX + 35, maxY + 9, *Trans0x0000FF HBITMAP:*%imgHandle1%
	if ErrorLevel = 1
		goto,  Rev

    imgHandle2 := LoadPicture("imagesNew/revOut.png")

    TakePokeOut:

	Loop {
		if (pokeIsOut() = 0) {
			Click, right
        } else {
		    break
        }
	}

    b := QPX(False)

    if (skills AND validateSkills(a) > 1) {
        if (a = 0) {
            skills := 0
            goto, TakePokeOut
        }
        sleep, 400
        a--
        Click, right
        sleep, 250
        goto, TakePokeOut
    }

    if (defense) {
        Send ^{0}
    }

    MouseMove, X, Y
    BlockInput, MouseMoveOff

    ToolTip, %b%s

    return
}

useReviveMem(defense := 0, skills := 0, safeMode := 0) {

    SetBatchLines, -1
    SetMouseDelay, -1

    if (getPokeHealth() > 20 AND getBattleElements() > 1 AND isOnBattle() AND safeMode) {
        ToolTip, Death risk detected`, press again to use revive, border1X, border1Y
        sleep, 350
        a := 0
        Loop, 100 {
            sleep, 25
            if (GetKeyState("Numpad6", "P")) {
                ToolTip
                a := 1
                skills := 0
                break
            }
        }
        if (a = 0) {
            ToolTip
            return
        }
    }

    RevX := pokeMenuX + 20
    RevY := pokeMenuY + 75
    b := MaxSkill

    oldSnap := new CGdipSnapshot(pokeMenuX + 60, pokeMenuY + 80, 8, 8)
    Snap := new CGdipSnapshot(pokeMenuX + 60, pokeMenuY + 80, 8, 8)

    BlockInput, MouseMove
    MouseGetPos, X, Y
	MouseMove, RevX, RevY
	takePokeIn()

    oldSnap.TakeSnapshot()

    Loop {
        Snap.TakeSnapshot()
        Send {XButton2}
        if (oldSnap.Compare(Snap) = 0) {
            break
        }
    }

    takePokeOut()

    Loop, 3 {
        if (skills AND validateSkills(b) > 0) {
            if (b = 0) {
                skills := 0
                takePokeOut()
            }
            takePokeIn()
            takePokeOut()
        } else if (skills AND !validateSkills(b)) {
            break
        }
    }

    if (defense) {
        Send ^{0}
    }

    MouseMove, X, Y
    BlockInput, MouseMoveOff

    return
}

useSkills(cds := "", stop := 0, offensive := 0) {

    updateOffsets()

    if (stop = 1) {
        Send ^{8}
    }

    Send ^{Up}
    BlockInput, Default

    if (offensive = 1) {
        Send ^{9}
    }

    Loop, Parse, cds, >
    {
        if (A_LoopField != "") {
            Loop {
                Send {F%A_LoopField%}
                if (ReadMemory(SKILL_%A_LoopField% + 0x2C0, "UFloat") != 100) {
                    break
                }
            }
        }
    }

    return

}

; Labels
; -------------------------------------------------------------------------------------------------------------------------------------
; -------------------------------------------------------------------------------------------------------------------------------------

FastConfigure:

    SB_SetText("Finding Screen Border")
    ImageSearch, padraoX, padraoY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 *Trans0x0000FF ./imagesNew/padrao.png
    if (ErrorLevel = 1) {
        ImageSearch, padraoX, padraoY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 ./imagesNew/padraoLit.png
        if ErrorLevel = 1
            goto, FastConfigure
    }
    padraoY -= 4
    IniRead, a, config.ini, vars, padraoX, 0
    IniRead, b, config.ini, vars, padraoY, 0
    if (ErrorLevel = 0 AND (a != padraoX OR b != padraoY)) {
        goto, Configure
        return
    }
    SB_SetText("Finding Skill Menu")
    ImageSearch, skillX, skillY, 0, 0, A_ScreenWidth, A_ScreenHeight, *20 *Trans0x0000FF ./imagesNew/skillMenu.png
    if (ErrorLevel = 1) {
        goto, FastConfigure
    }
    skillX -= 18
    skillY -= 24
    IniRead, a, config.ini, vars, skillX, 0
    IniRead, b, config.ini, vars, skillY, 0
    if (ErrorLevel = 0 AND (a != skillX OR b != skillY)) {
        goto, Configure
        return
    }

    IniRead, border1X, config.ini, vars, border1X, 0
    IniRead, border1Y, config.ini, vars, border1Y, 0
    IniRead, border2X, config.ini, vars, border2X, 0
    IniRead, border2Y, config.ini, vars, border2Y, 0
    IniRead, border3X, config.ini, vars, border3X, 0
    IniRead, border3Y, config.ini, vars, border3Y, 0
    IniRead, border4X, config.ini, vars, border4X, 0
    IniRead, border4Y, config.ini, vars, border4Y, 0
    IniRead, minimapX, config.ini, vars, minimapX, 0
    IniRead, minimapY, config.ini, vars, minimapY, 0
    IniRead, pokeMenuX, config.ini, vars, pokeMenuX, 0
    IniRead, pokeMenuY, config.ini, vars, pokeMenuY, 0
    IniRead, battleMenuX, config.ini, vars, battleMenuX, 0
    IniRead, battleMenuY, config.ini, vars, battleMenuY, 0

    goto, endConfig

Configure:

    SB_SetText("Finding Screen Border")

    FindScreenBorder:

    ImageSearch, border1X, border1Y, 0, 0, A_ScreenWidth, A_ScreenHeight, *Trans0x0000FF ./imagesNew/screenBorder1.png
    if ErrorLevel = 1
        goto, FindScreenBorder
    border1Y += 1

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
    MouseMove, padraoX, border1Y + 850
    sleep, 40
    Click, up
    MouseMove, X, Y
    ImageSearch, border1X, border1Y, 0, 0, A_ScreenWidth, A_ScreenHeight, *0 *Trans0x0000FF ./imagesNew/screenBorder1.png
    if ErrorLevel = 1
        goto, FindScreenBorder
    border1X += 2
    border1Y += 2
    ImageSearch, border2X, border2Y, 0, 0, A_ScreenWidth, border1Y + 60, *0 *Trans0x0000FF ./imagesNew/screenBorder2.png
    if ErrorLevel = 1
        goto, FindScreenBorder
    border2X += 49
    border2Y += 2
    ImageSearch, border3X, border3Y, 0, 0, border1X + 60, A_ScreenHeight, *0 *Trans0x0000FF ./imagesNew/screenBorder3.png
    if ErrorLevel = 1
        goto, FindScreenBorder
    border3X += 2
    border3Y += 49
    border4X := border2X
    border4Y := border3Y
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
    MouseClick,,,, 1
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

    takePokeOut()
    SetMouseDelay, 15

    sleep, 500

    ImageSearch, skillX, skillY, 0, 0, A_ScreenWidth, A_ScreenHeight, *20 *Trans0x0000FF ./imagesNew/skillMenu.png
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
    ImageSearch, skillX, skillY, 0, 0, A_ScreenWidth, A_ScreenHeight, *20 *Trans0x0000FF ./imagesNew/skillMenu.png
    if ErrorLevel = 1
        goto, FindSkillMenu
    skillX -= 18
    skillY -= 24
    BlockInput, MouseMoveOff

    endConfig:

        SB_SetText("Idle")

        updateOffsets()
        divX := (border2X - border1X) / 15
        divY := (border3Y - border1Y) / 11
        centerX := ((border2X - border1X) / 2) + border1X 
        centerY := ((border3Y - border1Y) / 2) + border1Y 
        ;ToolTip, %divX% %divY%

        IniWrite, %padraoX%, config.ini, vars, padraoX
        IniWrite, %padraoY%, config.ini, vars, padraoY
        IniWrite, %skillX%, config.ini, vars, skillX
        IniWrite, %skillY%, config.ini, vars, skillY
        IniWrite, %border1X%, config.ini, vars, border1X
        IniWrite, %border1Y%, config.ini, vars, border1Y
        IniWrite, %border2X%, config.ini, vars, border2X
        IniWrite, %border2Y%, config.ini, vars, border2Y
        IniWrite, %border3X%, config.ini, vars, border3X
        IniWrite, %border3Y%, config.ini, vars, border3Y
        IniWrite, %border4X%, config.ini, vars, border4X
        IniWrite, %border4Y%, config.ini, vars, border4Y
        IniWrite, %minimapX%, config.ini, vars, minimapX
        IniWrite, %minimapY%, config.ini, vars, minimapY
        IniWrite, %pokeMenuX%, config.ini, vars, pokeMenuX
        IniWrite, %pokeMenuY%, config.ini, vars, pokeMenuY
        IniWrite, %battleMenuX%, config.ini, vars, battleMenuX
        IniWrite, %battleMenuY%, config.ini, vars, battleMenuY

        Gui, Main:Add, Button, x10 y40 w80 h20 gUseRevive, Use revive
        Gui, Main:Add, Button, x100 y40 w80 h20 gConfigAssist, Config. Assist
        Gui, Main:Add, Button, x10 y70 w80 h20 gCfgFish, Config. Fishing
        Gui, Main:Add, Button, x10 y100 w80 h20 gNewRoutePrompt, New Route
        Gui, Main:Add, Button, x100 y100 w80 h20 gStartRoutePrompt, Start Route
        Gui, Main:Add, GroupBox, x10 y130 w170 h1
        Gui, Main:Add, Button, x10 y145 w80 h20 gTest, Test
        Gui, Main:Add, Button, x100 y145 w80 h20 gConfigPokebag, Set Pokebag
        Gui, Main:Add, Button, x10 y175 w80 h20 gCfgBush, Config. Bush
        Gui, Main:Add, Button, x100 y175 w80 h20 gStartBushPrompt, Collect Bushes
        ; ToolTip, %border1X% %border1Y% %border2X% %border2Y% %border3X% %border3Y% %border4X% %border4Y%

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
            IniWrite, -10, routes.rte, %RouteName%X, x%a%
            IniWrite, -10, routes.rte, %RouteName%Y, y%a%
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
                Send {Right down}
            } else if (playerX > targetX) {
                Send {Left down}
            }

            if (playerY < targetY) {
                Send {Down down}
            } else if (playerY > targetY) {
                Send {Up down}
            }

            Send {Right up}
            Send {Left up}
            Send {Down up}
            Send {Up up}

            if (playerX = targetX AND playerY = targetY) {
                break
            }
        }

        if (isOnBattle() AND EnableDefense) {
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

            useSkills(CDOrder, 1, 1)

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
                useReviveMem(1, 1)
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
                CDOrder = %CDOrder%%i%>
            }
        }

        i++
    }
    
}

goto, StartRoute

return

UseRevive:

    useReviveMem(1, 1)

return

CfgBush:

    Gui, NewBush:New, +AlwaysOnTop
    Gui, NewBush:Color, 0x353535
    Gui, NewBush:Add, Edit, Limit32 vBushName x10 y10 w180, Route Name
    Gui, NewBush:Add, Button, x10 y70 w180 gConfigureNewBush, Create New Route
    Gui, NewBush:Show, x400 y400 w200 h100, `t

return

ConfigureNewBush:

    a := 0
    b := 0
    oldCoordX := 0
    oldCoordY := 0
    STOP := 0

    Gui, NewBush:Submit
    if (STOP = 1 AND BushName != "") {
        return
    } else if (BushName = "") {
        MsgBox Empty route name!
        ToolTip
        return
    }

    IniWrite, %BushName%, routes.rte, routes, %BushName%

    STOP := 0

    ToolTip, Recording new route`nPress Ctrl+Space to stop, border1X, border1Y - 40

    Click, %centerX%, %centerY%

    Loop {

        sleep, 100
        
        playerX := ReadMemory(BASE_ADDRESS + 0xC)
        playerY := ReadMemory(BASE_ADDRESS + 0x10)

        if (playerX != oldCoordX OR playerY != oldCoordY) {
            IniWrite, %playerX%, routes.rte, %BushName%X, x%a%
            IniWrite, %playerY%, routes.rte, %BushName%Y, y%a%
            a++
            oldCoordX := playerX
            oldCoordY := playerY
        }

        if (GetKeyState("End", "P")) {
            Loop {
                if (GetKeyState("LButton", "P")) {
                    MouseGetPos, X, Y
                    if (Y < (centerY - (divY / 2))) {
                        IniWrite, -1, routes.rte, %BushName%X, x%a%
                        IniWrite, -1, routes.rte, %BushName%Y, y%a%
                        break
                    }
                    if (Y > (centerY + (divY / 2))) {
                        IniWrite, -3, routes.rte, %BushName%X, x%a%
                        IniWrite, -3, routes.rte, %BushName%Y, y%a%
                        break
                    }
                    if (X < (centerX - (divX / 2))) {
                        IniWrite, -4, routes.rte, %BushName%X, x%a%
                        IniWrite, -4, routes.rte, %BushName%Y, y%a%
                        break
                    }
                    if (X > (centerX + (divX / 2))) {
                        IniWrite, -2, routes.rte, %BushName%X, x%a%
                        IniWrite, -2, routes.rte, %BushName%Y, y%a%
                        break
                    }
                }
            }

            a++
        }

        if (STOP = 1) {
            IniWrite, -10, routes.rte, %BushName%X, x%a%
            IniWrite, -10, routes.rte, %BushName%Y, y%a%
            break
        }

    }

    MsgBox, Route created succesfully!

return

StartBushPrompt:

    STOP := 0

    Gui, StartBush:New, +AlwaysOnTop
    Gui, StartBush:Color, 0x353535
    Gui, StartBush:Font, s8 cFFFFFF, sans-serif
    Gui, StartBush:Add, Edit, Limit32 vBushName c000000 x10 y10 w180, Route Name
    Gui, StartBush:Add, Edit, Limit32 vBushLaps Number c000000 x10 y40 w180, Number of Laps
    Gui, StartBush:Add, Checkbox, vLogout Checked0 x10, Logout?
    Gui, StartBush:Add, Button, x10 y370 w180 gStartBush, Start Route
    Gui, StartBush:Show, x%border1X% y%border1Y% w200 h400, `t

return

StartBush:

    Gui, StartBush:Submit
    IniRead, Route, routes.rte, routes, %BushName%, 0

    a := 0
    laps := 0

    if (Route = 0) {
        MsgBox Wrong route name!
        return
    }

    Click, %centerX%, %centerY%

    Loop {
        IniRead, targetX, routes.rte, %Route%X, x%a%, 0
        IniRead, targetY, routes.rte, %Route%Y, y%a%, 0

        a++

        if (STOP = 1) {
            return
        }

        if (targetX = 0 OR targetY = 0) {
            ;MsgBox, error %Route% %targetX% %targetY%
            return
        } else if (targetX < 0 AND targetX > -8) {
            sleep, 500
            BlockInput, MouseMove
            if (targetX = -1) {
                MouseMove, centerX, centerY - divY
                sleep, 50
                Send {End}
                Click
            }
            if (targetX = -2) {
                MouseMove, centerX + divX, centerY
                sleep, 50
                Send {End}
                Click
            }
            if (targetX = -3) {
                MouseMove, centerX, centerY + divY
                sleep, 50
                Send {End}
                Click
            }
            if (targetX = -4) {
                MouseMove, centerX - divX, centerY
                sleep, 50
                Send {End}
                Click
            }
            BlockInput, MouseMoveOff
            sleep, 200
        } else if (targetX = -10 OR targetY = -10) {
            a := 0
            laps++
            if (laps >= BushLaps) {
                if (Logout) {
                    Send ^{l}
                    sleep, 500
                    Send {Enter}
                }
                return
            }
        } else {

            Loop {
                playerX := ReadMemory(BASE_ADDRESS + 0xC)
                playerY := ReadMemory(BASE_ADDRESS + 0x10)

                if (playerX < targetX) {
                    Send {Right down}
                } else if (playerX > targetX) {
                    Send {Left down}
                }

                if (playerY < targetY) {
                    Send {Down down}
                } else if (playerY > targetY) {
                    Send {Up down}
                }

                Send {Right up}
                Send {Left up}
                Send {Down up}
                Send {Up up}

                if (playerX = targetX AND playerY = targetY) {
                    break
                }
            }

        }

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

ConfigAssist:

    Gui, Assist:New, +AlwaysOnTop
    Gui, Assist:Color, 0x353535
    Gui, Assist:Font, s8, sans-serif
    Gui, Assist:Add, Edit, Limit32 vCDOrderAssist c000000 x10 y10 w180, Skill Order: 1>2>3>4>5
    Gui, Assist:Add, Checkbox, vpokestop Checked0 x10 y40 cFFFFFF, Use !pokestop?
    Gui, Assist:Add, Checkbox, voffensiveAssist Checked0 x10 y60 cFFFFFF, Toggle offensive?
    Gui, Assist:Add, GroupBox, x10 y80 w180 h1
    Gui, Assist:Add, Edit, Limit5 vLootDelayAssist c000000 x10 y90 w180, Loot delay in ms
    Gui, Assist:Add, GroupBox, x10 y115 w180 h1
    Gui, Assist:Add, Checkbox, vdefensiveAssist Checked0 x10 y125 cFFFFFF, Toggle defensive?
    Gui, Assist:Add, Checkbox, vloadSkillsAssist Checked0 x10 y145 cFFFFFF, Load skills?
    Gui, Assist:Add, Checkbox, vsafeModeAssist Checked0 x10 y165 cFFFFFF, Safe mode?
    Gui, Assist:Add, Button, x10 y370 w180 gSaveAssist, Save
    Gui, Assist:Show, x%border1X% y%border1Y% w200 h400, `t
    
return

SaveAssist:

    Gui, Assist:Submit

return

ConfigPokebag:

    ToolTip, Arrange your pokemon in the following order:`nMain Slot: Damage`n1st Slot: Healer`n2nd Slot: Silence/Stun`n3rd Slot: Ride`n4th Slot: Fly`nThen press Ctrl+Space, border1X, border1Y

    STOP := 0
    While (!STOP) {

    }

    snapPokebag0 := new CGdipSnapshot(pokeMenuX + 7, pokeMenuY + 61, 28, 28)
    snapPokebag0.TakeSnapshot()
    snapPokebag1 := new CGdipSnapshot(pokeMenuX + 7, pokeMenuY + 126, 28, 28)
    snapPokebag1.TakeSnapshot()
    snapPokebag2 := new CGdipSnapshot(pokeMenuX + 41, pokeMenuY + 126, 28, 28)
    snapPokebag2.TakeSnapshot()
    snapPokebag3 := new CGdipSnapshot(pokeMenuX + 75, pokeMenuY + 126, 28, 28)
    snapPokebag3.TakeSnapshot()
    snapPokebag4 := new CGdipSnapshot(pokeMenuX + 109, pokeMenuY + 126, 28, 28)
    snapPokebag4.TakeSnapshot()

    POKEBAG[0] := "damage"
    POKEBAG[1] := "heal"
    POKEBAG[2] := "silence"
    POKEBAG[3] := "ride"
    POKEBAG[4] := "fly"

    POKEBAG_SNAPSHOTS[0] := snapPokebag0
    POKEBAG_SNAPSHOTS[1] := snapPokebag1
    POKEBAG_SNAPSHOTS[2] := snapPokebag2
    POKEBAG_SNAPSHOTS[3] := snapPokebag3
    POKEBAG_SNAPSHOTS[4] := snapPokebag4

    ToolTip, Success!, border1X, border1Y
    sleep, 1000
    ToolTip

return

Test:

    Click, %centerX%, %centerY%
    sleep, 1000

    a := changePokemon("damage")

return

; Hotkeys
; -------------------------------------------------------------------------------------------------------------------------------------
; -------------------------------------------------------------------------------------------------------------------------------------

; Numpad1::

;     useSkills("10")

; return

Numpad2::

    useMedicine()

return

Numpad3::

    takePokeOut()

return

Numpad4::

    useSkills(CDOrderAssist, pokestop, offensiveAssist)

return

Numpad5::

    collectLoot(centerX, centerY,, LootDelayAssist)

return

Numpad6::

    useReviveMem(defensiveAssist, loadSkillsAssist, safeModeAssist)

return

Numpad7::

    changePokemon("damage")

return

Numpad8::

    changePokemon("heal")
    useSkills("7")

return

Numpad9::

    changePokemon("fly")
    sleep, 150
    mount()

return

NumpadSub::

    changePokemon("ride")
    sleep, 150
    mount()

return

^Numpad3::

    mount()

return

^NumpadAdd::

    if (MaxSkill < 10) {
        MaxSkill++
    }

    ToolTip, Number of Skills: %MaxSkill%, border1X, border1Y
    sleep, 750
    ToolTip

return

^NumpadSub::

    if (MaxSkill > 1) {
        MaxSkill--
    }

    ToolTip, Number of Skills: %MaxSkill%, border1X, border1Y
    sleep, 750
    ToolTip

return

Pause::

    ExitApp

return

ScrollLock::
    Suspend, -1
return

^Space::

    ToolTip

    STOP := 1

return

^Esc::
    Reload:
    BlockInput, MouseMoveOff
    sleep, 500
    Reload

return
