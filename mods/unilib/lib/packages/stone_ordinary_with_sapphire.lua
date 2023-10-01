---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_sapphire = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_sapphire.init()

    return {
        description = "Ordinary stone with sapphire as ore",
        depends = {"mineral_sapphire", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_sapphire.exec()

    unilib.register_node("unilib:stone_ordinary_with_sapphire", "underch:sapphire_ore", mode, {
        -- From underch:sapphire_ore
        description = unilib.brackets(S("Sapphire Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_sapphire.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_sapphire_gem",
    })

end
