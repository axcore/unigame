---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_brownstone_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_brownstone_dark.init()

    return {
        description = "Dark brownstone",
    }

end

function unilib.pkg.stone_brownstone_dark.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "brownstone_dark",
        description = S("Dark Brownstone"),

        category = "sedimentary",
        grinder_flag = true,
        -- (N.B. This is not a fictional stone)
        hardness = 1,
    })

    unilib.register_node("unilib:stone_brownstone_dark", "lib_materials:stone_brown", mode, {
        -- From GLEMr4, lib_materials:stone_brown
        description = S("Dark Brownstone"),
        tiles = {"unilib_stone_brownstone_dark.png"},
        -- N.B. smoothstone = 1 not in original code
        groups = {cracky = 3, level = 2, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        -- N.B. drop not in original code
        drop = "unilib:stone_brownstone_dark_rubble",
    })
    unilib.register_stone_smooth_cuttings({
        part_name = "brownstone_dark",

        drop_name = "unilib:stone_brownstone_dark_rubble",
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_brownstone_dark_block
        part_name = "brownstone_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Brownstone Block"),
        img_list = {"unilib_stone_brownstone_dark.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_brownstone_dark_brick
        part_name = "brownstone_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Brownstone Bricks"),
        img_list = {"unilib_stone_brownstone_dark.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_rubble({
        -- Original to unilib. Creates unilib:stone_brownstone_dark_rubble
        part_name = "brownstone_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Brownstone Rubble"),
        img_list = {"unilib_stone_brownstone_dark.png^unilib_stone_rubble_overlay.png"},
    })

end
