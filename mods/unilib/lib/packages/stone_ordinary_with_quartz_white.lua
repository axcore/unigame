---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_quartz_white = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_quartz_white.init()

    return {
        description = "Ordinary stone with white quartz as ore",
        depends = {"mineral_quartz_white", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_quartz_white.exec()

    unilib.register_node("unilib:stone_ordinary_with_quartz_white", "underch:quartz_ore", mode, {
        -- From underch:quartz_ore
        description = unilib.brackets(S("White Quartz Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_quartz_white.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_quartz_white_crystal",
    })

end
