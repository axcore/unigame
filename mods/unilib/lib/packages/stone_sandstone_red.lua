---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_red.init()

    return {
        description = "Red sandstone",
        optional = "sand_red",
    }

end

function unilib.pkg.stone_sandstone_red.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_red",
        description = S("Red Sandstone"),

        category = "sedimentary",
        grinder_flag = true,
        grinder_powder = "unilib:sand_red",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, strongStone_redSandstone.png. Original code. Creates
        --      unilib:stone_sandstone_red
        part_name = "sandstone_red",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "smooth",
        description = S("Red Sandstone"),
    })
    unilib.register_craft_2x2({
        -- Original to unilib
        output = "unilib:stone_sandstone_red",
        ingredient = "unilib:sand_red",
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:sand_red 4",
        recipe = {
            {"unilib:stone_sandstone_red"},
        }
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_sandstone_red_block
        part_name = "sandstone_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Sandstone Block"),
        img_list = {"unilib_stone_sandstone_red.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_sandstone_red_brick
        part_name = "sandstone_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Sandstone Bricks"),
        img_list = {"unilib_stone_sandstone_red.png^unilib_stone_brick_overlay.png"},
    })

end
