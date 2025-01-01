---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_claystone_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_claystone_white.init()

    return {
        description = "White claystone",
        optional = "clay_ordinary",
    }

end

function unilib.pkg.stone_claystone_white.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "claystone_white",
        description = S("White Claystone"),

        category = "sedimentary",
        colour = "#BFAE8E",
        grinder_flag = true,
        hardness = 1,
    })

    unilib.register_node("unilib:stone_claystone_white", "aotearoa:claystone", mode, {
        -- From aotearoa:claystone
        description = S("White Claystone"),
        tiles = {"unilib_stone_claystone_white.png"},
        -- N.B.  smoothstone = 1, stone = 1 not in original code
        groups = {cracky = 3, crumbly = 1, smoothstone = 1, soft_stone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. drops smoothstone in original code
        drop = "unilib:stone_claystone_white_rubble",
    })
    if unilib.global.pkg_executed_table["clay_ordinary"] ~= nil then

        unilib.register_craft_2x2({
            -- From aotearoa:claystone
            output = "unilib:stone_claystone_white",
            ingredient = "unilib:clay_ordinary",
        })
        unilib.register_craft({
            -- From aotearoa:claystone
            output = "unilib:clay_ordinary 4",
            recipe = {
                {"unilib:stone_claystone_white"},
            },
        })

    end
    --[[
    unilib.register_stairs("unilib:stone_claystone_white", {
        basic_flag = true,
        drop_name = "unilib:stone_claystone_white_rubble",
        group_type = "smooth",
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "claystone_white",

        drop_name = "unilib:stone_claystone_white_rubble",
    })

    unilib.register_node("unilib:stone_claystone_white_block", "aotearoa:claystone_block", mode, {
        -- From aotearoa:claystone_block
        description = S("White Claystone Block"),
        tiles = {"unilib_stone_claystone_white_block.png"},
        -- N.B. stone = 1, stoneblock = 1 not in original code
        groups = {cracky = 2, soft_stone = 1, stone = 1, stoneblock = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other stones
        is_ground_content = false,
    })
    unilib.register_craft_3x3x9({
        -- From aotearoa:claystone_block
        output = "unilib:stone_claystone_white_block",
        ingredient = "unilib:stone_claystone_white",
    })
    --[[
    unilib.register_stairs("unilib:stone_claystone_white_block", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "claystone_white",
    })

    unilib.register_node("unilib:stone_claystone_white_brick", "aotearoa:claystonebrick", mode, {
        -- From aotearoa:claystonebrick
        description = S("White Claystone Bricks"),
        tiles = {"unilib_stone_claystone_white_brick.png"},
        -- N.B. stone = 1, stonebrick = 1 not in original code
        groups = {cracky = 2, soft_stone = 1, stone = 1, stonebrick = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other stones
        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From aotearoa:claystonebrick
        output = "unilib:stone_claystone_white_brick",
        ingredient = "unilib:stone_claystone_white",
    })
    --[[
    unilib.register_stairs("unilib:stone_claystone_white_brick", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "claystone_white",
    })
    unilib.utils.set_auto_rotate(
        "unilib:stone_claystone_white_brick", unilib.setting.auto_rotate_brick_flag
    )

    unilib.register_stone_rubble({
        -- Original to unilib. Creates unilib:stone_claystone_white_rubble
        part_name = "claystone_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Claystone Rubble"),
        img_list = {"unilib_stone_claystone_white.png^unilib_stone_rubble_overlay.png"},
    })

    unilib.register_stone_rubble_compressed({
        -- Original to unilib. Creates unilib:stone_claystone_white_rubble_compressed
        part_name = "claystone_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed White Claystone Rubble"),
    })

    unilib.register_stone_rubble_condensed({
        -- Original to unilib. Creates unilib:stone_claystone_white_rubble_condensed
        part_name = "claystone_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed White Claystone Rubble"),
    })

end
