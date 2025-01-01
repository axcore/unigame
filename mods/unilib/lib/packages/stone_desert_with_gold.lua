---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_desert_with_gold = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_desert_with_gold.init()

    return {
        description = "Desert stone with gold as ore",
        depends = {"metal_gold", "stone_desert"},
    }

end

function unilib.pkg.stone_desert_with_gold.exec()

    unilib.register_node("unilib:stone_desert_with_gold", nil, mode, {
        -- Original to unilib
        description = unilib.utils.brackets(S("Gold Ore"), S("Desert Stone")),
        tiles = {"unilib_stone_desert.png^unilib_metal_gold.png"},
        groups = {cracky = 3, ore = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:metal_gold_lump",
    })

end
