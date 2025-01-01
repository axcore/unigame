---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_basalt_black = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_basalt_black.init()

    return {
        description = "Black basalt",
    }

end

function unilib.pkg.stone_basalt_black.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "basalt_black",
        description = S("Black Basalt"),

        category = "extrusive",
        colour = "#393937",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 3)
        hardness = 2,
        hardness_real = 3,
    })

    local smooth_cracky, block_cracky = unilib.stone.get_adjusted_cracky("basalt_black", 2, 2)

    unilib.register_node("unilib:stone_basalt_black", "aotearoa:basalt", mode, {
        -- From aotearoa:basalt
        description = S("Black Basalt"),
        tiles = {"unilib_stone_basalt_black.png"},
        -- N.B. smoothstone = 1 not in original code
        groups = {cracky = smooth_cracky, smoothstone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. drops smoothstone in original code
    })
    --[[
    unilib.register_stairs("unilib:stone_basalt_black", {
        basic_flag = true,
        drop_name = "unilib:stone_basalt_black_cobble",
        group_type = "smooth",
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "basalt_black",
    })

    unilib.register_node("unilib:stone_basalt_black_block", "aotearoa:basalt_block", mode, {
        -- From aotearoa:basalt_block
        description = S("Black Basalt Block"),
        tiles = {"unilib_stone_basalt_black_block.png"},
        -- N.B. stoneblock = 1 not in original code
        groups = {cracky = block_cracky, stone = 1, stoneblock = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other stones
        is_ground_content = false,
    })
    unilib.register_craft_3x3x9({
        -- From aotearoa:basalt_block
        output = "unilib:stone_basalt_black_block",
        ingredient = "unilib:stone_basalt_black",
    })
    --[[
    unilib.register_stairs("unilib:stone_basalt_black_block", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "basalt_black",
    })

    unilib.register_node("unilib:stone_basalt_black_brick", "aotearoa:basaltbrick", mode, {
        -- From aotearoa:basaltbrick
        description = S("Black Basalt Bricks"),
        tiles = {"unilib_stone_basalt_black_brick.png"},
        -- N.B. stonebrick = 1 not in original code
        groups = {cracky = 2, stone = 1, stonebrick = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other stones
        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From aotearoa:basaltbrick
        output = "unilib:stone_basalt_black_brick",
        ingredient = "unilib:stone_basalt_black",
    })
    --[[
    unilib.register_stairs("unilib:stone_basalt_black_brick", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "basalt_black",
    })
    unilib.utils.set_auto_rotate(
        "unilib:stone_basalt_black_brick", unilib.setting.auto_rotate_brick_flag
    )

    unilib.register_stone_cobble_or_rubble_or_nothing({
        -- Original to unilib. Depending on real hardness, creates unilib:stone_basalt_black_cobble,
        --      or unilib:stone_basalt_black_rubble, or nothing
        part_name = "basalt_black",
        cobble_description = S("Black Basalt Cobble"),
        cobble_compressed_description = S("Compressed Black Basalt Cobble"),
        cobble_condensed_description = S("Condensed Black Basalt Cobble"),
        rubble_description = S("Black Basalt Rubble"),
        rubble_compressed_description = S("Compressed Black Basalt Rubble"),
        rubble_condensed_description = S("Condensed Black Basalt Rubble"),
        smooth_compressed_description = S("Compressed Black Basalt"),
        smooth_condensed_description = S("Condensed Black Basalt"),

        replace_mode = mode,
        override_drop_flag = true,
    })

end
