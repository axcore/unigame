---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_limestone_white = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_limestone_white.init()

    return {
        description = "White limestone",
    }

end

function unilib.pkg.stone_limestone_white.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "limestone_white",
        description = S("White Limestone"),

        category = "sedimentary",
        grinder_flag = true,
        hardness = 1,
    })

    unilib.register_node("unilib:stone_limestone_white", "mapgen:limestone", mode, {
        -- From farlands, mapgen:limestone
        description = S("White Limestone"),
        tiles = {"unilib_stone_limestone_white.png"},
        -- N.B. limestone = 1, smoothstone = 1 not in original code
        groups = {cracky = 3, limestone = 1, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        -- N.B. drop not in original code
        drop = "unilib:stone_limestone_white_rubble",
    })
    unilib.register_stone_smooth_cuttings({
        part_name = "limestone_white",

        drop_name = "unilib:stone_limestone_white_rubble",
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_limestone_white_block
        part_name = "limestone_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Limestone Block"),
        img_list = {"unilib_stone_limestone_white.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_limestone_white_brick
        part_name = "limestone_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Limestone Bricks"),
        img_list = {"unilib_stone_limestone_white.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_rubble({
        -- Original to unilib. Creates unilib:stone_limestone_white_rubble
        part_name = "limestone_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Limestone Rubble"),
        img_list = {"unilib_stone_limestone_white.png^unilib_stone_rubble_overlay.png"},
    })

end
