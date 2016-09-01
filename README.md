# TerraBattle-Toolkit

For Terra Battle game

This is originally developed for [AutoTouch](https://autotouch.net/) and compatible with [TouchElf](http://www.touchelf.com/) (See below)

**I am testing this only on my iPhone5 and there are still many issues, so unfortunately it is likely NOT working on your device... (Please try to edit some values in action_builder.lua to make it work)**

# Basic Usage:
require tb-utils at the first line
```lua
require "tb-utils"
```
You can use the roll() method to make a sequence of moves
e.g.
```lua
roll(r0,c0,r1,c1,r2,c2,...,rn,cn)
```
where r0,c0 is the character's initial position in (row, column)

# For TouchElf
add default path to package path BEFORE require "tb-utils"

e.g.
```lua
package.path=package.path .. ";/mnt/sdcard/touchelf/scripts/?.lua"
require "tb-utils"
```

