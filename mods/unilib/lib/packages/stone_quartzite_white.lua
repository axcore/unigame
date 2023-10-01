---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_quartzite_white = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_quartzite_white.init()

    return {
        description = "White quartzite",
    }

end

function unilib.pkg.stone_quartzite_white.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "quartzite_white",
        description = S("White Quartzite"),

        category = "metamorphic",
        grinder_flag = true,
        hardness = 4,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, veryStrongStone_quartzite.png. Original code. Creates
        --      unilib:stone_quartzite_white
        part_name = "quartzite_white",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "smooth",
        description = S("White Quartzite"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_quartzite_white_block
        part_name = "quartzite_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Quartzite Block"),
        img_list = {"unilib_stone_quartzite_white.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_quartzite_white_brick
        part_name = "quartzite_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Quartzite Bricks"),
        img_list = {"unilib_stone_quartzite_white.png^unilib_stone_brick_overlay.png"},
    })

end
