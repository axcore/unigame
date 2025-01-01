---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_granite_antipodean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_granite_antipodean.init()

    return {
        description = "Antipodean granite",
    }

end

function unilib.pkg.stone_granite_antipodean.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "granite_antipodean",
        description = S("Antipodean Granite"),

        category = "intrusive",
        colour = "#C19B7D",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 3/4)
        hardness = 3,
        hardness_real = 3,
    })

    unilib.register_node("unilib:stone_granite_antipodean", "aotearoa:granite", mode, {
        -- From aotearoa:granite
        description = S("Antipodean Granite"),
        tiles = {"unilib_stone_granite_antipodean.png"},
        -- N.B. granite = 1, smoothstone = 1 not in original code
        groups = {cracky = 1, granite = 1, smoothstone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. drops smoothstone in original code
        drop = "unilib:stone_granite_antipodean_cobble",
    })
    --[[
    unilib.register_stairs("unilib:stone_granite_antipodean", {
        basic_flag = true,
        drop_name = "unilib:stone_granite_antipodean_cobble",
        group_type = "smooth",
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "granite_antipodean",

        drop_name = "unilib:stone_granite_antipodean_cobble",
    })

    unilib.register_node("unilib:stone_granite_antipodean_block", "aotearoa:granite_block", mode, {
        -- From aotearoa:granite_block
        description = S("Antipodean Granite Block"),
        tiles = {"unilib_stone_granite_antipodean_block.png"},
        -- N.B. stoneblock = 1 not in original code
        groups = {cracky = 1, stone = 1, stoneblock = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other stones
        is_ground_content = false,
    })
    unilib.register_craft_3x3x9({
        -- From aotearoa:granite_block
        output = "unilib:stone_granite_antipodean_block",
        ingredient = "unilib:stone_granite_antipodean",
    })
    --[[
    unilib.register_stairs("unilib:stone_granite_antipodean_block", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "granite_antipodean",
    })

    unilib.register_node("unilib:stone_granite_antipodean_brick", "aotearoa:granitebrick", mode, {
        -- From aotearoa:granitebrick
        description = S("Antipodean Granite Bricks"),
        tiles = {"unilib_stone_granite_antipodean_brick.png"},
        -- N.B. stonebrick = 1 not in original code
        groups = {cracky = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other stones
        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From aotearoa:granitebrick
        output = "unilib:stone_granite_antipodean_brick",
        ingredient = "unilib:stone_granite_antipodean",
    })
    --[[
    unilib.register_stairs("unilib:stone_granite_antipodean_brick", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "granite_antipodean",
    })
    unilib.utils.set_auto_rotate(
        "unilib:stone_granite_antipodean_brick", unilib.setting.auto_rotate_brick_flag
    )

    unilib.register_stone_cobble({
        -- Original to unilib. Creates unilib:stone_granite_antipodean_cobble
        part_name = "granite_antipodean",
        orig_name = nil,

        replace_mode = mode,
        description = S("Antipodean Granite Cobble"),
        img_list = {"unilib_stone_granite_antipodean.png^unilib_stone_cobble_overlay.png"},
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_granite_antipodean_cobble_compressed
        part_name = "granite_antipodean",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Antipodean Granite Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_granite_antipodean_cobble_condensed
        part_name = "granite_antipodean",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Antipodean Granite Cobble"),
    })

end
