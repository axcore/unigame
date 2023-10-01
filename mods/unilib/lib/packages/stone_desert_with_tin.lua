---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_desert_with_tin = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_desert_with_tin.init()

    return {
        description = "Desert stone with tin as ore",
        depends = {"metal_tin", "stone_desert"},
    }

end

function unilib.pkg.stone_desert_with_tin.exec()

    unilib.register_node("unilib:stone_desert_with_tin", nil, mode, {
        -- Original to unilib
        description = unilib.brackets(S("Tin Ore"), S("Desert Stone")),
        tiles = {"unilib_stone_desert.png^unilib_metal_tin.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,

        drop = "unilib:metal_tin_lump",
    })

end
