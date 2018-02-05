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
	Sleep, 500
}

StartMission() {
    sclick(1700, 1020)
	Sleep, 1000
	FuelUp()
}


SelectMission(mission) {
	global TopMissionY
	global MissionHeight
	global MissionsPerScreen
	global MissionsPerScreen
	
	if(mission <= MissionsPerScreen) {
		sclick(350, TopMissionY + ((mission-1) * MissionHeight + (MissionHeight / 2) + 20))
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
		return
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

Battle(x,y, flightTime) {
	GoToNode(x, y, flightTime)
	
	; dismiss any Heal Your Party BS
	if(NeedHeal()){
		sclick(1625, 130) ; click close icon
		Sleep, 500
	}
	
	sclick(1500,845) ; click the START button
	Sleep, 3500
	
	sclick(1370, 610) ; click middle critter
	
	Fight()
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

	while(true) {
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

DailyPlanet() {
	sclick(530, 540)
}	

Earth() {
	sclick(590, 530) ; click Earth
}