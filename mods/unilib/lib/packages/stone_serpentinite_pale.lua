---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decoblocks
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_serpentinite_pale = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.decoblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_serpentinite_pale.init()

    return {
        description = "Pale serpentinite",
    }

end

function unilib.pkg.stone_serpentinite_pale.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "serpentinite_pale",
        description = S("Pale Serpentinite"),

        category = "metamorphic",
        colour = "#90A890",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 2)
        hardness = 1,
        hardness_real = 2,
    })

    local smooth_cracky, block_cracky =
            unilib.stone.get_adjusted_cracky("serpentinite_pale", 3, nil)

    unilib.register_node("unilib:stone_serpentinite_pale", "default:serpentinite", mode, {
        -- From decoblocks, default:serpentinite
        description = S("Pale Serpentinite"),
        tiles = {"unilib_stone_serpentinite_pale.png"},
        -- N.B. smoothstone = 1 not in original code
        groups = {cracky = smooth_cracky, smoothstone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,
    })
    unilib.register_stone_smooth_cuttings({
        part_name = "serpentinite_pale",
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_serpentinite_pale_block
        part_name = "serpentinite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Serpentinite Block"),
        img_list = {"unilib_stone_serpentinite_pale.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_serpentinite_pale_brick
        part_name = "serpentinite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Serpentinite Bricks"),
        img_list = {"unilib_stone_serpentinite_pale.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble_or_rubble_or_nothing({
        -- Original to unilib. Depending on real hardness, creates
        --      unilib:stone_serpentinite_pale_cobble, or unilib:stone_serpentinite_pale_rubble, or
        --      nothing
        part_name = "serpentinite_pale",
        cobble_description = S("Pale Serpentinite Cobble"),
        cobble_compressed_description = S("Compressed Pale Serpentinite Cobble"),
        cobble_condensed_description = S("Condensed Pale Serpentinite Cobble"),
        rubble_description = S("Pale Serpentinite Rubble"),
        rubble_compressed_description = S("Compressed Pale Serpentinite Rubble"),
        rubble_condensed_description = S("Condensed Pale Serpentinite Rubble"),
        smooth_compressed_description = S("Compressed Pale Serpentinite"),
        smooth_condensed_description = S("Condensed Pale Serpentinite"),

        replace_mode = mode,
        override_drop_flag = true,
    })

end
