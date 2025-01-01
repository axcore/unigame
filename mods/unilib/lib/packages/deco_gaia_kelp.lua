---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_gaia_kelp = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_deco(full_name)

    local height, height_max
    if full_name ~= "unilib:plant_seaweed_undersea" then

        height = 1
        height_max = 5

    end

    unilib.register_decoration_simple({
        deco_type = "simple",
        decoration = full_name,

        biomes = {
            "gaia_mild_humid_ocean",
            "gaia_mild_semihumid_ocean",
            "gaia_mild_temperate_ocean",
            "gaia_cool_humid_ocean",
            "gaia_cool_semihumid_ocean",
            "gaia_cool_temperate_ocean",
        },
        flags = "force_placement",
        -- N.B. max height of 5 matches the minimum depth at which the kelp occurs
        height = height,
        height_max = height_max,
        noise_params = {
            octaves = 3,
            offset = -0.004,
            persist = 0.7,
            scale = 0.1,
            seed = 87112,
            spread = {x = 200, y = 200, z = 200},
        },
        -- N.B. Replaced apparently useless values of .param2/.param2_max from original code
--      param2 = 48,
--      param2_max = 96,
        param2 = 0,
        param2_max = 3,
        -- N.B. The negative offset only makes sense with a suitable schematic
--      place_offset_y = -1,
        place_on = "group:sand",
        sidelen = 16,
        y_max = -5,
        y_min = -10,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_gaia_kelp.init()

    return {
        description = "Kelp for the \"gaia\" remix",
        notes = "Based on \"deco_glemr11\" (just the kelps)",
        depends = "biome_gaia",
        at_least_one = {
            "plant_kelp_green",
            "plant_kelp_ordinary_gaia",
            "plant_kelp_yellow",
            "plant_seaweed_undersea",
        },
    }

end

function unilib.pkg.deco_gaia_kelp.post()

    if unilib.global.pkg_executed_table["plant_kelp_green"] ~= nil then

        do_deco("unilib:plant_kelp_green")
        do_deco("unilib:plant_kelp_green_thick")

    end

    if unilib.global.pkg_executed_table["plant_kelp_ordinary_gaia"] ~= nil then

        -- N.B. Not used in GLEMr11
        do_deco("unilib:plant_kelp_ordinary")
        do_deco("unilib:plant_kelp_ordinary_thick")

    end

    if unilib.global.pkg_executed_table["plant_kelp_yellow"] ~= nil then

        do_deco("unilib:plant_kelp_yellow")
        -- (N.B. No thick variant in GLEMr11, on which this package is based)
        do_deco("unilib:plant_kelp_yellow_thick")

    end

    if unilib.global.pkg_executed_table["plant_seaweed_undersea"] ~= nil then

        do_deco("unilib:plant_seaweed_undersea")

    end

end
