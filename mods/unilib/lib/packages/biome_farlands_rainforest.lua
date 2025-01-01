---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_farlands_rainforest = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_farlands_rainforest.init()

    return {
        description = "Rainforest biomes",
        depends = {
            "dirt_coarse",
            "dirt_ordinary",
            "dirt_ordinary_with_turf_forest",
            "liquid_water_dirty",
            "sand_ordinary",
        },
    }

end

function unilib.pkg.biome_farlands_rainforest.post()

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "rainforest" biome
        name = "farlands_rainforest",
        description = unilib.utils.brackets(S("Rainforest biome"), "farlands"),
        node_top = "unilib:dirt_ordinary_with_turf_forest",
        depth_top = 1,
        node_filler = "unilib:dirt_coarse",
        depth_filler = 3,
        node_water = "unilib:liquid_water_dirty_source",
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = unilib.constant.y_max,
        y_min = 1,
        heat_point = 86,
        humidity_point = 65,
    })

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "rainforest_swamp" biome
        name = "farlands_rainforest_swamp",
        description = unilib.utils.brackets(S("Rainforest swamp biome"), "farlands"),
        node_top = "unilib:dirt_ordinary",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = 0,
        y_min = -1,
        heat_point = 86,
        humidity_point = 65,
    })

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "rainforest_ocean" biome
        name = "farlands_rainforest_ocean",
        description = unilib.utils.brackets(S("Rainforest ocean biome"), "farlands"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = -2,
        y_min = -112,
        heat_point = 86,
        humidity_point = 65,
    })

end
