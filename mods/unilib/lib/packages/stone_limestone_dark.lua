---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decoblocks
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_limestone_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.decoblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_limestone_dark.init()

    return {
        description = "Dark limestone",
    }

end

function unilib.pkg.stone_limestone_dark.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "limestone_dark",
        description = S("Dark Limestone"),

        category = "sedimentary",
        grinder_flag = true,
        hardness = 1,
    })

    -- N.B. orig_name omitted to prevent Minetest alias warning
    unilib.register_node("unilib:stone_limestone_dark", nil, mode, {
        -- From decoblocks, default:stone
        description = S("Dark Limestone"),
        tiles = {"unilib_stone_limestone_dark.png"},
        -- N.B. limestone = 1, smoothstone = 1 not in original code
        groups = {cracky = 3, limestone = 1, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        -- N.B. drop not in original code
        drop = "unilib:stone_limestone_dark_rubble",
    })
    unilib.register_stone_smooth_cuttings({
        part_name = "limestone_dark",

        drop_name = "unilib:stone_limestone_dark_rubble",
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_limestone_dark_block
        part_name = "limestone_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Limestone Block"),
        img_list = {"unilib_stone_limestone_dark.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_limestone_dark_brick
        part_name = "limestone_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Limestone Bricks"),
        img_list = {"unilib_stone_limestone_dark.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_rubble({
        -- Original to unilib. Creates unilib:stone_limestone_dark_rubble
        part_name = "limestone_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Limestone Rubble"),
        img_list = {"unilib_stone_limestone_dark.png^unilib_stone_rubble_overlay.png"},
    })

end
