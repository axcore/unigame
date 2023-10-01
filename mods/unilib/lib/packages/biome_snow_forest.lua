---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_snow_forest = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.snow.add_mode

local min_height = 3

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_snow_forest.init()

    return {
        description = "Forest snow biome",
        depends = "dirt_ordinary",
    }

end

function unilib.pkg.biome_snow_forest.post()

    unilib.register_biome({
        -- From snow/mapgen_v7.lua, "snow_biome_forest" biome
        name = "snow_forest",
        description = unilib.brackets(S("Forest snow biome"), "snow"),
        node_top = "unilib:dirt_ordinary_with_cover_snow",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 2,
        y_max = min_height + 60,
        y_min = min_height,
        heat_point = 10.0,
        humidity_point = 55.0,
    })

end
