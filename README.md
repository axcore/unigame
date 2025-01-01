# unigame

![unigame screenshot](screenshot.png)

[unigame](https://github.com/axcore/unigame) is a minimal base game for [Minetest](https://www.minetest.net/)-compatible engines, including Luanti.

It is based on [minetest_game](https://github.com/minetest/minetest_game), but with all nodes, craftitems, crafts, biomes, decorations and ores removed, leaving behind only essential functionality (most API functions, player physics, a basic inventory mod, and so on).

The removed items can now be found in the [unilib mod](https://github.com/axcore/unilib), which is included. If you just want the minimal base game, then you can remove that mod. Otherwise, **unigame** is a fully-featured voxel experience, ready to play!

## Game details

Both **unigame** and **unilib** are in the BETA RELEASE phase. They are both fully playable, but have not been play tested.

**unilib** is highly configurable. Please see its [README](/mods/unilib/README.md).

## Technical details

### minetest_game mods

Mods that have been copied from [minetest_game](https://github.com/minetest/minetest_game), unaltered:

**bones**

**creative**

**env_sounds**

**game_commands**

**player_api**

**sethome**

**sfinv**

**spawn**

**weather**

Mods that have been copied from [minetest_game](https://github.com/minetest/minetest_game), with minor changes (marked with **@@@**):

**dungeon_loot** - Loot from **default** (which is declared in this mod, and not in **default** itself) has been removed. The corresponding items are declared as loot inside **unilib** itself. Loot from other [minetest_game](https://github.com/minetest/minetest_game) mods were declared in those mods; again, corresponding items are declared as loot inside **unilib** itself. Removed the dependence on **default**'s chest, adding an optional dependence on **unilib**'s ordinary chest.

**give_initial_stuff** - Removed the items from **default**, replacing them with the corresponding items from **unilib**. Removed the dependence of **default**, replacing it with an optional dependence on **unilib**

**mtg_craftguide** - Changed the "stereotypes" to the corresponding nodes/craftitems in **unilib**. No changes to mod.conf

Mods that have been copied from [minetest_game](https://github.com/minetest/minetest_game), with most items removed, but with some items retained because the "technic", "pipeworks" and "techage" mods require them (marked with **@@@**):

**bucket**

**carts**

**default**

**fire**

Mods that have been copied from [minetest_game](https://github.com/minetest/minetest_game), with all almost all items removed (sometimes leaving a mod with no content at all) (changes not marked with **@@@):**

**beds**

**binoculars**

**boats**

**butterflies**

**doors**

**dye**

**farming**

**fireflies**

**flowers**

**keys**

**map**

**screwdriver**

**stairs**

**tnt**

**vessels**

**walls**

**wool**

**xpanes**

### Original mods

[unilib](https://github.com/axcore/unilib)

### Other mods

The entire contents of these mods have already been imported into **unilib**. These modified versions of the original mods are almost empty, so that other mods that depend on them will run.

[basic_materials](https://content.minetest.net/packages/mt-mods/basic_materials/)

[moreores](https://github.com/minetest-mods/moreores)

