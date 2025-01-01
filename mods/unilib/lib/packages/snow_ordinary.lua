---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
--
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.snow_ordinary = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local ethereal_add_mode = unilib.global.imported_mod_table.ethereal.add_mode
local mtg_plus_add_mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.snow_ordinary.init()

    return {
        description = "Ordinary snow",
        -- Required when the ice/snow-melting ABM is activated
        depends = "liquid_water_ordinary",
        -- Replace dirt with ordinary grass, for dirt with ordinary snow
        optional = "dirt_ordinary",
    }

end

function unilib.pkg.snow_ordinary.exec()

    unilib.register_node("unilib:snow_ordinary", "default:snow", default_add_mode, {
        -- From default:snow
        description = S("Ordinary Snow"),
        tiles = {"unilib_snow_ordinary.png"},
        groups = {crumbly = 3, falling_node = 1, snowy = 1},
        sounds = unilib.global.sound_table.snow,

        buildable_to = true,
        collision_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, -6 / 16, 0.5},
            },
        },
        drawtype = "nodebox",
        floodable = true,
        inventory_image = "unilib_snow_ordinary_ball.png",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
            },
        },
        paramtype = "light",
        wield_image = "unilib_snow_ordinary_ball.png",

        on_construct = function(pos)

            pos.y = pos.y - 1
            if core.get_node(pos).name == "unilib:dirt_ordinary_with_turf" then
                core.set_node(pos, {name = "unilib:dirt_ordinary_with_cover_snow"})
            end

        end,
    })
    unilib.register_craft({
        -- From default:snow
        output = "unilib:snow_ordinary 9",
        recipe = {
            {"unilib:snow_ordinary_block"},
        },
    })

    unilib.register_decoration_generic("default_snow_ordinary", {
        -- From default/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:snow_ordinary",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 1.0,
            scale = 1.0,
            seed = 172555,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 4,
    })

    unilib.register_node("unilib:snow_ordinary_block", "default:snowblock", default_add_mode, {
        -- From default:snowblock
        description = S("Ordinary Snow Block"),
        tiles = {"unilib_snow_ordinary.png"},
        groups = {cools_lava = 1, crumbly = 3, snowy = 1},
        sounds = unilib.global.sound_table.snow,

        on_construct = function(pos)

            pos.y = pos.y - 1
            if core.get_node(pos).name == "unilib:dirt_ordinary_with_turf" then
                core.set_node(pos, {name = "unilib:dirt_ordinary_with_cover_snow"})
            end

        end,
    })
    unilib.register_craft_3x3({
        -- From default:snowblock
        output = "unilib:snow_ordinary_block",
        ingredient = "unilib:snow_ordinary",
    })
    unilib.register_stairs("unilib:snow_ordinary_block")
    unilib.register_carvings("unilib:snow_ordinary_block", {
        millwork_flag = true,
    })

    if unilib.setting.mtgame_tweak_flag then

        unilib.register_node(
            -- From ethereal:snowbrick
            "unilib:snow_ordinary_brick",
            "ethereal:snowbrick",
            ethereal_add_mode,
            {
                description = S("Ordinary Snow Brick"),
                tiles = {"unilib_snow_ordinary_brick.png"},
                groups = {cools_lava = 1, crumbly = 3, puts_out_fire = 1},
                sounds = unilib.sound.generate_dirt({
                    footstep = {name = "unilib_snow_footstep", gain = 0.15},
                    dug = {name = "unilib_snow_footstep", gain = 0.2},
                    dig = {name = "unilib_snow_footstep", gain = 0.2}
                }),

                is_ground_content = false,
                paramtype = "light",
            }
        )
        -- N.B. Original craft recipe conflicts with the mtg_plus code below
        --[[
        unilib.register_craft_2x2x4({
            -- From ethereal:snowbrick
            output = "unilib:snow_ordinary_brick",
            ingredient = "unilib:snow_ordinary_block",
        })
        ]]--
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:snow_ordinary_brick 8",
            recipe = {
                {"unilib:snow_ordinary", "unilib:snow_ordinary", "unilib:snow_ordinary"},
                {"unilib:snow_ordinary", "", "unilib:snow_ordinary"},
                {"unilib:snow_ordinary", "unilib:snow_ordinary", "unilib:snow_ordinary"},
            },
        })
        unilib.register_stairs("unilib:snow_ordinary_brick")
        unilib.utils.set_auto_rotate(
            "unilib:snow_ordinary_brick", unilib.setting.auto_rotate_brick_flag
        )

        unilib.register_node(
            -- From mtg_plus:snow_brick
            "unilib:snow_ordinary_brick_soft",
            "mtg_plus:snow_brick",
            mtg_plus_add_mode,
            {
                description = S("Soft Ordinary Snow Brick"),
                tiles = {"unilib_snow_ordinary_brick_soft.png"},
                groups = {cools_lava = 1, crumbly = 2, snowy = 1},
                sounds = unilib.sound.generate_dirt({
                    footstep = {name = "unilib_snow_footstep", gain = 0.15},
                    dig = {name = "unilib_snow_footstep", gain = 0.2},
                    dug = {name = "unilib_snow_footstep", gain = 0.2}
                }),

                is_ground_content = false,
            }
        )
        unilib.register_craft_2x2x4({
            -- From mtg_plus:snow_brick
            output = "unilib:snow_ordinary_brick_soft",
            ingredient = "unilib:snow_ordinary_block",
        })
        unilib.register_stairs("unilib:snow_ordinary_brick_soft")
        unilib.utils.set_auto_rotate(
            "unilib:snow_ordinary_brick_soft", unilib.setting.auto_rotate_brick_flag
        )

        unilib.register_node(
            -- From mtg_plus:hard_snow_brick
            "unilib:snow_ordinary_brick_hard",
            "mtg_plus:hard_snow_brick",
            mtg_plus_add_mode,
            {
                description = S("Hard Ordinary Snow Brick"),
                tiles = {"unilib_snow_ordinary_brick_hard.png"},
                groups = {cools_lava = 1, cracky = 2, crumbly = 1, snowy = 1},
                sounds = unilib.sound.generate_dirt({
                    dig = {name = "unilib_snow_footstep", gain = 0.2},
                    dug = {name = "unilib_snow_footstep", gain = 0.2},
                }),

                is_ground_content = false,
            }
        )
        unilib.register_craft_2x2({
            -- From mtg_plus:hard_snow_brick
            output = "unilib:snow_ordinary_brick_hard",
            ingredient = "unilib:snow_ordinary_brick_soft",
        })
        -- N.B. In the original code, this recipe's ingredient is incorrectly set to
        --      "mtg_plus:snow_brick", the equivalent of "unilib:snow_ordinary_brick_soft"
        unilib.register_craft_2x2x4({
            -- From mtg_plus:snow_brick
            output = "unilib:snow_ordinary_block",
            ingredient = "unilib:snow_ordinary_brick_hard",
        })
        unilib.register_stairs("unilib:snow_ordinary_brick_hard")
        unilib.utils.set_auto_rotate(
            "unilib:snow_ordinary_brick_hard", unilib.setting.auto_rotate_brick_flag
        )

        unilib.register_node(
            -- From mtg_plus:ice_snow_brick
            "unilib:snow_ordinary_brick_icy",
            "mtg_plus:ice_snow_brick",
            mtg_plus_add_mode,
            {
                description = S("Icy Ordinary Snow Brick"),
                tiles = {"unilib_snow_ordinary_brick_icy.png"},
                groups = {cools_lava = 1, cracky = 2, slippery = 1},
                sounds = unilib.global.sound_table.stone,

                is_ground_content = false,
            }
        )
        unilib.register_craft({
            -- From mtg_plus:ice_snow_brick
            type = "shapeless",
            output = "unilib:snow_ordinary_brick_icy 2",
            recipe = {"unilib:snow_ordinary_brick_hard", "unilib:ice_ordinary_brick"},
        })
        unilib.register_stairs("unilib:snow_ordinary_brick_icy")
        unilib.utils.set_auto_rotate(
            "unilib:snow_ordinary_brick_icy", unilib.setting.auto_rotate_brick_flag
        )

    end

end
