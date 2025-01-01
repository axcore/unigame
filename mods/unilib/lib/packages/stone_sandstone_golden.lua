---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_golden = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_golden.init()

    return {
        description = "Golden sandstone",
        optional = {"gravel_sandstone_golden", "sand_golden"},
    }

end

function unilib.pkg.stone_sandstone_golden.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_golden",
        description = S("Golden Sandstone"),

        basic_platform_flag = true,
        category = "sedimentary",
        colour = "#C9A038",
        grinder_flag = true,
        grinder_powder = "unilib:sand_golden",
        grinder_gravel = "unilib:gravel_sandstone_golden",
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 4)
        hardness = 1,
        hardness_real = 4,
        not_super_flag = true,
    })

    local smooth_cracky, block_cracky = unilib.stone.get_adjusted_cracky("sandstone_golden", 3, 2)

    unilib.register_node("unilib:stone_sandstone_golden", nil, mode, {
        -- Original to unilib, adapted from default:desert_sandstone
        description = S("Golden Sandstone"),
        tiles = {"unilib_stone_sandstone_golden.png"},
        groups = {cracky = smooth_cracky, crumbly = 1},
        sounds = unilib.global.sound_table.stone,
    })
    if unilib.global.pkg_executed_table["sand_golden"] ~= nil then

        unilib.register_craft_2x2({
            -- Original to unilib, adapted from default:desert_sandstone
            output = "unilib:stone_sandstone_golden",
            ingredient = "unilib:sand_golden",
        })
        unilib.register_craft({
            -- Original to unilib, adapted from default:desert_sandstone
            output = "unilib:sand_golden 4",
            recipe = {
                {"unilib:stone_sandstone_golden"},
            },
        })

    end
    --[[
    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stairs("unilib:stone_sandstone_golden", {
            drop_name = "unilib:stone_sandstone_golden_rubble",
            group_type = "smooth",
        })

    else

        unilib.register_stairs("unilib:stone_sandstone_golden", {
            group_type = "smooth",
        })

    end
    unilib.register_carvings("unilib:stone_sandstone_golden", {
        facade_flag = true,
        millwork_flag = true,
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "sandstone_golden",

        sandstone_flag = true,
    })

    unilib.register_node("unilib:stone_sandstone_golden_block", nil, mode, {
        -- Original to unilib, adapted from default:desert_sandstone_block
        description = S("Golden Sandstone Block"),
        tiles = {"unilib_stone_sandstone_golden_block.png"},
        groups = {cracky = block_cracky},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_3x3x9({
        -- Original to unilib, adapted from default:desert_sandstone_block
        output = "unilib:stone_sandstone_golden_block",
        ingredient = "unilib:stone_sandstone_golden",
    })
    --[[
    unilib.register_stairs("unilib:stone_sandstone_golden_block")
    unilib.register_carvings("unilib:stone_sandstone_golden_block", {
        millwork_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "sandstone_golden",
    })

    unilib.register_node("unilib:stone_sandstone_golden_brick", nil, mode, {
        -- Original to unilib, adapted from default:desert_sandstone_brick
        description = S("Golden Sandstone Bricks"),
        tiles = {"unilib_stone_sandstone_golden_brick.png"},
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- Original to unilib, adapted from default:desert_sandstone_brick
        output = "unilib:stone_sandstone_golden_brick",
        ingredient = "unilib:stone_sandstone_golden",
    })
    --[[
    unilib.register_stairs("unilib:stone_sandstone_golden_brick", {
        img_rotate_flag = true,
    })
    unilib.register_carvings("unilib:stone_sandstone_golden_brick", {
        brick_flag = true,
        millwork_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "sandstone_golden",
    })
    unilib.utils.set_auto_rotate(
        "unilib:stone_sandstone_golden_brick", unilib.setting.auto_rotate_brick_flag
    )

    -- N.B. The corresponding code in the "stone_sandstone_desert" package only produces cobble
    --      when unilib.setting.mtgame_tweak_flag is set; so we'll do the same in this package
    if unilib.setting.mtgame_tweak_flag then

        unilib.register_node("unilib:stone_sandstone_golden_cobble", nil, mode, {
            -- Original to unilib, adapted from mtg_plus:desert_sandstone_cobble
            description = S("Cobbled Golden Sandstone"),
            tiles = {"unilib_stone_sandstone_golden_cobble.png"},
            groups = {cracky = 3},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = false,
        })
        unilib.register_craft({
            -- Original to unilib, adapted from mtg_plus:desert_sandstone_cobble
            output = "unilib:stone_sandstone_golden_cobble 2",
            recipe = {
                {"unilib:stone_sandstone_golden", "unilib:stone_sandstone_golden"},
            },
        })
        unilib.register_craft({
            -- Original to unilib, adapted from mtg_plus:desert_sandstone_cobble
            type = "cooking",
            output = "unilib:stone_sandstone_golden",
            recipe = "unilib:stone_sandstone_golden_cobble",
        })
        --[[
        unilib.register_stairs("unilib:stone_sandstone_golden_cobble", {
            group_type = "cobble",
        })
        unilib.register_wall({
            -- From mtg_plus:wall_desert_sandstone_cobble
            orig_name = "mtg_plus:wall_desert_sandstone_cobble",
            ingredient = "unilib:stone_sandstone_golden_cobble",

            replace_mode = mode,
            description = S("Cobbled Golden Sandstone Wall"),
            sound_name = "stone",
            img_list = {"unilib_stone_sandstone_golden_cobble.png"},
        })
        ]]--
        unilib.register_stone_cobble_cuttings({
            part_name = "sandstone_golden",

            replace_mode = mode,
            wall_orig_name = nil,
        })

    end

    -- N.B. The cobble above is a decorative item, not produced when digging smoothstone; so this
    --      package also includes a rubble
    if unilib.setting.sandstone_cobble_rubble_flag then

        if unilib.stone.get_actual_hardness("sandstone_golden") == 1 then

            unilib.register_stone_rubble({
                -- Original to unilib. Creates unilib:stone_sandstone_golden_rubble
                part_name = "sandstone_golden",
                orig_name = nil,

                replace_mode = mode,
                description = S("Golden Sandstone Rubble"),
                img_list = {"unilib_stone_sandstone_golden.png^unilib_stone_rubble_overlay.png"},
            })
            unilib.override_item("unilib:stone_sandstone_golden", {
                drop = "unilib:stone_sandstone_golden_rubble",
            })

            unilib.register_stone_rubble_compressed({
                -- Original to unilib. Creates unilib:stone_sandstone_golden_rubble_compressed
                part_name = "sandstone_golden",
                orig_name = nil,

                replace_mode = mode,
                description = S("Compressed Golden Sandstone Rubble"),
            })

            unilib.register_stone_rubble_condensed({
                -- Original to unilib. Creates unilib:stone_sandstone_golden_rubble_condensed
                part_name = "sandstone_golden",
                orig_name = nil,

                replace_mode = mode,
                description = S("Condensed Golden Sandstone Rubble"),
            })

        end

    end

end
