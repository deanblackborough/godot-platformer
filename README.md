# Godot-platformer

Platformer starter for Godot - testing out the engine

More details soon, aiming for feature parity with my [Game Maker Platformer](https://github.com/deanblackborough/gm-platformer) project

## Current Progress
![Gif of Progress](current-progress.gif "Current progress animation")

## Features

- Simple state machine, includes the following states, Fall, Idle, Jump, Run, Land, Hard Land, IdleCrouch and WalkCrouch
- Majority of code in player scripts, states are simple
- Signals for player options, is-crouched, weapon drawn etc.
- MUltiple collision states, raycast 2d to ensure can stand when there is collsion
- Weapon drawn versions for idle and run
- Max Jumps setting
- Hard land timer
- Land time, for weight
- Tilemap for grass with sides based terrain set
- Tilemap for details
- Debug panel to show states other details

## Next
- Clean up states
- Basic enemies, patrolling
- Combat, pixel perfect collisions for swings
- much more.

## To do
Everything to get it equal to the [Game Maker Platformer](https://github.com/deanblackborough/gm-platformer) project and much more

## Credits

- Player character is by https://zegley.itch.io/ - check his page for this asset [here](https://zegley.itch.io/2d-platformermetroidvania-asset-pack)
- Level assets by Kenney http://support.kenney.nl - modified slightly
