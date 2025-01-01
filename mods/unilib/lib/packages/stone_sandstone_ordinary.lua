---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
--
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_ordinary = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local moreblocks_add_mode = unilib.global.imported_mod_table.moreblocks.add_mode
local mtg_plus_add_mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_ordinary.init()

    return {
        description = "Ordinary sandstone",
        optional = {"mineral_mese", "gravel_sandstone_ordinary", "sand_ordinary"},
    }

end

function unilib.pkg.stone_sandstone_ordinary.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_ordinary",
        description = S("Ordinary Sandstone"),

        basic_platform_flag = true,
        category = "sedimentary",
        colour = "#FFF9C5",
        grinder_flag = true,
        grinder_powder = "unilib:sand_ordinary",
        grinder_gravel = "unilib:gravel_sandstone_ordinary",
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 4)
        hardness = 1,
        hardness_real = 4,
        not_super_flag = true,
    })

    local smooth_cracky, block_cracky = unilib.stone.get_adjusted_cracky("sandstone_ordinary", 3, 2)

    unilib.register_node("unilib:stone_sandstone_ordinary", "default:sandstone", default_add_mode, {
        -- From default:sandstone
        description = S("Ordinary Sandstone"),
        tiles = {"unilib_stone_sandstone_ordinary.png"},
        groups = {cracky = smooth_cracky, crumbly = 1},
        sounds = unilib.global.sound_table.stone,
    })
    if unilib.global.pkg_executed_table["sand_ordinary"] ~= nil then

        unilib.register_craft_2x2({
            -- From default:sandstone
            output = "unilib:stone_sandstone_ordinary",
            ingredient = "unilib:sand_ordinary",
        })
        unilib.register_craft({
            -- From default:sandstone
            output = "unilib:sand_ordinary 4",
            recipe = {
                {"unilib:stone_sandstone_ordinary"},
            },
        })

    end
    --[[
    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stairs("unilib:stone_sandstone_ordinary", {
            drop_name = "unilib:stone_sandstone_ordinary_rubble",
            group_type = "smooth",
        })

    else

        unilib.register_stairs("unilib:stone_sandstone_ordinary", {
            group_type = "smooth",
        })

    end
    unilib.register_carvings("unilib:stone_sandstone_ordinary", {
        all_flag = true,
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "sandstone_ordinary",

        sandstone_flag = true,
    })
    if unilib.setting.mtgame_tweak_flag and
            unilib.global.pkg_executed_table["mineral_mese"] ~= nil and
            (moreblocks_add_mode ~= "defer" or not core.get_modpath("moreblocks")) then

        unilib.register_stone_trap({
            -- From moreblocks:trap_sandstone. Creates unilib:stone_sandstone_ordinary_trap
            orig_name = "moreblocks:trap_sandstone",
            ingredient = "unilib:stone_sandstone_ordinary",
            replace_mode = moreblocks_add_mode,
            group_table = {cracky = 3, crumbly = 1},
        })

    end

    unilib.register_node(
        -- From default:sandstone_block
        "unilib:stone_sandstone_ordinary_block",
        "default:sandstone_block",
        default_add_mode,
        {
            description = S("Ordinary Sandstone Block"),
            tiles = {"unilib_stone_sandstone_ordinary_block.png"},
            groups = {cracky = block_cracky},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3x9({
        -- From default:sandstone_block
        output = "unilib:stone_sandstone_ordinary_block",
        ingredient = "unilib:stone_sandstone_ordinary",
    })
    --[[
    unilib.register_stairs("unilib:stone_sandstone_ordinary_block")
    unilib.register_carvings("unilib:stone_sandstone_ordinary_block", {
        millwork_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "sandstone_ordinary",
    })

    unilib.register_node(
        -- From default:sandstonebrick
        "unilib:stone_sandstone_ordinary_brick",
        "default:sandstonebrick",
        default_add_mode,
        {
            description = S("Ordinary Sandstone Bricks"),
            tiles = {"unilib_stone_sandstone_ordinary_brick.png"},
            groups = {cracky = 2},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft_2x2x4({
        -- From default:sandstonebrick
        output = "unilib:stone_sandstone_ordinary_brick",
        ingredient = "unilib:stone_sandstone_ordinary",
    })
    --[[
    unilib.register_stairs("unilib:stone_sandstone_ordinary_brick", {
        img_rotate_flag = true,
    })
    unilib.register_carvings("unilib:stone_sandstone_ordinary_brick", {
        brick_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "sandstone_ordinary",
    })
    unilib.utils.set_auto_rotate(
        "unilib:stone_sandstone_ordinary_brick", unilib.setting.auto_rotate_brick_flag
    )

    if unilib.setting.mtgame_tweak_flag then

        unilib.register_node(
            -- From mtg_plus:sandstone_cobble
            "unilib:stone_sandstone_ordinary_cobble",
            "mtg_plus:sandstone_cobble",
            mtg_plus_add_mode,
            {
                description = S("Cobbled Ordinary Sandstone"),
                tiles = {"unilib_stone_sandstone_ordinary_cobble.png"},
                groups = {cracky = 3},
                sounds = unilib.global.sound_table.stone,

                is_ground_content = false,
            }
        )
        unilib.register_craft({
            -- From mtg_plus:sandstone_cobble
            output = "unilib:stone_sandstone_ordinary_cobble 2",
            recipe = {
                {"unilib:stone_sandstone_ordinary", "unilib:stone_sandstone_ordinary"},
            },
        })
        unilib.register_craft({
            -- From mtg_plus:sandstone_cobble
            type = "cooking",
            output = "unilib:stone_sandstone_ordinary",
            recipe = "unilib:stone_sandstone_ordinary_cobble",
        })
        --[[
        unilib.register_stairs("unilib:stone_sandstone_ordinary_cobble", {
            group_type = "cobble",
        })
        unilib.register_wall({
            -- From mtg_plus:wall_sandstone_cobble
            orig_name = "mtg_plus:wall_sandstone_cobble",
            ingredient = "unilib:stone_sandstone_ordinary_cobble",

            replace_mode = mtg_plus_add_mode,
            description = S("Cobbled Ordinary Sandstone Wall"),
            group_table = {cracky = 3, wall = 1},
            sound_name = "stone",
            img_list = {"unilib_stone_sandstone_ordinary_cobble.png"},
        })
        ]]--
        unilib.register_stone_cobble_cuttings({
            part_name = "sandstone_ordinary",

            replace_mode = mtg_plus_add_mode,
            wall_orig_name = "mtg_plus:wall_sandstone_cobble",
        })

    end

    -- N.B. The cobble above is a decorative item, not produced when digging smoothstone; so this
    --      package also includes a rubble
    if unilib.setting.sandstone_cobble_rubble_flag then

        if unilib.stone.get_actual_hardness("sandstone_ordinary") == 1 then

            unilib.register_stone_rubble({
                -- Original to unilib. Creates unilib:stone_sandstone_ordinary_rubble
                part_name = "sandstone_ordinary",
                orig_name = nil,

                replace_mode = default_add_mode,
                description = S("Ordinary Sandstone Rubble"),
                img_list = {"unilib_stone_sandstone_ordinary.png^unilib_stone_rubble_overlay.png"},
            })
            unilib.override_item("unilib:stone_sandstone_ordinary", {
                drop = "unilib:stone_sandstone_ordinary_rubble",
            })

            unilib.register_stone_rubble_compressed({
                -- Original to unilib. Creates unilib:stone_sandstone_ordinary_rubble_compressed
                part_name = "sandstone_ordinary",
                orig_name = nil,

                replace_mode = default_add_mode,
                description = S("Compressed Ordinary Sandstone Rubble"),
            })

            unilib.register_stone_rubble_condensed({
                -- Original to unilib. Creates unilib:stone_sandstone_ordinary_rubble_condensed
                part_name = "sandstone_ordinary",
                orig_name = nil,

                replace_mode = default_add_mode,
                description = S("Condensed Ordinary Sandstone Rubble"),
            })

        end

    end

end
