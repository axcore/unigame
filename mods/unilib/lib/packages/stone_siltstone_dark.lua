---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_siltstone_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_siltstone_dark.init()

    return {
        description = "Dark siltstone",
        optional = "sand_silt_antipodean",
    }

end

function unilib.pkg.stone_siltstone_dark.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "siltstone_dark",
        description = S("Dark Siltstone"),

        category = "sedimentary",
        colour = "#8D7767",
        grinder_flag = true,
        grinder_powder = "unilib:sand_silt_antipodean",
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 2)
        hardness = 1,
        hardness_real = 2,
    })

    local smooth_cracky, block_cracky = unilib.stone.get_adjusted_cracky("siltstone_dark", 3, 2)

    unilib.register_node("unilib:stone_siltstone_dark", "aotearoa:siltstone", mode, {
        -- From aotearoa:siltstone
        description = S("Dark Siltstone"),
        tiles = {"unilib_stone_siltstone_dark.png"},
        -- N.B. smoothstone = 1, stone = 1 not in original code
        groups = {cracky = smooth_cracky, crumbly = 1, smoothstone = 1, soft_stone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. drops smoothstone in original code
    })
    if unilib.global.pkg_executed_table["sand_silt_antipodean"] ~= nil then

        unilib.register_craft_2x2({
            -- From aotearoa:siltstone
            output = "unilib:stone_siltstone_dark",
            ingredient = "unilib:sand_silt_antipodean",
        })
        unilib.register_craft({
            -- From aotearoa:siltstone
            output = "unilib:sand_silt_antipodean 4",
            recipe = {
                {"unilib:stone_siltstone_dark"},
            },
        })

    end
    --[[
    unilib.register_stairs("unilib:stone_siltstone_dark", {
        basic_flag = true,
        drop_name = "unilib:stone_siltstone_dark_rubble",
        group_type = "smooth",
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "siltstone_dark",
    })

    unilib.register_node("unilib:stone_siltstone_dark_block", "aotearoa:siltstone_block", mode, {
        -- From aotearoa:siltstone_block
        description = S("Dark Siltstone Block"),
        tiles = {"unilib_stone_siltstone_dark_block.png"},
        -- N.B. stone = 1, stoneblock = 1 not in original code
        groups = {cracky = block_cracky, soft_stone = 1, stone = 1, stoneblock = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other stones
        is_ground_content = false,
    })
    unilib.register_craft_3x3x9({
        -- From aotearoa:siltstone_block
        output = "unilib:stone_siltstone_dark_block",
        ingredient = "unilib:stone_siltstone_dark",
    })
    --[[
    unilib.register_stairs("unilib:stone_siltstone_dark_block", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "siltstone_dark",
    })

    unilib.register_node("unilib:stone_siltstone_dark_brick", "aotearoa:siltstonebrick", mode, {
        -- From aotearoa:siltstonebrick
        description = S("Dark Siltstone Bricks"),
        tiles = {"unilib_stone_siltstone_dark_brick.png"},
        -- N.B. stone = 1, stonebrick = 1 not in original code
        groups = {cracky = 2, soft_stone = 1, stone = 1, stonebrick = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other stones
        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From aotearoa:siltstonebrick
        output = "unilib:stone_siltstone_dark_brick",
        ingredient = "unilib:stone_siltstone_dark",
    })
    --[[
    unilib.register_stairs("unilib:stone_siltstone_dark_brick", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "siltstone_dark",
    })
    unilib.utils.set_auto_rotate(
        "unilib:stone_siltstone_dark_brick", unilib.setting.auto_rotate_brick_flag
    )

    unilib.register_stone_cobble_or_rubble_or_nothing({
        -- Original to unilib. Creates unilib:stone_siltstone_dark_cobble or
        --      unilib:stone_siltstone_dark_rubble
        part_name = "siltstone_dark",
        cobble_description = S("Dark Siltstone Cobble"),
        cobble_compressed_description = S("Compressed Dark Siltstone Cobble"),
        cobble_condensed_description = S("Condensed Dark Siltstone Cobble"),
        rubble_description = S("Dark Siltstone Rubble"),
        rubble_compressed_description = S("Compressed Dark Siltstone Rubble"),
        rubble_condensed_description = S("Condensed Dark Siltstone Rubble"),
        smooth_compressed_description = S("Compressed Dark Siltstone"),
        smooth_condensed_description = S("Condensed Dark Siltstone"),

        replace_mode = mode,
        override_drop_flag = true,
    })

end
