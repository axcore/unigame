---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_marble_brown = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_marble_brown.init()

    return {
        description = "Brown marble",
    }

end

function unilib.pkg.stone_marble_brown.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "marble_brown",
        description = S("Brown Marble"),

        category = "metamorphic",
        colour = "#C0A180",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 3)
        hardness = 1,
        hardness_real = 3,
    })

    local smooth_cracky, block_cracky = unilib.stone.get_adjusted_cracky("marble_brown", 3, nil)

    unilib.register_node("unilib:stone_marble_brown", "technic:marble", mode, {
        -- From technic:marble
        description = S("Brown Marble"),
        tiles = {"unilib_stone_marble_brown.png"},
        -- N.B. smoothstone = 1, stone = 1 not in original code
        groups = {cracky = smooth_cracky, marble = 1, smoothstone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,
    })
    unilib.register_stone_smooth_cuttings({
        part_name = "marble_brown",
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_marble_brown_block
        part_name = "marble_brown",
        orig_name = nil,

        replace_mode = mode,
        description = S("Brown Marble Block"),
        img_list = {"unilib_stone_marble_brown.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_node("unilib:stone_marble_brown_brick", "technic:marble_bricks", mode, {
        -- From technic:marble_bricks
        description = S("Brown Marble Bricks"),
        tiles = {"unilib_stone_marble_brown_brick.png"},
        -- N.B. stone = 1, stonebrick = 1 not in original code
        groups = {cracky = 3, stone = 1, stonebrick = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other stones
        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From technic:marble_bricks
        output = "unilib:stone_marble_brown_brick",
        ingredient = "unilib:stone_marble_brown",
    })
    unilib.register_stone_brick_cuttings({
        part_name = "marble_brown",
    })
    unilib.utils.set_auto_rotate(
        "unilib:stone_marble_brown_brick", unilib.setting.auto_rotate_brick_flag
    )

    unilib.register_stone_cobble_or_rubble_or_nothing({
        -- Original to unilib. Depending on real hardness, creates unilib:stone_marble_brown_cobble,
        --      or unilib:stone_marble_brown_rubble, or nothing
        part_name = "marble_brown",
        cobble_description = S("Brown Marble Cobble"),
        cobble_compressed_description = S("Compressed Brown Marble Cobble"),
        cobble_condensed_description = S("Condensed Brown Marble Cobble"),
        rubble_description = S("Brown Marble Rubble"),
        rubble_compressed_description = S("Compressed Brown Marble Rubble"),
        rubble_condensed_description = S("Condensed Brown Marble Rubble"),
        smooth_compressed_description = S("Compressed Brown Marble"),
        smooth_condensed_description = S("Condensed Brown Marble"),

        replace_mode = mode,
        override_drop_flag = true,
    })

end
