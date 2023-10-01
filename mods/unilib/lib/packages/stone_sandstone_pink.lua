---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_pink = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_pink.init()

    return {
        description = "Pink sandstone",
        optional = "sand_pink",
    }

end

function unilib.pkg.stone_sandstone_pink.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_pink",
        description = S("Pink Sandstone"),

        category = "sedimentary",
        grinder_flag = true,
        grinder_powder = "unilib:sand_pink",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, strongStone_sandstone.png. Original code. Creates
        --      unilib:stone_sandstone_pink
        part_name = "sandstone_pink",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "smooth",
        description = S("Pink Sandstone"),
    })
    unilib.register_craft_2x2({
        -- Original to unilib
        output = "unilib:stone_sandstone_pink",
        ingredient = "unilib:sand_pink",
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:sand_pink 4",
        recipe = {
            {"unilib:stone_sandstone_pink"},
        }
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_sandstone_pink_block
        part_name = "sandstone_pink",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pink Sandstone Block"),
        img_list = {"unilib_stone_sandstone_pink.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_sandstone_pink_brick
        part_name = "sandstone_pink",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pink Sandstone Bricks"),
        img_list = {"unilib_stone_sandstone_pink.png^unilib_stone_brick_overlay.png"},
    })

end
