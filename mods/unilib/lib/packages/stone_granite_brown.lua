---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decoblocks
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_granite_brown = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.decoblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_granite_brown.init()

    return {
        description = "Brown granite",
    }

end

function unilib.pkg.stone_granite_brown.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "granite_brown",
        description = S("Brown Granite"),

        category = "intrusive",
        colour = "#5E5046",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 3/4)
        hardness = 1,
        hardness_real = 3,
    })

    local smooth_cracky, block_cracky = unilib.stone.get_adjusted_cracky("granite_brown", 3, nil)

    unilib.register_node("unilib:stone_granite_brown", "default:brown_granite", mode, {
        -- From decoblocks, default:brown_granite
        description = S("Brown Granite"),
        tiles = {"unilib_stone_granite_brown.png"},
        -- N.B. granite = 1, smoothstone = 1 not in original code
        groups = {cracky = smooth_cracky, granite = 1, smoothstone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,
    })
    unilib.register_stone_smooth_cuttings({
        part_name = "granite_brown",
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_granite_brown_block
        part_name = "granite_brown",
        orig_name = nil,

        replace_mode = mode,
        description = S("Brown Granite Block"),
        img_list = {"unilib_stone_granite_brown.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_granite_brown_brick
        part_name = "granite_brown",
        orig_name = nil,

        replace_mode = mode,
        description = S("Brown Granite Bricks"),
        img_list = {"unilib_stone_granite_brown.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble_or_rubble_or_nothing({
        -- Original to unilib. Depending on real hardness, creates
        --      unilib:stone_granite_brown_cobble, or unilib:stone_granite_brown_rubble, or nothing
        part_name = "granite_brown",
        cobble_description = S("Brown Granite Cobble"),
        cobble_compressed_description = S("Compressed Brown Granite Cobble"),
        cobble_condensed_description = S("Condensed Brown Granite Cobble"),
        rubble_description = S("Brown Granite Rubble"),
        rubble_compressed_description = S("Compressed Brown Granite Rubble"),
        rubble_condensed_description = S("Condensed Brown Granite Rubble"),
        smooth_compressed_description = S("Compressed Brown Granite"),
        smooth_condensed_description = S("Condensed Brown Granite"),

        replace_mode = mode,
        override_drop_flag = true,
    })

end
