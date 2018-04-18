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
Note: you must start this script with "Run as Administrator" if you want to farm specific rewards; it needs permission to disconnect and reconnect your wifi. See the README for more details.
*/



/*
  2. Influencer Badges, 4-star badges only
  To launch: press Ctrl-Shift-d
*/
^+d::
    RunMission("dailyplanet", "2.2", Paths.dailyplanet.path2, "4-star-influencer-badge")
    return


/*
  9. Nixonbucks, lvl 80 path.
  To launch: press Ctrl-Shift-v
*/
^+v::
    RunMission("dailyplanet", "9.2", Paths.dailyplanet.path2)
    return


/*
You get the idea. Add more commands here if you want.
*/


Pause::Pause