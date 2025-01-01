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

unilib.pkg.ice_ordinary = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local ethereal_add_mode = unilib.global.imported_mod_table.ethereal.add_mode
local mtg_plus_add_mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ice_ordinary.init()

    return {
        description = "Ordinary ice",
        -- Required when the ice/snow-melting ABM is activated
        depends = "liquid_water_ordinary",
    }

end

function unilib.pkg.ice_ordinary.exec()

    -- Notes from default:
    -- "is ground content = false" to avoid tunnels in sea ice or ice rivers
    unilib.register_node("unilib:ice_ordinary", "default:ice", default_add_mode, {
        -- From default:ice
        description = S("Ordinary Ice"),
        tiles = {"unilib_ice_ordinary.png"},
        -- N.B. melts = 1 and puts_out_fire = 1 not in original code
        groups = {cools_lava = 1, cracky = 3, melts = 1, puts_out_fire = 1, slippery = 3},
        sounds = unilib.global.sound_table.ice,

        is_ground_content = false,
        paramtype = "light",
    })
    unilib.register_stairs("unilib:ice_ordinary")
    unilib.register_carvings("unilib:ice_ordinary", {
        millwork_flag = true,
    })

    -- Notes from default:
    -- Mapgen-placed ice with "is ground content = true" to contain tunnels
    unilib.register_node("unilib:ice_ordinary_cave", "default:cave_ice", default_add_mode, {
        -- From default:cave_ice
        description = S("Ordinary Cave Ice"),
        tiles = {"unilib_ice_ordinary.png"},
        -- N.B. melts = 1 and puts_out_fire = 1 not in original code
        groups = {
            cools_lava = 1, cracky = 3, melts = 1, not_in_creative_inventory = 1, puts_out_fire = 1,
            slippery = 3,
        },
        sounds = unilib.global.sound_table.ice,

        drop = "unilib:ice_ordinary",
        paramtype = "light",
    })

    if unilib.setting.mtgame_tweak_flag then

        unilib.register_node("unilib:ice_ordinary_block", "mtg_plus:ice_block", mtg_plus_add_mode, {
            -- From mtg_plus:ice_block
            description = S("Ordinary Ice Block"),
            tiles = {"unilib_ice_ordinary_block.png"},
            -- N.B. melts = 1 and puts_out_fire = 1 not in original code
            groups = {cools_lava = 1, cracky = 3, melts = 1, puts_out_fire = 1, slippery = 3},
            sounds = unilib.global.sound_table.glass,

            is_ground_content = false,
            paramtype = "light",
        })
        unilib.register_craft_3x3x9({
            -- From mtg_plus:ice_block
            output = "unilib:ice_ordinary_block",
            ingredient = "unilib:ice_ordinary",
        })
        unilib.register_stairs("unilib:ice_ordinary_block")

        unilib.register_node(
            -- From ethereal:icebrick
            "unilib:ice_ordinary_brick",
            "ethereal:icebrick",
            ethereal_add_mode,
            {
                description = S("Ordinary Ice Brick"),
                tiles = {"unilib_ice_ordinary_brick.png"},
                -- N.B. melts = 1 not in original code
                groups = {
                    cools_lava = 1, cracky = 3, melts = 1, puts_out_fire = 1, slippery = 3,
                },
                sounds = unilib.global.sound_table.glass,

                is_ground_content = false,
                paramtype = "light",
            }
        )
        unilib.register_craft_2x2x4({
            -- From ethereal:icebrick
            output = "unilib:ice_ordinary_brick",
            ingredient = "unilib:ice_ordinary",
        })
        unilib.register_stairs("unilib:ice_ordinary_brick")
        unilib.utils.set_auto_rotate(
            "unilib:ice_ordinary_brick", unilib.setting.auto_rotate_brick_flag
        )

        unilib.register_node("unilib:ice_ordinary_tile", "mtg_plus:ice_tile4", mtg_plus_add_mode, {
            -- From mtg_plus:ice_tile4
            description = S("Ordinary Ice Tiles"),
            tiles = {"unilib_ice_ordinary_tile.png"},
            -- N.B. melts = 1 and puts_out_fire = 1 not in original code
            groups = {
                cools_lava = 1, cracky = 3, level = 1, melts = 1, puts_out_fire = 1, slippery = 3,
            },
            sounds = unilib.global.sound_table.glass,

            is_ground_content = false,
            paramtype = "light",
        })
        unilib.register_craft_2x2({
            -- From mtg_plus:ice_tile4
            output = "unilib:ice_ordinary_tile",
            ingredient = "unilib:ice_ordinary_block",
        })
        unilib.register_stairs("unilib:ice_ordinary_tile")

        unilib.register_node(
            -- From mtg_plus:ice_tile16
            "unilib:ice_ordinary_tile_small",
            "mtg_plus:ice_tile16",
            mtg_plus_add_mode,
            {
                description = S("Small Ordinary Ice Tiles"),
                tiles = {"unilib_ice_ordinary_tile_small.png"},
                -- N.B. melts = 1 not in original code
                groups = {cools_lava = 1, cracky = 3, level = 2, melts = 1, slippery = 2},
                sounds = unilib.global.sound_table.glass,

                is_ground_content = false,
            }
        )
        unilib.register_craft_2x2({
            -- From mtg_plus:ice_tile16
            output = "unilib:ice_ordinary_tile_small",
            ingredient = "unilib:ice_ordinary_tile",
        })
        unilib.register_wall({
            -- From mtg_plus:wall_ice_tile16
            orig_name = "mtg_plus:wall_ice_tile16",
            ingredient = "unilib:ice_ordinary_tile_small",

            replace_mode = mtg_plus_add_mode,
            description = S("Small Ordinary Ice Tile Wall"),
            group_table = {cracky = 3, slippery = 1, wall = 1},
            sound_name = "glass",
            img_list = {"unilib_ice_ordinary_tile_small.png"},
        })

    end

end
