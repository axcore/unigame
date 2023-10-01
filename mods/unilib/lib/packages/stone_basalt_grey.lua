---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decoblocks
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_basalt_grey = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.decoblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_basalt_grey.init()

    return {
        description = "Grey basalt",
    }

end

function unilib.pkg.stone_basalt_grey.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "basalt_grey",
        description = S("Grey Basalt"),

        category = "extrusive",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 3)
        hardness = 1,
        hardness_real = 3,
    })

    local smooth_cracky, block_cracky = unilib.get_adjusted_cracky("basalt_grey", 3, nil)

    unilib.register_node("unilib:stone_basalt_grey", "default:black_basalt", mode, {
        -- From default:black_basalt
        description = S("Grey Basalt"),
        tiles = {"unilib_stone_basalt_grey.png"},
        -- N.B. smoothstone = 1 not in original code
        groups = {cracky = smooth_cracky, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,
    })
    unilib.register_stone_smooth_cuttings({
        part_name = "basalt_grey",
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_basalt_grey_block
        part_name = "basalt_grey",
        orig_name = nil,

        replace_mode = mode,
        description = S("Grey Basalt Block"),
        img_list = {"unilib_stone_basalt_grey.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_basalt_grey_brick
        part_name = "basalt_grey",
        orig_name = nil,

        replace_mode = mode,
        description = S("Grey Basalt Bricks"),
        img_list = {"unilib_stone_basalt_grey.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble_or_rubble_or_nothing({
        -- Original to unilib. Depending on real hardness, creates unilib:stone_basalt_grey_cobble,
        --      or unilib:stone_basalt_grey_rubble, or nothing
        part_name = "basalt_grey",
        cobble_description = S("Grey Basalt Cobble"),
        rubble_description = S("Grey Basalt Rubble"),

        replace_mode = mode,
        override_drop_flag = true,
    })

end
