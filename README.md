# Godot-platformer

Platformer starter for Godot - testing out the engine

More details soon, aiming for feature parity with my [Game Maker Platformer](https://github.com/deanblackborough/gm-platformer) 
project soon and then more in this as it appears to be the favourite over the Game Maker Studio

## Current Progress
![Gif of Progress](current-progress.gif "Current progress animation")

## Features

- Simple state machine, includes the following states
	- Fall
	- Idle (With and without weapon)
	- Jump 
	- Run (With and without weapon)
	- Land 
	- Hard Land 
	- Idle Crouched 
	- Walk Crouched
	- Attack Jab
- Majority of code in player scripts, states are simple, just switch and handle physics
- Signals for player options, is crouched, weapon drawn etc.
- Weapon sheaved when state does not allow attacks
- Multiple collision states, raycast 2d to ensure player can stand when there is collsion above their head
- Max Jumps setting (Includes coyoete timeer and buffering)
- Hard land timer
- Land timer, for weight
- Force standing after crouch fall and crouch jump
- Tilemap for grass with sides based terrain set
- Tilemap for details
- Debug panel to show states and other details

## Next
- Basic enemies, standing and then patrolling
- Combat, hit and hurt boxes, accurate collisions for swings
- much more.

# Issues
- Landing weird when on corner

## To do
Everything to get it equal to the [Game Maker Platformer](https://github.com/deanblackborough/gm-platformer) project and much more

## Credits

- Player character is by https://zegley.itch.io/ - check his page for this asset [here](https://zegley.itch.io/2d-platformermetroidvania-asset-pack)
- Level assets by Kenney http://support.kenney.nl - modified slightly
