---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_pale = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_pale.init()

    return {
        description = "Pale sandstone",
        optional = {"sand_ordinary", "sand_river"},
    }

end

function unilib.pkg.stone_sandstone_pale.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_pale",
        description = S("Pale Sandstone"),

        category = "sedimentary",
        colour = "#C2BD8B",
        grinder_flag = true,
        grinder_powder = "unilib:sand_ordinary",
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 4)
        hardness = 1,
        hardness_real = 4,
        not_super_flag = true,
    })

    local smooth_cracky, block_cracky = unilib.stone.get_adjusted_cracky("sandstone_pale", 3, 2)

    unilib.register_node("unilib:stone_sandstone_pale", "aotearoa:pale_sandstone", mode, {
        -- From aotearoa:pale_sandstone
        description = S("Pale Sandstone"),
        tiles = {"unilib_stone_sandstone_pale.png"},
        groups = {cracky = smooth_cracky, crumbly = 1, soft_stone = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. drops smoothstone in original code
    })
    if unilib.global.pkg_executed_table["sand_ordinary"] ~= nil then

        --[[
        unilib.register_craft_2x2({
            -- From aotearoa:pale_sandstone
            output = "unilib:stone_sandstone_pale",
            ingredient = "unilib:sand_ordinary",
        })
        ]]--
        unilib.register_craft({
            -- From aotearoa:pale_sandstone
            output = "unilib:stone_sandstone_pale",
            recipe = {
                {"unilib:sand_ordinary", "unilib:sand_river"},
                {"unilib:sand_river", "unilib:sand_ordinary"},
            },
        })
        unilib.register_craft({
            -- From aotearoa:pale_sandstone
            output = "unilib:sand_ordinary 4",
            recipe = {
                {"unilib:stone_sandstone_pale"},
            },
        })

    end
    --[[
    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stairs("unilib:stone_sandstone_pale", {
            basic_flag = true,
            drop_name = "unilib:stone_sandstone_pale_rubble",
            group_type = "smooth",
        })

    else

        unilib.register_stairs("unilib:stone_sandstone_pale", {
            basic_flag = true,
            group_type = "smooth",
        })

    end
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "sandstone_pale",

        sandstone_flag = true,
    })

    unilib.register_node(
        -- From aotearoa:pale_sandstone_block
        "unilib:stone_sandstone_pale_block",
        "aotearoa:pale_sandstone_block",
        mode,
        {
            description = S("Pale Sandstone Block"),
            tiles = {"unilib_stone_sandstone_pale_block.png"},
            groups = {cracky = block_cracky, soft_stone = 1},
            sounds = unilib.global.sound_table.stone,

            -- N.B. is_ground_content = false not in original code; added to match other stones
            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3x9({
        -- From aotearoa:pale_sandstone_block
        output = "unilib:stone_sandstone_pale_block",
        ingredient = "unilib:stone_sandstone_pale",
    })
    --[[
    unilib.register_stairs("unilib:stone_sandstone_pale_block", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "sandstone_pale",
    })

    unilib.register_node(
        -- From aotearoa:pale_sandstonebrick
        "unilib:stone_sandstone_pale_brick",
        "aotearoa:pale_sandstonebrick",
        mode,
        {
            description = S("Pale Sandstone Bricks"),
            tiles = {"unilib_stone_sandstone_pale_brick.png"},
            groups = {cracky = 2, soft_stone = 1},
            sounds = unilib.global.sound_table.stone,

            -- N.B. is_ground_content = false not in original code; added to match other stones
            is_ground_content = false,
        }
    )
    unilib.register_craft_2x2x4({
        -- From aotearoa:pale_sandstonebrick
        output = "unilib:stone_sandstone_pale_brick",
        ingredient = "unilib:stone_sandstone_pale",
    })
    --[[
    unilib.register_stairs("unilib:stone_sandstone_pale_brick", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "sandstone_pale",
    })
    unilib.utils.set_auto_rotate(
        "unilib:stone_sandstone_pale_brick", unilib.setting.auto_rotate_brick_flag
    )

    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble_or_rubble_or_nothing({
            -- Original to unilib. Depending on real hardness, creates
            --      unilib:stone_sandstone_pale_cobble, or unilib:stone_sandstone_pale_rubble, or
            --      nothing
            part_name = "sandstone_pale",
            cobble_description = S("Pale Sandstone Cobble"),
            cobble_compressed_description = S("Compressed Pale Sandstone Cobble"),
            cobble_condensed_description = S("Condensed Pale Sandstone Cobble"),
            rubble_description = S("Pale Sandstone Rubble"),
            rubble_compressed_description = S("Compressed Pale Sandstone Rubble"),
            rubble_condensed_description = S("Condensed Pale Sandstone Rubble"),
            smooth_compressed_description = S("Compressed Pale Sandstone"),
            smooth_condensed_description = S("Condensed Pale Sandstone"),

            replace_mode = mode,
            override_drop_flag = true,
        })

    end

end
