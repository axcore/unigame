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

unilib.pkg.plant_papyrus_ordinary = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local mtg_plus_add_mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_papyrus_ordinary.init()

    return {
        description = "Ordinary papyrus",
        notes = "Assuming that the \"abm_standard_papyrus_grow\" package is loaded, papyrus" ..
                " grows steadily higher if planted on certain types of dirt from default" ..
                " (matching the biomes in which papyrus appears). No seed/sapling required",
        at_least_one = {"dirt_ordinary", "dirt_dry"},
    }

end

function unilib.pkg.plant_papyrus_ordinary.exec()

    unilib.register_node("unilib:plant_papyrus_ordinary", "default:papyrus", default_add_mode, {
        -- From default:papyrus
        description = unilib.utils.annotate(S("Ordinary Papyrus"), "Cyperus papyrus"),
        tiles = {"unilib_plant_papyrus_ordinary.png"},
        -- N.B. papyrus_grow = 1 not in original code, used for ABM
        groups = {flammable = 2, papyrus_grow = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_plant_papyrus_ordinary.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
        },
        sunlight_propagates = true,
        walkable = unilib.setting.blocking_papyrus_flag,
        wield_image = "unilib_plant_papyrus_ordinary.png",

        -- Digging the base node auto-digs papyrus nodes above it
        after_dig_node = function(pos, node, metadata, digger)
            unilib.misc.dig_up(pos, node, digger)
        end,
    })
    unilib.register_craft({
        -- From default:papyrus
        type = "fuel",
        recipe = "unilib:plant_papyrus_ordinary",
        burntime = 3,
    })
    -- (not compatible with flowerpots)

    -- Enable papyrus growth with fertilisers
    unilib.fertiliser.register_special("unilib:plant_papyrus_ordinary", unilib.flora.grow_papyrus)

    -- Dirt version for rainforest swamp
    unilib.register_decoration_generic("default_plant_papyrus_ordinary_1", {
        -- From default/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod ..
                "/mts/unilib_plant_papyrus_ordinary_on_dirt_ordinary.mts",

        noise_params = {
            octaves = 3,
            offset = -0.3,
            persist = 0.7,
            scale = 0.7,
            seed = 354,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

    -- Dry dirt version for savanna shore
    unilib.register_decoration_generic("default_plant_papyrus_ordinary_2", {
        -- From default/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_plant_papyrus_ordinary_on_dirt_dry.mts",

        noise_params = {
            octaves = 3,
            offset = -0.3,
            persist = 0.7,
            scale = 0.7,
            seed = 354,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

    if unilib.setting.mtgame_tweak_flag then

        unilib.register_node(
            -- From mtg_plus:papyrus_block
            "unilib:plant_papyrus_ordinary_block",
            "mtg_plus:papyrus_block",
            mtg_plus_add_mode,
            {
                description = S("Ordinary Papyrus Block"),
                tiles = {
                    "unilib_plant_papyrus_ordinary_block_top.png",
                    "unilib_plant_papyrus_ordinary_block_top.png",
                    "unilib_plant_papyrus_ordinary_block_side2.png",
                    "unilib_plant_papyrus_ordinary_block_side2.png",
                    "unilib_plant_papyrus_ordinary_block_side.png",
                    "unilib_plant_papyrus_ordinary_block_side.png",
                },
                groups = {choppy = 2, flammable = 3, snappy = 2},
                sounds = unilib.global.sound_table.leaves,

                is_ground_content = false,
            }
        )
        unilib.register_craft_3x3({
            -- From mtg_plus:papyrus_block
            output = "unilib:plant_papyrus_ordinary_block",
            ingredient = "unilib:plant_papyrus_ordinary",
        })
        unilib.register_craft({
            -- From mtg_plus:papyrus_block
            output = "unilib:plant_papyrus_ordinary 9",
            recipe = {
                {"unilib:plant_papyrus_ordinary_block"},
            },
        })
        unilib.register_craft({
            -- From mtg_plus:papyrus_block
            type = "fuel",
            recipe = "unilib:plant_papyrus_ordinary_block",
            burntime = 9,
        })

    end

end
