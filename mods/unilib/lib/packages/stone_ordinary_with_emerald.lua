---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_emerald = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_emerald.init()

    return {
        description = "Ordinary stone with emerald as ore",
        depends = {"mineral_emerald", "stone_ordinary"},
    }

end

function unilib.pkg.stone_ordinary_with_emerald.exec()

    unilib.register_node("unilib:stone_ordinary_with_emerald", "underch:emerald_ore", mode, {
        -- From underch:emerald_ore
        description = unilib.brackets(S("Emerald Ore"), S("Ordinary Stone")),
        tiles = {"unilib_stone_ordinary.png^unilib_mineral_emerald.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_emerald_gem",
    })

end
