---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_desert_with_cracks = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_desert_with_cracks.init()

    return {
        description = "Desert stone with cracks",
    }

end

function unilib.pkg.stone_desert_with_cracks.exec()

    unilib.register_node(
        -- From GLEMr4, lib_materials:cobble_stone_desert_default
        "unilib:stone_desert_with_cracks",
        "lib_materials:cobble_stone_desert_default",
        mode,
        {
            description = S("Desert Stone with Cracks"),
            tiles = {
                "unilib_stone_desert.png^" ..
                        "(unilib_stone_ordinary_cobble.png^[mask:unilib_mask_stone_cobble.png)",
            },
            groups = {cracky = 3, stone = 2},
            -- N.B. sounds missing in original code
            sounds = unilib.sound_table.stone,
        }
    )

end
