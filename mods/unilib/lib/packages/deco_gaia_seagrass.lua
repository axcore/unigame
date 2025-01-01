---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_gaia_seagrass = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_gaia_seagrass.init()

    return {
        description = "Seagrass for the \"gaia\" remix",
        notes = "Based on \"deco_glemr11\" (just the seagrasses)",
        depends = {"biome_gaia", "grass_seagrass"},
    }

end

function unilib.pkg.deco_gaia_seagrass.post()

    -- Cold biomes - somewhat common
    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = {
            "unilib:grass_seagrass_1",
            "unilib:grass_seagrass_2",
            "unilib:grass_seagrass_3",
        },

        --[[
        biomes = {
            "gaia_hot_semiarid_ocean",
            "gaia_warm_semiarid_ocean",
            "gaia_mild_semiarid_ocean",
            "gaia_cool_semiarid_ocean",
        },
        ]]--
        biomes = {
            "gaia_cold_humid_ocean",
            "gaia_cold_semihumid_ocean",
            "gaia_cold_temperate_ocean",
        },
        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -0.004,
            persist = 0.7,
            scale = 0.1,
            seed = 87112,
            spread = {x = 200, y = 200, z = 200},
        },
        -- N.B. Removed apparently useless values of .param2/.param2_max from original code
--      param2 = 48,
--      param2_max = 96,
        -- N.B. The negative offset only makes sense with a suitable schematic
--      place_offset_y = -1,
        place_on = "group:sand",
        sidelen = 16,
        y_max = -5,
        y_min = -15,
    })

    -- Arid biomes -- somewhat rare
    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = {
            "unilib:grass_seagrass_1",
            "unilib:grass_seagrass_2",
            "unilib:grass_seagrass_3",
        },

        biomes = {
            "gaia_mild_semiarid_ocean",
            "gaia_mild_arid_ocean",
            "gaia_cool_semiarid_ocean",
            "gaia_cool_arid_ocean",
            "gaia_cold_semiarid_ocean",
            "gaia_cold_arid_ocean",
        },
        flags = "force_placement",
        fill_ratio = 0.003,
        -- N.B. Removed apparently useless values of .param2/.param2_max from original code
--      param2 = 48,
--      param2_max = 96,
        -- N.B. The negative offset only makes sense with a suitable schematic
--      place_offset_y = -1,
        place_on = "group:sand",
        y_max = -5,
        y_min = -15,
    })

end
