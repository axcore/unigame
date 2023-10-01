---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_laterite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_laterite.init()

    return {
        description = "Laterite",
    }

end

function unilib.pkg.stone_laterite.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "laterite",
        description = S("Laterite"),

        category = "clay_dirt",
        grinder_flag = true,
        hardness = 1,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, weakClay_laterite.png. Original code. Creates unilib:stone_laterite
        part_name = "laterite",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "rubble",
        description = S("Laterite"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_laterite_block
        part_name = "laterite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Laterite Block"),
        img_list = {"unilib_stone_laterite.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_laterite_brick
        part_name = "laterite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Laterite Bricks"),
        img_list = {"unilib_stone_laterite.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_rubble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_laterite_rubble
        part_name = "laterite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Laterite Rubble"),
        img_list = {"unilib_stone_laterite.png^unilib_stone_rubble_overlay.png"},
    })

end
