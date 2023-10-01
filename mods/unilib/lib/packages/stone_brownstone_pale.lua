---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decoblocks
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_brownstone_pale = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.decoblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_brownstone_pale.init()

    return {
        description = "Pale brownstone",
    }

end

function unilib.pkg.stone_brownstone_pale.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "brownstone_pale",
        description = S("Pale Brownstone"),

        category = "sedimentary",
        grinder_flag = true,
        -- (N.B. This is not a fictional stone)
        hardness = 1,
    })

    unilib.register_node("unilib:stone_brownstone_pale", "default:brownstone", mode, {
        -- From decoblocks, default:brownstone
        description = S("Pale Brownstone"),
        tiles = {"unilib_stone_brownstone_pale.png"},
        -- N.B. smoothstone = 1 not in original code
        groups = {cracky = 3, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        -- N.B. drop not in original code
        drop = "unilib:stone_brownstone_pale_rubble",
    })
    unilib.register_stone_smooth_cuttings({
        part_name = "brownstone_pale",

        drop_name = "unilib:stone_brownstone_pale_rubble",
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_brownstone_pale_block
        part_name = "brownstone_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Brownstone Block"),
        img_list = {"unilib_stone_brownstone_pale.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_brownstone_pale_brick
        part_name = "brownstone_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Brownstone Bricks"),
        img_list = {"unilib_stone_brownstone_pale.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_rubble({
        -- Original to unilib. Creates unilib:stone_brownstone_pale_rubble
        part_name = "brownstone_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Brownstone Rubble"),
        img_list = {"unilib_stone_brownstone_pale.png^unilib_stone_rubble_overlay.png"},
    })

end
