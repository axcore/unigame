---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_tundra = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_tundra.init()

    return {
        description = "Tundra biomes",
        depends = {"dirt_permafrost", "gravel_ordinary", "sand_ordinary", "snow_ordinary"},
    }

end

function unilib.pkg.biome_ethereal_tundra.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "tundra" biome
        name = "ethereal_tundra",
        description = unilib.brackets(S("Tundra biome"), "ethereal"),
        node_top = "unilib:dirt_permafrost_with_stonelet",
        depth_top = 1,
        node_filler = "unilib:dirt_permafrost",
        depth_filler = 1,
        node_riverbed = "unilib:gravel_ordinary",
        depth_riverbed = 2,
        y_max = 46,
        y_min = 2,
        vertical_blend = 4,
        heat_point = 0,
        humidity_point = 40,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "tundra_beach" biome
        name = "ethereal_tundra_beach",
        description = unilib.brackets(S("Tundra beach biome"), "ethereal"),
        node_top = "unilib:gravel_ordinary",
        depth_top = 1,
        node_filler = "unilib:gravel_ordinary",
        depth_filler = 2,
        node_riverbed = "unilib:gravel_ordinary",
        depth_riverbed = 2,
        y_max = 1,
        y_min = -3,
        vertical_blend = 1,
        heat_point = 0,
        humidity_point = 40
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "tundra_ocean" biome
        name = "ethereal_tundra_ocean",
        description = unilib.brackets(S("Tundra ocean biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:gravel_ordinary",
        depth_riverbed = 2,
        y_max = -4,
        y_min = -112,
        vertical_blend = 1,
        heat_point = 0,
        humidity_point = 40,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "tundra_highland" biome
        name = "ethereal_tundra_highland",
        description = unilib.brackets(S("Highland tundra biome"), "ethereal"),
        node_dust = "unilib:snow_ordinary",
        node_riverbed = "unilib:gravel_ordinary",
        depth_riverbed = 2,
        y_max = 180,
        y_min = 47,
        heat_point = 0,
        humidity_point = 40,
    })

end
