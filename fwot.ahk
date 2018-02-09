#Include %A_ScriptDir%\util.ahk
#Include %A_ScriptDir%\config.ahk
#Include %A_ScriptDir%\missions\dailyplanet\mission5.ahk
#Include %A_ScriptDir%\missions\dailyplanet\earth\events\valentinesday2018\trueromance.ahk
#Include %A_ScriptDir%\tasks\collectnixonbucks.ahk

WinActivate BlueStacks


/*
F1 - Stop whatever the script is doing and reload it
*/
F1::Reload

/*
Exit the script entirely
*/
^q::exitapp

/*
 MISSIONS
*/

/*
Alt-Shift-d - run (d)aily planet mission 3, path 1 but when we get to the end keep repeating the last battle until we win a 4-star badge.

Note: you must start this script with "Run as Administrator"
*/
^+d::
    DailyPlanet(3, 1, "4-star-badge")
    return

^+e::
    TrueRomance(1)
    return

^+c::
    WaitForCargo("4-star-badge", [480, 540])
    return

^b::
    res := NeedRevive()
    MsgBox %res%
    return

Pause::Pause