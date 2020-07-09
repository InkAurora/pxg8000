#NoEnv  
#SingleInstance, force
; #Warn  
SendMode Input 
SetWorkingDir %A_ScriptDir% 
CoordMode, Pixel, Screen

Gui, Color, 0x272827
Gui, Font, s8, sans-serif
Gui, Add, Button, x110 y10 w90 h20 gfirstTimeConfigure, New Here?
Gui, Add, Button, x10 y10 w90 h20 gConfigure, Configure
Gui, Show, x650 y0 w300 h200, `t
return

; Labels
; -------------------------------------------------------------------------------------------------------------------------------------
; -------------------------------------------------------------------------------------------------------------------------------------

GuiClose:
    ExitApp
    return

firstTimeConfigure:



Configure:

    AdjustScreenScale:

    ImageSearch, padraoX, padraoY, 0, 0, A_ScreenWidth, A_ScreenHeight, ./imagesNew/padrao.png
    if (ErrorLevel = 1) {
        ImageSearch, padraoX, padraoY, 0, 0, A_ScreenWidth, A_ScreenHeight, ./imagesNew/padraoLit.png
        if ErrorLevel = 1
            goto, AdjustScreenScale
    }    
        
    Sleep, 1000

    padraoY -= 3
    MouseGetPos, X, Y
    MouseMove, padraoX, padraoY
    sleep, 100
    Click, down
    sleep, 40
    MouseMove, 420, 735
    sleep, 40
    Click, up
    MouseMove, X, Y

    return

; Hotkeys
; -------------------------------------------------------------------------------------------------------------------------------------
; -------------------------------------------------------------------------------------------------------------------------------------

^Esc::
    sleep, 1500
    Reload

    return