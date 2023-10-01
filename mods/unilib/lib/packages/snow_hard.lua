---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.snow_hard = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.snow_hard.init()

    return {
        description = "Hard snow bricks",
        depends = "shared_snow",
        optional = {"ice_hard", "ice_ordinary", "snow_ordinary"},
    }

end

function unilib.pkg.snow_hard.exec()

    unilib.register_node("unilib:snow_hard_brick", "snow:snow_brick", mode, {
        -- From snow:snow_brick
        description = S("Hard Snow Bricks"),
        tiles = {"unilib_snow_hard_brick.png"},
        groups = {
            choppy = 2, cooks_into_ice = 1, cools_lava = 1, cracky = 2, crumbly = 2, icemaker = 1,
            melts = 1, oddly_breakable_by_hand = 2, snowy = 1,
        },
        sounds = unilib.sound_table.snow,

        liquidtype = "none",
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,

        on_construct = unilib.pkg.shared_snow.snow_onto_dirt,
    })
    if unilib.pkg_executed_table["snow_ordinary"] ~= nil then

        -- N.B. The reverse recipe appears in the .post() function below
        unilib.register_craft({
            -- From snow:snow_brick
            output = "unilib:snow_ordinary_block 4",
            recipe = {
                {"unilib:snow_hard_brick"},
            },
        })

    end
    unilib.register_stairs("unilib:snow_hard_brick")
    unilib.set_auto_rotate("unilib:snow_hard_brick", unilib.auto_rotate_brick_flag)

    unilib.register_node("unilib:snow_hard_cobble", "snow:snow_cobble", mode, {
        -- From snow:snow_cobble
        description = S("Hard Snow Cobble"),
        tiles = {"unilib_snow_hard_cobble.png"},
        groups = {
            choppy = 2, cooks_into_ice = 1, cools_lava = 1, cracky = 2, crumbly = 2, icemaker = 1,
            melts = 1, oddly_breakable_by_hand = 2, snowy = 1,
        },
        sounds = unilib.sound_table.snow,

        liquidtype = "none",
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,

        on_construct = unilib.pkg.shared_snow.snow_onto_dirt,
    })
    if unilib.pkg_executed_table["snow_ordinary"] ~= nil then

        unilib.register_craft({
            -- From snow:snow_cobble
            type = "shapeless",
            output = "unilib:snow_ordinary_block 2",
            recipe = {
                "unilib:snow_hard_cobble",
                "unilib:snow_hard_cobble",
            },
        })

        if unilib.pkg_executed_table["ce_ordinary"] ~= nil then

            unilib.register_craft({
                -- From snow:snow_cobble
                type = "shapeless",
                output = "unilib:snow_hard_cobble 6",
                recipe = {
                    "unilib:snow_ordinary",
                    "unilib:snow_ordinary",
                    "unilib:snow_ordinary",
                    "unilib:snow_ordinary",
                    "unilib:snow_ordinary",
                    "unilib:snow_ordinary",
                    "unilib:ice_ordinary",
                    "unilib:ice_ordinary",
                    "unilib:ice_ordinary",
                },
            })
            unilib.register_craft({
                -- From snow:snow_cobble
                type = "shapeless",
                output = "unilib:snow_hard_cobble 4",
                recipe = {
                    "unilib:snow_ordinary",
                    "unilib:snow_ordinary",
                    "unilib:snow_ordinary",
                    "unilib:snow_ordinary",
                    "unilib:ice_ordinary",
                    "unilib:ice_ordinary",
                },
            })
            unilib.register_craft({
                -- From snow:snow_cobble
                type = "shapeless",
                output = "unilib:snow_hard_cobble 2",
                recipe = {
                    "unilib:snow_ordinary",
                    "unilib:snow_ordinary",
                    "unilib:ice_ordinary",
                },
            })
            unilib.register_craft({
                -- From snow:snow_cobble
                type = "shapeless",
                output = "unilib:snow_hard_cobble",
                recipe = {
                    "unilib:snow_ordinary",
                    "unilib:ice_ordinary",
                },
            })

        end

    end
    if unilib.pkg_executed_table["ice_hard"] ~= nil then

        unilib.register_craft({
            -- From snow:ice_brick
            output = "unilib:snow_hard_cobble 6",
            recipe = {
                {"unilib:ice_hard_brick"},
            },
        })

    end
    unilib.register_stairs("unilib:snow_hard_cobble")

end

function unilib.pkg.snow_hard.post()

    if unilib.pkg_executed_table["snow_ordinary"] ~= nil then

        -- N.B. The original craft recipes clash with ones in the "ice_ordinary" package
        --[[
        unilib.register_craft({
            -- From snow:snow_brick
            output = "unilib:snow_hard_brick",
            recipe = {
                {"unilib:snow_ordinary_block", "unilib:snow_ordinary_block"},
                {"unilib:snow_ordinary_block", "unilib:snow_ordinary_block"},
            },
        })
        ]]--
        unilib.register_craft({
            -- From snow:snow_brick
            output = "unilib:snow_hard_brick",
            recipe = {
                {"unilib:snow_ordinary_block", "", "unilib:snow_ordinary_block"},
                {"", "group:craftable_bucket", ""},
                {"unilib:snow_ordinary_block", "", "unilib:snow_ordinary_block"},
            },
            replacements = unilib.craftable_bucket_list,
        })

    end

end
