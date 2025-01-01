---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_aquamarine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_aquamarine.init()

    return {
        description = "Ordinary stone with aquamarine as ore",
        depends = {"mineral_aquamarine", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_aquamarine.exec()

    unilib.register_node("unilib:stone_ordinary_with_aquamarine", "underch:aquamarine_ore", mode, {
        -- From underch:aquamarine_ore
        description = unilib.utils.brackets(S("Aquamarine Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_aquamarine.png"},
        -- N.B. ore = 1 not in original code
        groups = {cracky = 2, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:mineral_aquamarine_crystal",
    })

end
