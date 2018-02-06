/*
Runs the first path of the hardest mission of Daily Planet. It doesn't matter what day of the week it is; they're all the
same.
*/
DailyPlanet(mission, path, cargo:= "") {
	Loop {
		ToSpace()
		SelectDailyPlanet()
		Sleep, 2000

		SelectMission(mission)
		SelectCrew()
		StartMission()

        if(path == 1) {
            GoToNode(630,390, 4000)

            Battle(480,430) ;

            Battle(600, 240) ; next star node

            Battle(1045, 540) ; next star node

            Battle(970, 240) ; next star node

            Battle(1000,500)
        }

        if (cargo) {
            waitForCargo(cargo, 480, 540)
        }
        else {
            Sleep, 15000
       		Return()
       		Sleep, 16000
        }
	}
}