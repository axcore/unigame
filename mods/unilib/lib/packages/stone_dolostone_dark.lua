---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_dolostone_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_dolostone_dark.init()

    return {
        description = "Dark dolostone",
    }

end

function unilib.pkg.stone_dolostone_dark.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "dolostone_dark",
        description = S("Dark Dolostone"),

        category = "sedimentary",
        grinder_flag = true,
        hardness = 1,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, dolomite.png. Original code. Creates unilib:stone_dolostone_dark
        part_name = "dolostone_dark",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "rubble",
        description = S("Dark Dolostone"),
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_dolostone_dark_block
        part_name = "dolostone_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Dolostone Block"),
        img_list = {"unilib_stone_dolostone_dark.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_dolostone_dark_brick
        part_name = "dolostone_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Dolostone Bricks"),
        img_list = {"unilib_stone_dolostone_dark.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_rubble({
        -- Original to unilib. Creates unilib:stone_dolostone_dark_rubble
        part_name = "dolostone_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Dolostone Rubble"),
        img_list = {"unilib_stone_dolostone_dark.png^unilib_stone_rubble_overlay.png"},
    })

end
