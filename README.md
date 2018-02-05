# Futurama: Worlds of Tomorrow Macro Toolkit

Tired of punishing events and endless grinding? Time to level the playing field! Use this collection of macros to automate the drudgery and get ahead of the game, such as it is.

**Warning: These are scripts that automate grinding. They know how to watch for running out of fuel and will automatically buy more! So be sure you have pizza available.**

## You will need:

1. Windows
2. [BlueStacks (android emulator)](https://www.bluestacks.com/#gref)
3.  [AutoHotkey](https://autohotkey.com/)
4. [git](https://git-scm.com/download/win)

## Setup:

1. clone this repo:
    ```
    > git clone https://github.com/shmax/fwot-macros.git
    ```
2. Put your screen resolution in 1920 x 1080

3. Run BlueStacks
4. Install Futurama: Worlds of Tomorrow in BlueStacks
5. Run Futurama: Worlds of Tomorrow (in Bluestacks)
6. Find the full screen button in the bottom-right corner of Bluestacks and click it. This script currently only works in full screen.

## Before you run a mission script:
The Futurama game remembers the last planet you visited and the last team that you completed a battle with, and the script simply chooses the first 5 character portraits, so before you run a mission script run through it manually once to bake-in the character set and the current planet.

## To run a script:
Have a look at this file called `fwot.ahk`. Think of this file as the Menu of available missions. Double-click on it to kick off the script. Switch back to BlueStacks and make sure it is running full screen. Once it's running, you can control things with a few different hotkeys:

* `Ctrl-d` for (d)aily planet mission 5 path 1
* `Ctrl-e` for (e)arth mission 5 path 13.
* `F1` to reload the currently running script (think of this as the stop button)
* `Ctrl-q` to exit the script entirely (you will need to double-click to get it going again)

## To add a new mission script:
1. Copy one of the existing ones and update the `GoToNode` and `Battle` calls. To get screen coordinates, use the Window Spy utility that comes with AutoHotKey.

Have fun. Pull requests are welcome, but please don't bombard me with issues. If you see something you don't like, fix it yourself and submit it.

## Coders wanted!
There are a number of features that I would definitely welcome:
* dynamic character selection on battle briefing screen (use [ImageSearch](https://autohotkey.com/docs/commands/ImageSearch.htm) with character icons)
* add more planets and missions
* improve efficiency of battle routine
