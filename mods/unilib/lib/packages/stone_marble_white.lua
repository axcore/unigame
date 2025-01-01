---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_marble_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_marble_white.init()

    return {
        description = "White marble",
    }

end

function unilib.pkg.stone_marble_white.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "marble_white",
        description = S("White Marble"),

        category = "metamorphic",
        colour = "#F1EDF7",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 3)
        hardness = 1,
        hardness_real = 3,
    })

    local smooth_cracky, block_cracky = unilib.stone.get_adjusted_cracky("marble_white", 3, nil)

    unilib.register_node("unilib:stone_marble_white", "mapgen:marble", mode, {
        -- From farlands, mapgen:marble
        description = S("White Marble"),
        tiles = {"unilib_stone_marble_white.png"},
        -- N.B. marble = 1, smoothstone = 1 not in original code
        groups = {cracky = smooth_cracky, marble = 1, smoothstone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. drop not in original code
    })
    unilib.register_stone_smooth_cuttings({
        part_name = "marble_white",
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_marble_white_block
        part_name = "marble_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Marble Block"),
        img_list = {"unilib_stone_marble_white.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_marble_white_brick
        part_name = "marble_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Marble Bricks"),
        img_list = {"unilib_stone_marble_white.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble_or_rubble_or_nothing({
        -- Original to unilib. Depending on real hardness, creates
        --      unilib:stone_marble_white_cobble, or unilib:stone_marble_white_rubble, or nothing
        part_name = "marble_white",
        cobble_description = S("White Marble Cobble"),
        cobble_compressed_description = S("Compressed White Marble Cobble"),
        cobble_condensed_description = S("Condensed White Marble Cobble"),
        rubble_description = S("White Marble Rubble"),
        rubble_compressed_description = S("Compressed White Marble Rubble"),
        rubble_condensed_description = S("Condensed White Marble Rubble"),
        smooth_compressed_description = S("Compressed White Marble"),
        smooth_condensed_description = S("Condensed White Marble"),

        replace_mode = mode,
        override_drop_flag = true,
    })

end
