---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_gaia_coral = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_gaia_coral.init()

    return {
        description = "Coral for the \"gaia\" remix",
        notes = "Based on \"deco_glemr11\" (just the coral reefs)",
        depends = "biome_gaia",
        optional = {
            "coral_block_brown",
            "coral_block_orange",
            "coral_block_skeleton",
            "coral_rooted_blue",
            "coral_rooted_blue_glow",
            "coral_rooted_cyan",
            "coral_rooted_green",
            "coral_rooted_green_glow",
            "coral_rooted_orange",
            "coral_rooted_orange_glow",
            "coral_rooted_pink",
            "coral_rooted_pink_big",
            "coral_rooted_pink_glow",
            "coral_rooted_red",
            "dirt_silt_coarse",
            "plant_anemone_normal",
        },
    }

end

function unilib.pkg.deco_gaia_coral.post()

    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = {
            "unilib:coral_block_brown",
            "unilib:coral_block_orange",
            "unilib:coral_block_skeleton",
            "unilib:coral_rooted_blue",
            "unilib:coral_rooted_cyan",
            "unilib:coral_rooted_green",
            "unilib:coral_rooted_orange",
            "unilib:coral_rooted_pink",
            "unilib:coral_rooted_red",
        },

        --[[
        biomes = {
            "gaia_warm_temperate_ocean",
            "gaia_mild_humid_ocean",
            "gaia_mild_semihumid_ocean",
            "gaia_mild_temperate_ocean",
        },
        ]]--
        biomes = {
            "gaia_mild_humid_ocean",
            "gaia_mild_semihumid_ocean",
        },
        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -4,
            persist = 0.7,
            scale = 4,
            seed = 7013,
            spread = {x = 50, y = 50, z = 50},
        },
        place_offset_y = -1,
        place_on = {"unilib:dirt_silt_coarse", "group:sand"},
        sidelen = 4,
        y_max = -2,
        y_min = -12,
    })

    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = {
            "unilib:coral_block_skeleton",
            "unilib:coral_rooted_blue_glow",
            "unilib:coral_rooted_green_glow",
            "unilib:coral_rooted_orange_glow",
            "unilib:coral_rooted_pink_big",
            "unilib:coral_rooted_pink_glow",
            "unilib:plant_anemone",
        },

        --[[
        biomes = {
            "gaia_warm_humid_ocean",
            "gaia_warm_semihumid_ocean",
        },
        ]]--
        biomes = {
            "gaia_mild_semihumid_ocean",
            "gaia_mild_temperate_ocean",
        },
        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -4,
            persist = 0.7,
            scale = 4,
            spread = {x = 50, y = 50, z = 50},
            seed = 7013,
        },
        place_offset_y = -1,
        place_on = {"unilib:dirt_silt_coarse", "group:sand"},
        sidelen = 4,
        y_max = -4,
        y_min = -14,
    })

end
