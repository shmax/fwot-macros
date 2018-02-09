/*
Runs the "True Romance" mission.
*/
TrueRomance(path, cargo:= "") {
	Loop {
		ToSpace()
		SelectDailyPlanet()
		Sleep, 2000

		SelectMission(4)
		SelectCrew()
		StartMission()

        nodes := []

        if(path == 1) {
            nodes.Push(["battle",   [630,90]])

            nodes.Push(["battle",   [970,240]])
            nodes.Push(["battle",   [970, 240]])
            nodes.Push(["battle",   [970, 240]])
            nodes.Push(["battle",   [970, 990]])
            nodes.Push(["battle",   [820, 840]])
            nodes.Push(["node",     [785, 1065], 7000])

            FollowPath(nodes)
        }

        if (cargo) {
            waitForCargo(cargo, [720, 540])
        }
        else {
            Sleep, 15000
       		Return()
       		Sleep, 16000
        }
	}
}