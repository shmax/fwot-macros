/*
Runs the first path of the hardest mission of Daily Planet. It doesn't matter what day of the week it is; they're all the
same.
*/
DailyPlanet_Mission5_path1(cargo) {
	Loop {
		ToSpace()
		Sleep, 1000

		DailyPlanet()
		Sleep, 2000

		SelectMission(8)
		Sleep, 100
		Next()
		Sleep, 50

		SelectCrew()
		Sleep, 1000

		StartMission()
		Sleep, 7000

		GoToNode(630,390, 4000)

		Battle(480,430) ;

		Battle(600, 240) ; next star node

		Battle(1045, 540) ; next star node

		Battle(970, 240) ; next star node

		Battle(1000,500)

		Sleep, 15000

		sclick(960, 920) ; RETURN button

		Return()

		Sleep, 16000

	}
}