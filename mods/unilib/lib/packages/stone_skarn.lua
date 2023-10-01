---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_skarn = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_skarn.init()

    return {
        description = "Skarn",
    }

end

function unilib.pkg.stone_skarn.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "skarn",
        description = S("Skarn"),

        category = "metamorphic",
        grinder_flag = true,
        hardness = 2,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, mediumStone_skarn.png. Original code. Creates unilib:stone_skarn
        part_name = "skarn",
        orig_name = nil,

        replace_mode = mode,
        description = S("Skarn"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_skarn_block
        part_name = "skarn",
        orig_name = nil,

        replace_mode = mode,
        description = S("Skarn Block"),
        img_list = {"unilib_stone_skarn.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_skarn_brick
        part_name = "skarn",
        orig_name = nil,

        replace_mode = mode,
        description = S("Skarn Bricks"),
        img_list = {"unilib_stone_skarn.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_skarn_cobble
        part_name = "skarn",
        orig_name = nil,

        replace_mode = mode,
        description = S("Skarn Cobble"),
        img_list = {"unilib_stone_skarn.png^unilib_stone_cobble_overlay.png"},
    })

end
