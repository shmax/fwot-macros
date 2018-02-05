#Include %A_ScriptDir%\util.ahk
#Include %A_ScriptDir%\missions\dailyplanet\mission_5\path1.ahk
#Include %A_ScriptDir%\missions\earth\mission_5\path13.ahk
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
 Ctrl-d - run d(aily planet) mission 5, path 1
*/
^d::
    DailyPlanet_Mission5_path1("badge-4")
    return

/*
 Ctrl-e for d(aily planet) mission 5, path 1
*/
^e::
    Earth_Mission5_path13()
    return

^c::
    enableNetwork(true)
    return

^v::
    enableNetwork(false)
    return

^b::
    res := FindCargoDrop("badge-4")
    MsgBox %res%
    return