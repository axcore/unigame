---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_grey = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_grey.init()

    return {
        description = "Grey sandstone",
        optional = "sand_river",
    }

end

function unilib.pkg.stone_sandstone_grey.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_grey",
        description = S("Grey Sandstone"),

        category = "sedimentary",
        colour = "#959377",
        grinder_flag = true,
        grinder_powder = "unilib:sand_river",
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 4)
        hardness = 1,
        hardness_real = 4,
        not_super_flag = true,
    })

    local smooth_cracky, block_cracky = unilib.stone.get_adjusted_cracky("sandstone_grey", 3, 2)

    unilib.register_node("unilib:stone_sandstone_grey", "aotearoa:grey_sandstone", mode, {
        -- From aotearoa:grey_sandstone
        description = S("Grey Sandstone"),
        tiles = {"unilib_stone_sandstone_grey.png"},
        groups = {cracky = smooth_cracky, crumbly = 1, soft_stone = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. original code dropped smoothstone
    })
    if unilib.global.pkg_executed_table["sand_river"] ~= nil then

        unilib.register_craft_2x2({
            -- From aotearoa:grey_sandstone
            output = "unilib:stone_sandstone_grey",
            ingredient = "unilib:sand_river",
        })
        unilib.register_craft({
            -- From aotearoa:grey_sandstone
            output = "unilib:sand_river 4",
            recipe = {
                {"unilib:stone_sandstone_grey"},
            },
        })

    end
    --[[
    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stairs("unilib:stone_sandstone_grey", {
            basic_flag = true,
            drop_name = "unilib:stone_sandstone_grey_rubble",
            group_type = "smooth",
        })

    else

        unilib.register_stairs("unilib:stone_sandstone_grey", {
            basic_flag = true,
            group_type = "smooth",
        })

    end
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "sandstone_grey",

        sandstone_flag = true,
    })

    unilib.register_node(
        -- From aotearoa:grey_sandstone_block
        "unilib:stone_sandstone_grey_block",
        "aotearoa:grey_sandstone_block",
        mode,
        {
            description = S("Grey Sandstone Block"),
            tiles = {"unilib_stone_sandstone_grey_block.png"},
            groups = {cracky = block_cracky, soft_stone = 1},
            sounds = unilib.global.sound_table.stone,

            -- N.B. is_ground_content = false not in original code; added to match other stones
            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3x9({
        -- From aotearoa:grey_sandstone_block
        output = "unilib:stone_sandstone_grey_block",
        ingredient = "unilib:stone_sandstone_grey",
    })
    --[[
    unilib.register_stairs("unilib:stone_sandstone_grey_block", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "sandstone_grey",
    })

    unilib.register_node(
        -- From aotearoa:grey_sandstonebrick
        "unilib:stone_sandstone_grey_brick",
        "aotearoa:grey_sandstonebrick",
        mode,
        {
            description = S("Grey Sandstone Bricks"),
            tiles = {"unilib_stone_sandstone_grey_brick.png"},
            groups = {cracky = 2, soft_stone = 1},
            sounds = unilib.global.sound_table.stone,

            -- N.B. is_ground_content = false not in original code; added to match other stones
            is_ground_content = false,
        }
    )
    unilib.register_craft_2x2x4({
        -- From aotearoa:grey_sandstonebrick
        output = "unilib:stone_sandstone_grey_brick",
        ingredient = "unilib:stone_sandstone_grey",
    })
    --[[
    unilib.register_stairs("unilib:stone_sandstone_grey_brick", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "sandstone_grey",
    })
    unilib.utils.set_auto_rotate(
        "unilib:stone_sandstone_grey_brick", unilib.setting.auto_rotate_brick_flag
    )

    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble_or_rubble_or_nothing({
            -- Original to unilib. Depending on real hardness, creates
            --      unilib:stone_sandstone_grey_cobble, or unilib:stone_sandstone_grey_rubble, or
            --      nothing
            part_name = "sandstone_grey",
            cobble_description = S("Grey Sandstone Cobble"),
            cobble_compressed_description = S("Compressed Grey Sandstone Cobble"),
            cobble_condensed_description = S("Condensed Grey Sandstone Cobble"),
            rubble_description = S("Grey Sandstone Rubble"),
            rubble_compressed_description = S("Compressed Grey Sandstone Rubble"),
            rubble_condensed_description = S("Condensed Grey Sandstone Rubble"),
            smooth_compressed_description = S("Compressed Grey Sandstone"),
            smooth_condensed_description = S("Condensed Grey Sandstone"),

            replace_mode = mode,
            override_drop_flag = true,
        })

    end

end
