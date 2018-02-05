/*
 Earth Mission 5, "Out of Office", path 13. Great path for farming gamma coins.
 Requires: Hermes 27, Scruffy 29
*/
Earth_Mission5_path13() {
	Loop {

		ToSpace()
		Sleep, 1000

		Earth()
		Sleep, 2000

		SelectMission(5)
		Sleep, 100
		Next()
		Sleep, 50

		SelectCrew()
		Sleep, 1000

		StartMission()
		Sleep, 7000

		GoToNode(1080, 540, 5000) ; hermes node

		Battle(1270,460) ; first star node

		Battle(1345, 315) ; next star node

		Battle(970, 240) ; next star node

		Battle(600, 165) ; next star node

		GoToNode(825,390,25000)

		Return()

		Sleep, 16000
	}
}