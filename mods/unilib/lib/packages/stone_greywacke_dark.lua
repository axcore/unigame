---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_greywacke_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_greywacke_dark.init()

    return {
        description = "Dark greywacke",
        optional = {
            "stone_claystone_white",
            "stone_sandstone_desert",
            "stone_sandstone_grey",
            "stone_sandstone_ordinary",
            "stone_sandstone_pale",
            "stone_sandstone_silver",
            "stone_siltstone_dark",
        },
    }

end

function unilib.pkg.stone_greywacke_dark.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "greywacke_dark",
        description = S("Dark Greywacke"),

        category = "sedimentary",
        colour = "#6D6F6F",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 3)
        hardness = 1,
        hardness_real = 3,
    })

    local smooth_cracky, block_cracky = unilib.stone.get_adjusted_cracky("greywacke_dark", 3, 2)

    unilib.register_node("unilib:stone_greywacke_dark", "aotearoa:greywacke", mode, {
        -- From aotearoa:greywacke
        description = S("Dark Greywacke"),
        tiles = {"unilib_stone_greywacke_dark.png"},
        -- N.B. smoothstone = 1 not in original code
        groups = {cracky = smooth_cracky, smoothstone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. drops smoothstone in original code
    })
    if unilib.global.pkg_executed_table["stone_claystone_white"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:greywacke
            type = "cooking",
            output = "unilib:stone_greywacke_dark",
            recipe = "unilib:stone_claystone_white",
            cooktime = 120,
        })

    end
    if unilib.global.pkg_executed_table["stone_sandstone_ordinary"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:greywacke
            type = "cooking",
            output = "unilib:stone_greywacke_dark",
            recipe = "unilib:stone_sandstone_ordinary",
            cooktime = 120,
        })

    end
    if unilib.global.pkg_executed_table["stone_sandstone_desert"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:greywacke
            type = "cooking",
            output = "unilib:stone_greywacke_dark",
            recipe = "unilib:stone_sandstone_desert",
            cooktime = 120,
        })

    end
    if unilib.global.pkg_executed_table["stone_sandstone_grey"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:greywacke
            type = "cooking",
            output = "unilib:stone_greywacke_dark",
            recipe = "unilib:stone_sandstone_grey",
            cooktime = 120,
        })

    end
    if unilib.global.pkg_executed_table["stone_sandstone_pale"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:greywacke
            type = "cooking",
            output = "unilib:stone_greywacke_dark",
            recipe = "unilib:stone_sandstone_pale",
            cooktime = 120,
        })

    end
    if unilib.global.pkg_executed_table["stone_sandstone_silver"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:greywacke
            type = "cooking",
            output = "unilib:stone_greywacke_dark",
            recipe = "unilib:stone_sandstone_silver",
            cooktime = 120,
        })

    end
    if unilib.global.pkg_executed_table["stone_siltstone_dark"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:greywacke
            type = "cooking",
            output = "unilib:stone_greywacke_dark",
            recipe = "unilib:stone_siltstone_dark",
            cooktime = 120,
        })

    end
    --[[
    unilib.register_stairs("unilib:stone_greywacke_dark", {
        basic_flag = true,
        drop_name = "unilib:stone_greywacke_dark_rubble",
        group_type = "smooth",
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "greywacke_dark",
    })

    unilib.register_node("unilib:stone_greywacke_dark_block", "aotearoa:greywacke_block", mode, {
        -- From aotearoa:greywacke_block
        description = S("Dark Greywacke Block"),
        tiles = {"unilib_stone_greywacke_dark_block.png"},
        -- N.B. stoneblock = 1 not in original code
        groups = {cracky = block_cracky, stone = 1, stoneblock = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other stones
        is_ground_content = false,
    })
    unilib.register_craft_3x3x9({
        -- From aotearoa:greywacke_block
        output = "unilib:stone_greywacke_dark_block",
        ingredient = "unilib:stone_greywacke_dark",
    })
    --[[
    unilib.register_stairs("unilib:stone_greywacke_dark_block", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "greywacke_dark",
    })

    unilib.register_node("unilib:stone_greywacke_dark_brick", "aotearoa:greywackebrick", mode, {
        -- From aotearoa:greywackebrick
        description = S("Dark Greywacke Bricks"),
        tiles = {"unilib_stone_greywacke_dark_brick.png"},
        -- N.B. stonebrick = 1 not in original code
        groups = {cracky = 2, stone = 1, stonebrick = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other stones
        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From aotearoa:greywackebrick
        output = "unilib:stone_greywacke_dark_brick",
        ingredient = "unilib:stone_greywacke_dark",
    })
    --[[
    unilib.register_stairs("unilib:stone_greywacke_dark_brick", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "greywacke_dark",
    })
    unilib.utils.set_auto_rotate(
        "unilib:stone_greywacke_dark_brick", unilib.setting.auto_rotate_brick_flag
    )

    unilib.register_stone_cobble_or_rubble_or_nothing({
        -- Original to unilib. Depending on real hardness, creates
        --      unilib:stone_greywacke_dark_cobble, or unilib:stone_greywacke_dark_rubble, or
        --      nothing
        part_name = "greywacke_dark",
        cobble_description = S("Dark Greywacke Cobble"),
        cobble_compressed_description = S("Compressed Dark Greywacke Cobble"),
        cobble_condensed_description = S("Condensed Dark Greywacke Cobble"),
        rubble_description = S("Dark Greywacke Rubble"),
        rubble_compressed_description = S("Compressed Dark Greywacke Rubble"),
        rubble_condensed_description = S("Condensed Dark Greywacke Rubble"),
        smooth_compressed_description = S("Compressed Dark Greywacke"),
        smooth_condensed_description = S("Condensed Dark Greywacke"),

        replace_mode = mode,
        override_drop_flag = true,
    })

end
