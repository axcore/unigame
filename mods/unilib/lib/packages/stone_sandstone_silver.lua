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

unilib.pkg.stone_sandstone_silver = {}

local S = unilib.intllib
local default_add_mode = unilib.imported_mod_table.default.add_mode
local mtg_plus_add_mode = unilib.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_silver.init()

    return {
        description = "Silver sandstone",
    }

end

function unilib.pkg.stone_sandstone_silver.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_silver",
        description = S("Silver Sandstone"),

        basic_platform_flag = true,
        category = "sedimentary",
        grinder_flag = true,
        grinder_powder = "unilib:sand_silver",
        grinder_gravel = "unilib:gravel_sandstone_silver",
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 4)
        hardness = 1,
        hardness_real = 4,
        not_super_flag = true,
    })

    local smooth_cracky, block_cracky = unilib.get_adjusted_cracky("sandstone_silver", 3, 2)

    unilib.register_node(
        -- From default:silver_sandstone
        "unilib:stone_sandstone_silver",
        "default:silver_sandstone",
        default_add_mode,
        {
            description = S("Silver Sandstone"),
            tiles = {"unilib_stone_sandstone_silver.png"},
            groups = {cracky = smooth_cracky, crumbly = 1},
            sounds = unilib.sound_table.stone,
        }
    )
    unilib.register_craft_2x2({
        -- From default:silver_sandstone
        output = "unilib:stone_sandstone_silver",
        ingredient = "unilib:sand_silver",
    })
    unilib.register_craft({
        -- From default:silver_sandstone
        output = "unilib:sand_silver 4",
        recipe = {
            {"unilib:stone_sandstone_silver"},
        }
    })
    --[[
    if unilib.sandstone_cobble_rubble_flag then

        unilib.register_stairs("unilib:stone_sandstone_silver", {
            drop_name = "unilib:stone_sandstone_silver_rubble",
        })

    else

        unilib.register_stairs("unilib:stone_sandstone_silver")

    end
    unilib.register_carvings("unilib:stone_sandstone_silver", {
        facade_flag = true,
        millwork_flag = true,
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "sandstone_silver",

        sandstone_flag = true,
    })

    unilib.register_node(
        -- From default:silver_sandstone_block
        "unilib:stone_sandstone_silver_block",
        "default:silver_sandstone_block",
        default_add_mode,
        {
            description = S("Silver Sandstone Block"),
            tiles = {"unilib_stone_sandstone_silver_block.png"},
            groups = {cracky = block_cracky},
            sounds = unilib.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3x9({
        -- From default:silver_sandstone_block
        output = "unilib:stone_sandstone_silver_block",
        ingredient = "unilib:stone_sandstone_silver",
    })
    --[[
    unilib.register_stairs("unilib:stone_sandstone_silver_block")
    unilib.register_carvings("unilib:stone_sandstone_silver_block", {
        millwork_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "sandstone_silver",
    })

    unilib.register_node(
        -- From default:silver_sandstone_brick
        "unilib:stone_sandstone_silver_brick",
        "default:silver_sandstone_brick",
        default_add_mode,
        {
            description = S("Silver Sandstone Bricks"),
            tiles = {"unilib_stone_sandstone_silver_brick.png"},
            groups = {cracky = 2},
            sounds = unilib.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft_2x2x4({
        -- From default:silver_sandstone_brick
        output = "unilib:stone_sandstone_silver_brick",
        ingredient = "unilib:stone_sandstone_silver",
    })
    --[[
    unilib.register_stairs("unilib:stone_sandstone_silver_brick", {
        img_rotate_flag = true,
    })
    unilib.register_carvings("unilib:stone_sandstone_silver_brick", {
        brick_flag = true,
        millwork_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "sandstone_silver",
    })
    unilib.set_auto_rotate("unilib:stone_sandstone_silver_brick", unilib.auto_rotate_brick_flag)

    if unilib.mtgame_tweak_flag then

        unilib.register_node(
            -- From mtg_plus:silver_sandstone_cobble
            "unilib:stone_sandstone_silver_cobble",
            "mtg_plus:silver_sandstone_cobble",
            mtg_plus_add_mode,
            {
                description = S("Cobbled Silver Sandstone"),
                tiles = {"unilib_stone_sandstone_silver_cobble.png"},
                groups = {cracky = 3},
                sounds = unilib.sound_table.stone,

                is_ground_content = false,
            }
        )
        unilib.register_craft({
            -- From mtg_plus:silver_sandstone_cobble
            output = "unilib:stone_sandstone_silver_cobble 2",
            recipe = {
                {"unilib:stone_sandstone_silver", "unilib:stone_sandstone_silver"},
            },
        })
        unilib.register_craft({
            -- From mtg_plus:silver_sandstone_cobble
            type = "cooking",
            output = "unilib:stone_sandstone_silver",
            recipe = "unilib:stone_sandstone_silver_cobble",
        })
        --[[
        unilib.register_stairs("unilib:stone_sandstone_silver_cobble", {
            group_type = "cobble",
        })
        unilib.register_wall({
            -- From mtg_plus:wall_silver_sandstone_cobble
            orig_name = "mtg_plus:wall_silver_sandstone_cobble",
            ingredient = "unilib:stone_sandstone_silver_cobble",

            replace_mode = mtg_plus_add_mode,
            description = S("Cobbled Silver Sandstone Wall"),
            sound_name = "stone",
            img_list = {"unilib_stone_sandstone_silver_cobble.png"},
        })
        ]]--
        unilib.register_stone_cobble_cuttings({
            part_name = "sandstone_silver",

            replace_mode = mtg_plus_add_mode,
            wall_orig_name = "mtg_plus:wall_silver_sandstone_cobble",
        })

    end

    -- N.B. The cobble above is a decorative item, not produced when digging smoothstone; so this
    --      package also includes a rubble
    if unilib.sandstone_cobble_rubble_flag then

        if unilib.get_stone_actual_hardness("sandstone_ordinary") == 1 then

            unilib.register_stone_rubble({
                -- Original to unilib. Creates unilib:stone_sandstone_silver_rubble
                part_name = "sandstone_silver",
                orig_name = nil,

                replace_mode = mode,
                description = S("Silver Sandstone Rubble"),
                img_list = {"unilib_stone_sandstone_silver.png^unilib_stone_rubble_overlay.png"},
            })
            minetest.override("unilib:stone_sandstone_silver", {
                drop = "unilib:stone_sandstone_silver_rubble",
            })
            unilib.register_stone_rubble_cuttings({
                part_name = "sandstone_silver",
            })

        end

    end

end
