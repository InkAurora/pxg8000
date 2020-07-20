#NoEnv  
#SingleInstance, force
; #Warn  
SendMode Input 
SetWorkingDir %A_ScriptDir% 
CoordMode, Pixel, Screen
CoordMode, ToolTip, Screen
CoordMode, Mouse, Screen
SetDefaultMouseSpeed, 0
firstTimeConfigure := 0

global BASE_ADDRESS := 0x007C6320
SetFormat, Integer, hex
BASE_ADDRESS := ReadMemory(BASE_ADDRESS)
SetFormat, Integer, d

global skillX, skillY
global pokeMenuX, pokeMenuY
global maxX, maxY
global divX, divY
global imgHandle, imgHandle1, imgHandle2

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

    arr := []

    

}

findPokemonPosition() {

    ImageSearch, a, b, border1X, border1Y, border4X, border4Y, *Trans0x0000FF lifeBar2.png
    if ErrorLevel = 1
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
        divX := Round((border2X - border1X) / 15)
        divY := Round((border3Y - border1Y) / 11)
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

    Loop {
    cX := ReadMemory(BASE_ADDRESS + 0xC)
    cY := ReadMemory(BASE_ADDRESS + 0x10)

    ToolTip, %cX%, 750, 350, 1
    ToolTip, %cY%, 750, 370, 2
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



    return

; Hotkeys
; -------------------------------------------------------------------------------------------------------------------------------------
; -------------------------------------------------------------------------------------------------------------------------------------

^Esc::
    Reload:
    sleep, 700
    Reload

    return
