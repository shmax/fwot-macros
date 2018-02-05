#Include %A_ScriptDir%\util.ahk
#Include %A_ScriptDir%\missions\dailyplanet\mission_5\path1.ahk

WinActivate BlueStacks

/* Ctrl-d for d(aily planet) mission 5, path 1 */
^d::
    DailyPlanet_Mission5_path1()
    return

/* Ctrl-e for d(aily planet) mission 5, path 1 */
^e::
    Earth_Mission5_path13()
    return

