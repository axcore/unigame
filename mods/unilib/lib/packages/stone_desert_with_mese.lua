---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_desert_with_mese = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_desert_with_mese.init()

    return {
        description = "Desert stone with mese as ore",
        depends = {"mineral_mese", "stone_desert"},
    }

end

function unilib.pkg.stone_desert_with_mese.exec()

    unilib.register_node("unilib:stone_desert_with_mese", nil, mode, {
        -- Original to unilib
        description = unilib.brackets(S("Mese Ore"), S("Desert Stone")),
        tiles = {"unilib_stone_desert.png^unilib_mineral_mese.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,

        drop = "unilib:mineral_mese_crystal",
    })

end
