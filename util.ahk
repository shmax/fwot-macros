IfWinActive, BlueStacks ;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Event  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

TopMissionY = 166
MissionHeight = 229
MissionsPerScreen = 4

sclick(x, y) {
  Send {Click %x%, %y%}
}

ToSpace(){
	sclick(250, 990) ; click Space button
	Sleep, 4000
}

Next(){
  sclick(1710, 1020) ; click Next button
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


SelectMission(mission) {
	global TopMissionY
	global MissionHeight
	global MissionsPerScreen
	global MissionsPerScreen
	
	if(mission <= MissionsPerScreen) {
		sclick(350, TopMissionY + ((mission-1) * MissionHeight + (MissionHeight / 2) + 20))
		Sleep, 1000
		Next()
		Sleep, 100
	} else {
		tilesToMove := mission - MissionsPerScreen
		
		Loop %tilesToMove% {
			idx := A_Index
			DragStartY := TopMissionY + (MissionHeight)
			
			y = DragStartY - MissionHeight;
			MouseClickDrag, left, 350, DragStartY, 350, DragStartY - MissionHeight, 50
			Sleep, 100
		}
		Sleep, 500
		SelectMission(mission - tilesToMove)
	}
}

Return() {
	sclick(960,900)	
}


NeedHeal() {
	ImageSearch, xPos, yPos, 1050, 820, 1200, 880, *140 icons/healall.bmp
	if(ErrorLevel == 0 ) {
		return 1
	}
	return 0
}

FindCargoDrop(cargo) {
    if (cargo == "badge-4") {
        file1 := "icons/badge4star-text-obscured.bmp"
        file2 := "icons/badge4star-text-unobscured.bmp"
    }
    else if (cargo == "badge-2") {
        file1 := "icons/badge2star-text-obscured.bmp"
        file2 := "icons/badge2star-text-unobscured.bmp"
    }
	ImageSearch, xPos, yPos, 720, 780, 1216, 820, *8 %file1%
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

GoToNode(x,y, dur){
	elapsed := 0
	increment := 1000
	
	res := 0
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
		if(FuelUp()) {
			; if we ran out of fuel somewhere in the middle, then we're stalled. We'll click in a circle
			; around the ship to get moving again
			ClickAroundShip()
		}
		elapsed := elapsed + increment
	}
	Sleep, 500
}

/*
Travel to a point, and keep flying until the "Start" button or the "Heal All" popup appears. If "Heal All" appears it will be automatically closed.
*/
GoToStart(x,y){
	res := 0
	increment := 1000
	sclick(x,y) ; click on the node

	startButtonFound := FindStartButton()
	needHealButtonFound := NeedHeal()

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

        if(needHealButtonFound){
            sclick(1625, 130) ; click close icon
            Sleep, 500
        }

		if(FuelUp()) {
			; if we ran out of fuel somewhere in the middle, then we're stalled. We'll click in a circle
			; around the ship to get moving again
			ClickAroundShip()
		}

        startButtonFound := FindStartButton()
        needHealButtonFound := NeedHeal()
        Sleep, 1000
	}
	Sleep, 500
}

Battle(x,y) {
	GoToStart(x, y)

    sclick(1500,845) ; click the START button
    Sleep, 4500

	sclick(1370, 610) ; click middle critter

	Fight()
}

NeedFuel() {
	ImageSearch, FoundX, FoundY, 0, 0, 1400, 750, *40 icons/getdarkmatter.bmp
	
	if (FoundX == "") {
		return 0
	}
	else {
		return 1
	}
}

FuelUp() {
	Res := NeedFuel()
	
	if (Res == 0)
		return 0
	
	Sleep, 500
	
	sclick(1240,750)	; GET button #1
	Sleep, 500
	
	sclick(1300,680)	; GET button #2
	Sleep, 400
	
	sclick(1250,740) ; "USE" button
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
	ImageSearch, xPos, yPos, 360, 230, 1330, 860, *20 icons/pes.bmp
	Circle(xPos, yPos, 50, 45)
}

SelectDailyPlanet() {
	sclick(530, 540)
}	

Earth() {
	sclick(590, 530) ; click Earth
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
    Send {Esc} ; take game out of full screen
    Sleep, 3000

    CoordMode, Mouse, Screen
    sclick( 650, 22 )
    CoordMode, Mouse, Window

    Sleep, 2000
}

FullScreen() {
    CoordMode, Mouse, Screen
    sclick(1650, 1025)
    CoordMode, Mouse, Window
}

StartGame() {
    CoordMode, Mouse, Screen
    sclick(370, 185)
    CoordMode, Mouse, Window
    Sleep, 2000
}

EnableNetwork(enable) {
    if(enable) {
        Run *RunAs bat\enablenetwork.bat
        Sleep, 5000
    }
    else {
        Run *RunAs bat\disablenetwork.bat
    }
}

Reconnect() {
    ImageSearch, xPos, yPos, 1000, 620, 1460, 800, *20 icons/reconnect.bmp

    if (ErrorLevel == 0) {
        sclick(xPos, yPos)
    }
}

WaitForCargo(cargo, x, y) {
    foundCargo := false
    while (!foundCargo) {
        ; disable the network as soon as the battle is complete
        Sleep, 1500
        EnableNetwork(false)

        ; wait a few seconds for the loot boxes to open
        Sleep, 8000

        foundCargo := FindCargoDrop(cargo)

;        MsgBox %foundCargo%
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
            Battle(x, y) ; click the planet we just left
        }
    }
}