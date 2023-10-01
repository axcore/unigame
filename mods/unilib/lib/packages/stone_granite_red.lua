---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decoblocks
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_granite_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.decoblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_granite_red.init()

    return {
        description = "Red granite",
    }

end

function unilib.pkg.stone_granite_red.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "granite_red",
        description = S("Red Granite"),

        category = "intrusive",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 3/4)
        hardness = 1,
        hardness_real = 3,
    })

    local smooth_cracky, block_cracky = unilib.get_adjusted_cracky("granite_red", 3, nil)

    unilib.register_node("unilib:stone_granite_red", "default:pink_granite", mode, {
        -- From decoblocks, default:pink_granite
        description = S("Red Granite"),
        tiles = {"unilib_stone_granite_red.png"},
        -- N.B. granite = 1, smoothstone = 1 not in original code
        groups = {cracky = smooth_cracky, granite = 1, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,
    })
    unilib.register_stone_smooth_cuttings({
        part_name = "granite_red",
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_granite_red_block
        part_name = "granite_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Granite Block"),
        img_list = {"unilib_stone_granite_red.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_granite_red_brick
        part_name = "granite_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Granite Bricks"),
        img_list = {"unilib_stone_granite_red.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble_or_rubble_or_nothing({
        -- Original to unilib. Depending on real hardness, creates unilib:stone_granite_red_cobble,
        --      or unilib:stone_granite_red_rubble, or nothing
        part_name = "granite_red",
        cobble_description = S("Red Granite Cobble"),
        rubble_description = S("Red Granite Rubble"),

        replace_mode = mode,
        override_drop_flag = true,
    })

end
