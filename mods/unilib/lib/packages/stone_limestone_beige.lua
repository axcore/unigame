---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_limestone_beige = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_limestone_beige.init()

    return {
        description = "Beige limestone",
    }

end

function unilib.pkg.stone_limestone_beige.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "limestone_beige",
        description = S("Beige Limestone"),

        category = "sedimentary",
        grinder_flag = true,
        hardness = 1,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, limestone.png. Original code. Creates unilib:stone_limestone_beige
        part_name = "limestone_beige",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "rubble",
        description = S("Beige Limestone"),
        -- N.B. limestone = 1 not in original code
        group_table = {limestone = 1},
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_limestone_beige_block
        part_name = "limestone_beige",
        orig_name = nil,

        replace_mode = mode,
        description = S("Beige Limestone Block"),
        img_list = {"unilib_stone_limestone_beige.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_limestone_beige_brick
        part_name = "limestone_beige",
        orig_name = nil,

        replace_mode = mode,
        description = S("Beige Limestone Bricks"),
        img_list = {"unilib_stone_limestone_beige.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_rubble({
        -- Original to unilib. Creates unilib:stone_limestone_beige_rubble
        part_name = "limestone_beige",
        orig_name = nil,

        replace_mode = mode,
        description = S("Beige Limestone Rubble"),
        img_list = {"unilib_stone_limestone_beige.png^unilib_stone_rubble_overlay.png"},
    })

end
