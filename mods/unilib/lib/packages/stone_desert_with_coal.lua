---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_desert_with_coal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_desert_with_coal.init()

    return {
        description = "Desert stone with coal as ore",
        depends = {"mineral_coal", "stone_desert"},
    }

end

function unilib.pkg.stone_desert_with_coal.exec()

    unilib.register_node("unilib:stone_desert_with_coal", nil, mode, {
        -- Original to unilib
        description = unilib.utils.brackets(S("Coal Ore"), S("Desert Stone")),
        tiles = {"unilib_stone_desert.png^unilib_mineral_coal.png"},
        groups = {cracky = 3, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:mineral_coal_lump",
    })

end
