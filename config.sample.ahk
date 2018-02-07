/*
As long as you keep Futurama running full-screen at a desktop resolution of 1920 x 1080 most of the scripts will run smoothly, but a few of the scripts have to take the game out of fullscreen long enough to click buttons in the Bluestacks interface, and for some reason these buttons can appear in different positions in different environments. Before you try to run any scripts, make sure to do the following:

1. Copy this file and rename it as config.ahk
2. Open up the Windows Spy application that comes with AutoHotKey (click the "Follow Mouse" checkbox when it appears)
3. Go through the list of coordinates for icons below and change them to match the numbers you see in the Spy.
*/


Config := {}

Config.networkName := "Ethernet"

; The little red "x" in a circle in the "Futurama" tab in BlueStacks
Config.closeIconPosition := [650,22]

; The Futurama app icon on the BlueStacks desktop
Config.futuramaAppIconPosition := [370,185]

; The full screen icon in the BlueStacks
Config.fullScreenIconPosition := [1650,1020]