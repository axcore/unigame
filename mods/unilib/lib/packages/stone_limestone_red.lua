---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_limestone_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_limestone_red.init()

    return {
        description = "Red limestone",
    }

end

function unilib.pkg.stone_limestone_red.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "limestone_red",
        description = S("Red Limestone"),

        category = "sedimentary",
        grinder_flag = true,
        hardness = 1,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, mediumStone_limestone.png. Original code. Creates
        --      unilib:stone_limestone_red
        part_name = "limestone_red",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "rubble",
        description = S("Red Limestone"),
        -- N.B. limestone = 1 not in original code
        group_table = {limestone = 1},
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_limestone_red_block
        part_name = "limestone_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Limestone Block"),
        img_list = {"unilib_stone_limestone_red.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_limestone_red_brick
        part_name = "limestone_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Limestone Bricks"),
        img_list = {"unilib_stone_limestone_red.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_rubble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_limestone_red_rubble
        part_name = "limestone_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Limestone Rubble"),
        img_list = {"unilib_stone_limestone_red.png^unilib_stone_rubble_overlay.png"},
    })

end
