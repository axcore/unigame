---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decoblocks
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_marble_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.decoblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_marble_red.init()

    return {
        description = "Red marble",
        notes = "The textures from the original mod have been tweaked, so that we don't have" ..
                " quite so many white-ish marbles",
    }

end

function unilib.pkg.stone_marble_red.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "marble_red",
        description = S("Red Marble"),

        category = "metamorphic",
        colour = "#F6DEE1",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 3)
        hardness = 1,
        hardness_real = 3,
    })

    local smooth_cracky, block_cracky = unilib.stone.get_adjusted_cracky("marble_red", 3, nil)

    unilib.register_node("unilib:stone_marble_red", "default:white_marble", mode, {
        -- From decoblocks, default:white_marble
        description = S("Red Marble"),
        tiles = {"unilib_stone_marble_red.png"},
        -- N.B. marble = 1, smoothstone = 1 not in original code
        groups = {cracky = smooth_cracky, marble = 1, smoothstone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,
    })
    unilib.register_stone_smooth_cuttings({
        part_name = "marble_red",
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_marble_red_block
        part_name = "marble_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Marble Block"),
        img_list = {"unilib_stone_marble_red.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_marble_red_brick
        part_name = "marble_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Marble Bricks"),
        img_list = {"unilib_stone_marble_red.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble_or_rubble_or_nothing({
        -- Original to unilib. Depending on real hardness, creates unilib:stone_marble_red_cobble,
        --      or unilib:stone_marble_red_rubble, or nothing
        part_name = "marble_red",
        cobble_description = S("Red Marble Cobble"),
        cobble_compressed_description = S("Compressed Red Marble Cobble"),
        cobble_condensed_description = S("Condensed Red Marble Cobble"),
        rubble_description = S("Red Marble Rubble"),
        rubble_compressed_description = S("Compressed Red Marble Rubble"),
        rubble_condensed_description = S("Condensed Red Marble Rubble"),
        smooth_compressed_description = S("Compressed Red Marble"),
        smooth_condensed_description = S("Condensed Red Marble"),

        replace_mode = mode,
        override_drop_flag = true,
    })

end
