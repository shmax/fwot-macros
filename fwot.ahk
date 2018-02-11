#SingleInstance force
#Include %A_ScriptDir%\util.ahk
#Include %A_ScriptDir%\config.ahk
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
Note: you must start this script with "Run as Administrator"
*/
^+d::
    RunMission("dailyplanet", 5, Paths.dailyplanet.path1)
    return

^+e::
    RunMission("dailyplanet", 5, Paths.dailyplanet.path2)
    return

^+v::
    RunMission("dailyplanet", 5, Paths.dailyplanet.path1, "4-star-villain-badge")
    return


^+f::
    RunMission("earth", 4, Paths.earth.loveisintheair.trueromance.path1)
    return

Pause::Pause