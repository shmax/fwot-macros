#Include %A_ScriptDir%\util.ahk
#Include %A_ScriptDir%\missions\dailyplanet\mission5.ahk
#Include %A_ScriptDir%\missions\earth\mission5.ahk
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
Ctrl-d - run (d)aily planet mission 5, path 1
*/
^d::
    DailyPlanet(5, 1)
    return

/*
Ctrl-Shift-d - run (d)aily planet mission 3, path 1 but when we get to the end keep repeating the last battle until we win a 4-star badge.

Note: you must start this script with "Run as Administrator"
*/
^+d::
    DailyPlanet(3, 1, "badge-4")
    return

/*
Ctrl-e for (d)aily planet mission 5, path 13
*/
^e::
    Earth_5(13)
    return

^+c::
    WaitForCargo("badge-4", 480, 540)
    return

 ^b::
    Reconnect()
    return

Pause::Pause