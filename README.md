# Godot Platformer Starter

A work-in-progress platformer starter project for Godot 4.4+, built as both a testbed for 
learning the engine and a solid foundation for future projects.

The goal is to create a clean, reusable, and extensible base with all the fundamentals 
you’d expect from a modern 2D platformer: responsive movement, a flexible state machine, 
and early building blocks for combat, environment interaction, and progression systems.

My [son](https://github.com/jackblackborough) will use this to develop his own games and ideas, 
he is a huge fan of Hollow Knight and Dead Cells

This project is being developed in parallel with my 
[Game Maker Platformer Starter](https://github.com/deanblackborough/gm-platformer). 
The plan is to reach feature parity with the GMS version in the very near future—then 
expand beyond it, taking advantage of Godot’s strengths (open source, first-class 
scene system, flexible scripting).

For me this project is primarily a testbed for platformer ideas and teaching my sons to 
code. While I plan to eventually develop my own custom engine, Godot makes an excellent 
sandbox for quickly testing mechanics and experimenting with design.

## Current Progress
![Gif of Progress](current-progress.gif "Current progress animation")

## Current Features (WIP)

This starter is built around a simple but extensible state machine. The goal is to 
keep the player logic clean, physics consistent, and states lightweight so they can be 
expanded later.

### Player States

#### Currently implemented:

- Fall
- Idle (with or without weapon)
- Jump
- Run (with or without weapon)
- Land
- Hard Land
- Idle Crouched
- Walk Crouched
- Attack Jab
- Attack Overhead

#### Core Systems

- Lightweight state scripts: Most logic lives in the Player script; states just handle 
switching and physics adjustments.
- Signals for player status: Track options like crouching or weapon draw state.
- Weapon handling: Weapons are automatically sheathed in states where attacking isn’t possible.
- Committed attacks: Once an attack starts, it must finish—no cancelling or mid-swing switching.

#### Combat & Collision

- Basic hurtboxes + hitboxes: Enemies are deleted on hit for now—health/damage systems are still in progress.
- Multiple collision states: Uses RayCast2D to check whether the player can stand (prevents clipping into ceilings).
- Jump system: Includes configurable max jumps, coyote time, and input buffering.
- Landing weight: Both hard land and soft land timers add a sense of impact.
- Force stand mechanic: Player is forced upright after crouch-jumps and crouch-falls.

#### Level & Debugging

- Grass terrain tileset with sides-based terrain setup.
- Detail tileset for background/world dressing.
- Debug panel to display current state and runtime values.

## Next Up

Work in progress — here’s what’s currently on the horizon:

- Enemy basics
	- Placeholder “one-frame” animations in place now
	- Expanding into proper enemy states: Idle, Patrol, Target/Chase, Attack, and Die
	- Laying the foundation for more advanced AI later
- Combat improvements
	- Overhead attack collision tuned for better hit detection
	- Player and enemy health systems (no more instant deletes!)
	- Iterating on overall combat feel — timing, weight, and responsiveness
	- Weapons will auto-draw if you attack while sheathed, keeping flow snappy
- Polish & systems
	- More visual feedback (hit flashes, particles, screen shake)
	- Better debug tools for states, collisions, and timings
	- Continuing to refine state transitions for smoother gameplay
	- And of course: much more as the core loop starts feeling good.
	
## Known Issues

There are a few rough edges:

- Landing quirks — corner cases (literally!) where the player lands strangely when 
clipping onto tile edges
- State naming — current states include “State” in their names; redundant and will 
be cleaned up soon
- General roughness — early systems are in place but still very WIP; 
lots of polish passes to come

## Credits

I'm working on systems, not art, the plan is my son will help with the art or 
I will hire someone when the time is right. In the meantime I am using assets from 
talented artists, details below.

- Player character is by https://zegley.itch.io/ - check his page for this asset [here](https://zegley.itch.io/2d-platformermetroidvania-asset-pack)
- Level assets by Kenney http://support.kenney.nl - modified slightly
