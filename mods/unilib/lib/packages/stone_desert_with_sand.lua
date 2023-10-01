---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_desert_with_sand = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_desert_with_sand.init()

    return {
        description = "Desert Stone with Sand",
    }

end

function unilib.pkg.stone_desert_with_sand.exec()

    unilib.register_node(
        -- From GLEMr4, lib_materials:sand_with_stone_desert
        "unilib:stone_desert_with_sand",
        "lib_materials:sand_with_stone_desert",
        mode,
        {
            description = S("Desert Stone with Sand"),
            tiles = {
                "unilib_stone_desert.png^(unilib_sand_desert.png^[mask:unilib_mask_stone.png)",
            },
            groups = {cracky = 3, stone = 2},
            -- N.B. sounds missing in original code
            sounds = unilib.sound_table.stone,
        }
    )

end
