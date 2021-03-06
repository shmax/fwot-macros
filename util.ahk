﻿IfWinActive, BlueStacks ;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Event  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include <JSON>
FileRead, FileContents, %A_ScriptDir%\missions\paths.json
Paths := JSON.Load(FileContents, true)

sclick(x, y) {
  Send {Click %x%, %y%}
}

ToSpace(){
	sclick(250, 990) ; click Space button
	Sleep, 4000
}

Next(){
  sclick(1590, 920) ; click Next button
}

/*
 Selects the top 5 character portraits. TODO: write something dynamic
*/
SelectCrew() {
    sclick(110, 280)
	Sleep, 500
	
	sclick(110, 450)
	Sleep, 500
	
	sclick(110, 615)
	Sleep, 500
	
    sclick(270, 280)
	Sleep, 500
	
	sclick(270, 450)
	Sleep, 1500
}

StartMission() {
    sclick(1700, 1020)
	Sleep, 1000
	FuelUp()
	Sleep, 7000
}

/*
Missions selection is two-phase. Step 1 is to
select a mission group. Step 2 is to select
a mission within that group.

The mission argument is a dot-delimited string.
For example, "3.1"
*/
SelectMission(missionPath) {
	TopMissionY = 141
	MissionHeight = 170
	MissionPadding = 40
	MissionsPerScreen = 4

    ; the mission list appears with the first group
    ; already expanded, so we'll click it to close it

    sclick(240, 230)

    parts := StrSplit(missionPath, ".")
    group := parts[1]
    group += 0
    item := parts[2]
    item += 0

    Sleep, 500
    ; expand the group

   	debug("group:" group)
    selectItem(group, TopMissionY, MissionHeight, MissionPadding)

    SubMissionTopY := 325
    SubMissionHeight := 170
    SubMissionPadding := 13

    ; select a mission within that group

    selectItem(item, SubMissionTopY, SubMissionHeight, SubMissionPadding )

    Sleep, 500
	Next()
}

selectItem(item, topOfListY, itemHeight, itemPadding) {
	MissionsPerScreen = 4

	if(item <= MissionsPerScreen) {
		debug("item: " item " topOfListY: " topOfListY " itemHeight: " itemHeight " itemPadding: " itemPadding)
		sclick(250, topOfListY + ((item-1) * (itemHeight + itemPadding)) + (itemHeight / 2))
		Sleep, 1000
	} else {
		tilesToMove := item - MissionsPerScreen

		Loop %tilesToMove% {
			idx := A_Index
			DragStartY := topOfListY + (itemHeight + itemPadding)

			y := topOfListY

			debug( "DragStartY: " DragStartY " y: " y )
			MouseClickDrag, left, 240, DragStartY, 240, y, 50
			Sleep, 500
		}
		Sleep, 500
		SelectItem(item - tilesToMove, topOfListY, itemHeight, itemPadding)
	}
}

Return() {
	sclick(960,900)
}


NeedHeal() {
	ImageSearch, xPos, yPos, 1050, 820, 1200, 880, *140 icons/healall.bmp
	if(ErrorLevel == 0 ) {
		return [xPos+5, yPos+5]
	}
	return null
}

NeedRevive() {
	ImageSearch, xPos, yPos, 820, 260, 1050, 330, *140 icons/revive.bmp
	if(ErrorLevel == 0 ) {
        debug("NeedRevive: revive needed")
		return [xPos+5, yPos+5]
	}
	return null
}

FindCargoDrop(cargo) {
    file1 := "icons/badges/" cargo "-text-obscured.bmp"
    file2 := "icons/badges/" cargo "-text-unobscured.bmp"

	ImageSearch, xPos, yPos, 315, 850, 1620, 860, *8 %file1%
	if(ErrorLevel == 0 ) {
		return 1
	}

	ImageSearch, xPos, yPos, 720, 780, 1216, 820, *80 %file2%
    if(ErrorLevel == 0 ) {
        return 1
    }
	return 0
}

FindStartButton() {
   		ImageSearch, xPos, yPos, 1280, 790, 1730, 900, *20 icons/greenbutton.bmp
   		if(ErrorLevel == 0) {
   		    return 1
   		}
   		return 0
}

TriggerSupers() {
	PORTRAIT_WIDTH = 140
	PORTRAITS_LEFT = 590
	PORTRAITS_Y = 960
	; click all the character portraits
	Loop 5 {
		sclick( PORTRAITS_LEFT + ((A_Index-1) * PORTRAIT_WIDTH) + (PORTRAIT_WIDTH / 2), PORTRAITS_Y )
		Sleep, 20
	}
}

Fight() {

	while(1)
	{
		ImageSearch, xPos, yPos, 750, 700, 1150, 800, *20 icons/greenbutton.bmp
		done := (ErrorLevel == 0)
		if(ErrorLevel == 0) {
			sclick(xPos, yPos)
			Sleep, 100
			return
		}
		; TriggerSupers()
		
		Sleep, 1000
	}
}

FollowPath(nodes) {
    debug("FollowPath")
    for index, element in nodes
    {
        nextNode := nodes[index+1]
        if (element[1] == "node")
        {
            GoToNode(element[2], element[3], nextNode[2])
        }
        else if (element[1] == "battle")
        {
            Battle(element[2], nextNode)
        }
    }
}

GoToNode(pos, dur, nextNodePos){
    x := pos[1]
    y := pos[2]

    debug("GoToNode:" %x% %y%)

    x := pos[1]
    y := pos[2]
	elapsed := 0
	increment := 1000

	res := 0

	Sleep, 500
    reviveButton := NeedRevive()
    if(reviveButton){
        sclick(reviveButton[1], reviveButton[2]) ; click close icon
        Sleep, 500
    }

	sclick(x,y) ; click on the node

	Sleep, 200
	if(FuelUp()) {
		; if we needed fuel right out of the gate, then we're currently stopped and must click
		; the target node again
		sclick(x,y)
	}
	while(elapsed <= dur) {
		; do a fuel check every second
		Sleep, increment

        reviveButton := NeedRevive()
        if(reviveButton){
            sclick(reviveButton[1], reviveButton[2]) ; click close icon
            Sleep, 500
        }

		if(FuelUp() || reviveButton) {
		    ; before we try clicking in a circle, try clicking on the next node.
		    if(nextNodePos) {
		        sclick(nextNodePos[1], nextNodePos[2])
		        Sleep, 200
		     }


			; if we ran out of fuel somewhere in the middle, then we're stalled. We'll click in a circle
			; around the ship to get moving again
			; TODO: if you run out of fuel on a node with branching paths, this can set you off down the wrong path. Figure out a solution
			ClickAroundShip()
		}

		elapsed := elapsed + increment
	}
	Sleep, 500
}

/*
Travel to a point, and keep flying until the "Start" button or the "Heal All" popup appears. If "Heal All" appears it will be automatically closed.
*/
GoToStart(pos, nextNodePos){
    x := pos[1]
    y := pos[2]

    debug("Battle:" %x% %y%)

	res := 0
	increment := 1000
	sclick(x,y) ; click on the node

	startButtonFound := FindStartButton()
	healButton := NeedHeal()
	reviveButton := NeedRevive()

	Sleep, 200
	if(FuelUp()) {
		; if we needed fuel right out of the gate, then we're currently stopped and must click
		; the target node again
		sclick(x,y)
	}

	while(1)
	{
        if(startButtonFound) {
            return
        }

        if(healButton){
            sclick(healButton[1], healButton[2]) ; click close icon
            Sleep, 500
        }

        if(reviveButton){
            sclick(reviveButton[1], reviveButton[2]) ; click close icon
            Sleep, 500
        }

		if(FuelUp()) {
            ; before we try clicking in a circle, try clicking on the next node if one is available.
            if(nextNodePos) {
                sclick(nextNodePos[1], nextNodePos[2])
                Sleep, 200
             }

			; if we ran out of fuel somewhere in the middle, then we're stalled. We'll click in a circle
			; around the ship to get moving again
			ClickAroundShip()
		}

        startButtonFound := FindStartButton()
        healButton := NeedHeal()
        reviveButton := NeedRevive()
        Sleep, 1000
	}
	Sleep, 500
}

Battle(pos, nextNodePos) {
    x := pos[1]
    y := pos[2]

    debug("Battle:" %x% %y%)

	GoToStart(pos, nextNodePos)

    sclick(1500,845) ; click the START button
    Sleep, 4500

	sclick(1370, 610) ; click middle critter

    Sleep, 2000

	Fight()
}

NeedFuel() {
	ImageSearch, FoundX, FoundY, 0, 0, 1400, 750, *20 icons/getdarkmatter.bmp
	
	if (FoundX == "") {
		    debug("NeedFuel: fuel not needed." )
		return 0
	}
	else {
	    debug("NeedFuel: fuel needed. getdarkmatter.bmp found at " . FoundX . ", " . FoundY )
		return 1
	}
}

FuelUp() {
	Res := NeedFuel()
	
	if (Res == 0)
		return 0
	
	Sleep, 500
	
	sclick(1240,750)	; GET button #1
	Sleep, 1000

	sclick(1350,680)	; GET button #2
	Sleep, 1000

	sclick(1230,750) ; "USE" button
	Sleep, 400
	
	return 1
}

Circle(h, k, r, deg) {
	PI := 3.141592653
	step := deg * .017453 ; convert to radians
	theta := 0  ; angle that will be increased each loop

	while(theta <= (2 * PI))
    { 
		x := h + (r * Cos(theta))
		y := k + (r * Sin(theta))
		sclick(x, y)
		theta := theta + step
    }
}

ClickAroundShip(){
    debug("ClickAroundShip")

	ImageSearch, xPos, yPos, 360, 230, 1330, 860, *20 icons/pes.bmp
	Circle(xPos, yPos, 50, 45)
}

RunWaitOne(command) {
    ; WshShell object: http://msdn.microsoft.com/en-us/library/aew9yb99
    shell := ComObjCreate("WScript.Shell")
    ; Execute a single command via cmd.exe
    exec := shell.Exec(ComSpec " /C " command)
    ; Read and return the command's output
    return exec.StdOut.ReadAll()
}

CloseGame() {
    global Config

    Send {Esc} ; take game out of full screen
    Sleep, 3000

    CoordMode, Mouse, Screen
    sclick( Config.closeIconPosition[1], Config.closeIconPosition[2] )
    CoordMode, Mouse, Window

    Sleep, 2000
}

FullScreen() {
    global Config
    CoordMode, Mouse, Screen
    sclick(Config.fullScreenIconPosition[1], Config.fullScreenIconPosition[2])
    CoordMode, Mouse, Window
}

StartGame() {
    global Config
    CoordMode, Mouse, Screen
    sclick(Config.futuramaAppIconPosition[1], Config.futuramaAppIconPosition[2])
    CoordMode, Mouse, Window
    Sleep, 2000
}

EnableNetwork(enable) {
    global Config
    networkName := Config.networkName
    if(enable) {
        cmd := "netsh interface set interface """ . networkName . """ admin=enabled"
        RunWaitOne(cmd)
        Sleep, 5000
    }
    else {
        cmd := "netsh interface set interface """ . networkName . """ admin=disabled"
        RunWaitOne(cmd)
    }
}

Reconnect() {
    ImageSearch, xPos, yPos, 1000, 620, 1460, 800, *20 icons/reconnect.bmp

    if (ErrorLevel == 0) {
        sclick(xPos, yPos)
    }
    Sleep 3000
}

WaitForCargo(cargo, pos) {
    foundCargo := false
    while (!foundCargo) {
        ; disable the network as soon as the battle is complete
        EnableNetwork(false)

        ; wait a few seconds for the loot boxes to open
        Sleep, 8000

        foundCargo := FindCargoDrop(cargo)

        if(foundCargo) {
            EnableNetwork(true)
            Sleep, 10000

            Reconnect()

            Return()
            Sleep, 16000
        }
        else
        {
            CloseGame()
            EnableNetwork(true)
            StartGame()
            FullScreen()
            Sleep, 38000

            ToSpace()
            Battle(pos, null) ; click the planet we just left
        }
    }
}

SelectPlanet(planet) {
    global Paths
    sclick(Paths[planet].coords[1], Paths[planet].coords[2])
}

debug(string) {
	string .= "`n"
    FileAppend %string%, ahk.log
}

RunMission(planet, mission, nodes, cargo:=0)
{
    global Paths
    Loop {
    		ToSpace()
    		SelectPlanet(planet)
    		Sleep, 2000

    		SelectMission(mission)
    		SelectCrew()
    		StartMission()

            FollowPath(nodes)

            if (cargo) {
                waitForCargo(cargo, Paths[planet].reentrycoords)
            }
            else {
                Sleep, 15000
           		Return()
           		Sleep, 19000
            }
    	}
}