---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_gaia_seagrass_xocean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_gaia_seagrass_xocean.init()

    return {
        description = "\"xocean\" seagrass for the \"gaia\" remix",
        notes = "Based on various xocean decoration packages, combined here into one package" ..
                " with \"gaia\" biomes",
        depends = "biome_gaia",
        optional = {"liquid_water_ordinary", "plant_pickle_sea", "plant_seagrass_sickle"},
    }

end

function unilib.pkg.deco_gaia_seagrass_xocean.post()

    -- Sea pickle and sickle seagrass
    for item_name, y_max in pairs({
        plant_pickle_sea = -8,
        plant_seagrass_sickle = -5,
    }) do

        unilib.register_decoration_simple({
            -- From xocean/init.lua
            deco_type = "simple",
            decoration = "unilib:" .. item_name,

            --[[
            biomes = {
                "gaia_hot_humid_ocean",
                "gaia_hot_semihumid_ocean",
                "gaia_hot_temperate_ocean",
                "gaia_hot_semiarid_ocean",
                "gaia_hot_arid_ocean",
            },
            ]]--
            biomes = {
                "gaia_warm_semihumid_ocean",
                "gaia_warm_temperate_ocean",
            },
            flags = "force_placement",
            noise_params = {
                octaves = 3,
                offset = -0.04,
                persist = 0.7,
                scale = 0.04,
                seed = 87112,
                spread = {x = 200, y = 200, z = 200},
            },
            -- N.B. Replaced apparently useless values of .param2/.param2_max from original code
--          param2 = 48,
--          param2_max = 96,
            param2 = 0,
            param2_max = 3,
            place_offset_y = -1,
            place_on = "group:sand",
            sidelen = 16,
            y_max = y_max,
            y_min = -50,
        })

    end

end
