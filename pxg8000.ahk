#NoEnv  
#SingleInstance, force
; #Warn  
SendMode Input 
SetWorkingDir %A_ScriptDir% 
CoordMode, Pixel, Screen
CoordMode, ToolTip, Screen
CoordMode, Mouse, Screen

Gui, +AlwaysOnTop
Gui, Color, 0x272827
Gui, Font, s8, sans-serif
Gui, Add, Button, x10 y247 w50 h20 gReload, Reload
Gui, Add, Button, x10 y10 w70 h20 gConfigure, Configure
Gui, Add, Button, x90 y10 w70 h20 gFirstTimeConfigure, New Here?
Gui, Add, StatusBar,, Idle
Gui, Show, x0 y550 w170 h300, `t
return

; Labels
; -------------------------------------------------------------------------------------------------------------------------------------
; -------------------------------------------------------------------------------------------------------------------------------------

GuiClose:
    ExitApp
    return

FirstTimeConfigure:

; Gui, Show, Hide



Configure:

    SB_SetText("Finding Screen Border")

    FindScreenBorder:

    ImageSearch, borderX, borderY, 0, 0, A_ScreenWidth, A_ScreenHeight, *Trans0x0000FF ./imagesNew/screenBorder.png
    if ErrorLevel = 1
        goto, FindScreenBorder

    borderY += 12

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
    MouseMove padraoX, padraoY - 50
    sleep, 40  
    MouseGetPos, X, Y
    MouseMove, padraoX, padraoY  
    sleep, 100
    Click, down
    sleep, 100
    MouseMove, padraoX, borderY + 700
    sleep, 100
    Click, up
    MouseMove, X, Y
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
    MouseGetPos, X, Y
    MouseMove, a + 33, b - 35
    sleep, 40
    MouseClick,,,, 10
    MouseMove, a + 33, b - 15
    sleep, 40
    MouseClick,,,, 3
    sleep, 40
    MouseMove, a, b  
    sleep, 40
    Click, down
    sleep, 40
    MouseMove, a, minimapY + 230
    sleep, 40
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
        ; BlockInput, MouseMove
        MouseMove, battleMenuX + 75, battleMenuY + 10
        sleep, 40
        Click
        MouseMove, X, Y
        sleep, 100
    }

    ImageSearch, a, b, battleMenuX, battleMenuY, battleMenuX + 190, battleMenuY + 40, ./imagesNew/battleMenu3.png
    if (ErrorLevel = 0) {
        ; BlockInput, MouseMove
        MouseMove, battleMenuX + 95, battleMenuY + 10
        sleep, 40
        Click
        MouseMove, X, Y
        sleep, 100
    }

    

    SB_SetText("Idle")

    ; Gui, Show
    return

; Hotkeys
; -------------------------------------------------------------------------------------------------------------------------------------
; -------------------------------------------------------------------------------------------------------------------------------------

^Esc::
    Reload:
    sleep, 700
    Reload

    return