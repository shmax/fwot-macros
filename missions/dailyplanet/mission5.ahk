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

        nodes := []

        if(path == 1) {
            nodes.Push(["node",     [630,390], 4000])
            nodes.Push(["battle",   [480,430]])
            nodes.Push(["battle",   [600,240]])
            nodes.Push(["battle",   [1045, 540]])
            nodes.Push(["battle",   [970, 240]])
            nodes.Push(["battle",   [1000, 500]])

            FollowPath(nodes)
        }

        if (cargo) {
            waitForCargo(cargo, [480, 540])
        }
        else {
            Sleep, 15000
       		Return()
       		Sleep, 16000
        }
	}
}