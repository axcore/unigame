---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_desert = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local mtg_plus_add_mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_desert.init()

    return {
        description = "Desert sandstone",
        optional = {"gravel_sandstone_desert", "sand_desert"},
    }

end

function unilib.pkg.stone_sandstone_desert.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_desert",
        description = S("Desert Sandstone"),

        basic_platform_flag = true,
        category = "sedimentary",
        colour = "#BC955E",
        grinder_flag = true,
        grinder_powder = "unilib:sand_desert",
        grinder_gravel = "unilib:gravel_sandstone_desert",
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 4)
        hardness = 1,
        hardness_real = 4,
        not_super_flag = true,
    })

    local smooth_cracky, block_cracky = unilib.stone.get_adjusted_cracky("sandstone_desert", 3, 2)

    unilib.register_node(
        -- From default:desert_sandstone
        "unilib:stone_sandstone_desert",
        "default:desert_sandstone",
        default_add_mode,
        {
            description = S("Desert Sandstone"),
            tiles = {"unilib_stone_sandstone_desert.png"},
            groups = {cracky = smooth_cracky, crumbly = 1},
            sounds = unilib.global.sound_table.stone,
        }
    )
    if unilib.global.pkg_executed_table["sand_desert"] ~= nil then

        unilib.register_craft_2x2({
            -- From default:desert_sandstone
            output = "unilib:stone_sandstone_desert",
            ingredient = "unilib:sand_desert",
        })
        unilib.register_craft({
            -- From default:desert_sandstone
            output = "unilib:sand_desert 4",
            recipe = {
                {"unilib:stone_sandstone_desert"},
            },
        })

    end
    --[[
    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stairs("unilib:stone_sandstone_desert", {
            drop_name = "unilib:stone_sandstone_desert_rubble",
            group_type = "smooth",
        })

    else

        unilib.register_stairs("unilib:stone_sandstone_desert", {
            group_type = "smooth",
        })

    end
    unilib.register_carvings("unilib:stone_sandstone_desert", {
        facade_flag = true,
        millwork_flag = true,
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "sandstone_desert",

        sandstone_flag = true,
    })

    unilib.register_node(
        -- From default:desert_sandstone_block
        "unilib:stone_sandstone_desert_block",
        "default:desert_sandstone_block",
        default_add_mode,
        {
            description = S("Desert Sandstone Block"),
            tiles = {"unilib_stone_sandstone_desert_block.png"},
            groups = {cracky = block_cracky},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3x9({
        -- From default:desert_sandstone_block
        output = "unilib:stone_sandstone_desert_block",
        ingredient = "unilib:stone_sandstone_desert",
    })
    --[[
    unilib.register_stairs("unilib:stone_sandstone_desert_block")
    unilib.register_carvings("unilib:stone_sandstone_desert_block", {
        millwork_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "sandstone_desert",
    })

    unilib.register_node(
        -- From default:desert_sandstone_brick
        "unilib:stone_sandstone_desert_brick",
        "default:desert_sandstone_brick",
        default_add_mode,
        {
            description = S("Desert Sandstone Bricks"),
            tiles = {"unilib_stone_sandstone_desert_brick.png"},
            groups = {cracky = 2},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft_2x2x4({
        -- From default:desert_sandstone_brick
        output = "unilib:stone_sandstone_desert_brick",
        ingredient = "unilib:stone_sandstone_desert",
    })
    --[[
    unilib.register_stairs("unilib:stone_sandstone_desert_brick", {
        img_rotate_flag = true,
    })
    unilib.register_carvings("unilib:stone_sandstone_desert_brick", {
        brick_flag = true,
        millwork_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "sandstone_desert",
    })
    unilib.utils.set_auto_rotate(
        "unilib:stone_sandstone_desert_brick", unilib.setting.auto_rotate_brick_flag
    )

    if unilib.setting.mtgame_tweak_flag then

        unilib.register_node(
            -- From mtg_plus:desert_sandstone_cobble
            "unilib:stone_sandstone_desert_cobble",
            "mtg_plus:desert_sandstone_cobble",
            mtg_plus_add_mode,
            {
                description = S("Cobbled Desert Sandstone"),
                tiles = {"unilib_stone_sandstone_desert_cobble.png"},
                groups = {cracky = 3},
                sounds = unilib.global.sound_table.stone,

                is_ground_content = false,
            }
        )
        unilib.register_craft({
            -- From mtg_plus:desert_sandstone_cobble
            output = "unilib:stone_sandstone_desert_cobble 2",
            recipe = {
                {"unilib:stone_sandstone_desert", "unilib:stone_sandstone_desert"},
            },
        })
        unilib.register_craft({
            -- From mtg_plus:desert_sandstone_cobble
            type = "cooking",
            output = "unilib:stone_sandstone_desert",
            recipe = "unilib:stone_sandstone_desert_cobble",
        })
        --[[
        unilib.register_stairs("unilib:stone_sandstone_desert_cobble", {
            group_type = "cobble",
        })
        unilib.register_wall({
            -- From mtg_plus:wall_desert_sandstone_cobble
            orig_name = "mtg_plus:wall_desert_sandstone_cobble",
            ingredient = "unilib:stone_sandstone_desert_cobble",

            replace_mode = mtg_plus_add_mode,
            description = S("Cobbled Desert Sandstone Wall"),
            sound_name = "stone",
            img_list = {"unilib_stone_sandstone_desert_cobble.png"},
        })
        ]]--
        unilib.register_stone_cobble_cuttings({
            part_name = "sandstone_desert",

            replace_mode = mtg_plus_add_mode,
            wall_orig_name = "mtg_plus:wall_desert_sandstone_cobble",
        })

    end

    -- N.B. The cobble above is a decorative item, not produced when digging smoothstone; so this
    --      package also includes a rubble
    if unilib.setting.sandstone_cobble_rubble_flag then

        if unilib.stone.get_actual_hardness("sandstone_desert") == 1 then

            unilib.register_stone_rubble({
                -- Original to unilib. Creates unilib:stone_sandstone_desert_rubble
                part_name = "sandstone_desert",
                orig_name = nil,

                replace_mode = default_add_mode,
                description = S("Desert Sandstone Rubble"),
                img_list = {"unilib_stone_sandstone_desert.png^unilib_stone_rubble_overlay.png"},
            })
            unilib.override_item("unilib:stone_sandstone_desert", {
                drop = "unilib:stone_sandstone_desert_rubble",
            })

            unilib.register_stone_rubble_compressed({
                -- Original to unilib. Creates unilib:stone_sandstone_desert_rubble_compressed
                part_name = "sandstone_desert",
                orig_name = nil,

                replace_mode = default_add_mode,
                description = S("Compressed Desert Sandstone Rubble"),
            })

            unilib.register_stone_rubble_condensed({
                -- Original to unilib. Creates unilib:stone_sandstone_desert_rubble_condensed
                part_name = "sandstone_desert",
                orig_name = nil,

                replace_mode = default_add_mode,
                description = S("Condensed Desert Sandstone Rubble"),
            })

        end

    end

end
