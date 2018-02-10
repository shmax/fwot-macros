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
2. Copy the file called "config.sample.ahk", rename it to config.sample, and adjust the values contained in it
3. Put your screen resolution in 1920 x 1080
4. Run BlueStacks
5. Install Futurama: Worlds of Tomorrow in BlueStacks
6. Run Futurama: Worlds of Tomorrow (in Bluestacks)
7. Find the full screen button in the bottom-right corner of Bluestacks and click it. This script currently only works in full screen.

## Before you run a mission script:
The Futurama game remembers the last planet you visited and the last team that you completed a battle with, and the script simply chooses the first 5 character portraits, so before you run a mission script play through it manually yourself once to bake-in the character set and the current planet.

Also, make sure that your team is strong enough to easily handle the battles with no input from you. The script will automatically select the middle critter in the front row when the battle begins (for scientists), but otherwise does nothing to manage battle actions.

## To run a script:
Have a look at the file called `fwot.ahk`. Think of this file as the Menu of available missions. Double-click on it to kick off the script. Switch back to BlueStacks and make sure it is running full screen. Once it's running, you can control things with a few different hotkeys:

* `Ctrl-shift-d` for (d)aily planet mission 8 path 1
* `Ctrl-shift-e` for (e)arth valentine's day mission 4, path 1 (for farming orbs)
* `F1` to reload the currently running script (think of this as the stop button)
* `Ctrl-q` to exit the script entirely (you will need to double-click to get it going again)

## To add a new mission script:
1. Examine /missions/paths.json. Add the data for your new mission in there, following the format you see for the existing missions.
2. Modify one of the calls in fwot.ahk, or add a new shortcut.
3. Run your script and watch it loop a few times. If it all works, submit a PR.

Have fun. Pull requests are welcome, but please don't bombard me with issues. If you see something you don't like, fix it yourself and submit it.

## Coders wanted!
There are a number of features that I would definitely welcome:
* dynamic character selection on battle briefing screen (use [ImageSearch](https://autohotkey.com/docs/commands/ImageSearch.htm) with character icons)
* add more planets and missions
* improve efficiency of battle routine
* add advanced battle mechanics (triggering supers, etc)