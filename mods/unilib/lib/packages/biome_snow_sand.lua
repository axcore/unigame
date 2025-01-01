---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_snow_sand = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_snow_sand.init()

    return {
        description = "Sandy snow biome",
        depends = {"sand_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.biome_snow_sand.post()

    unilib.register_biome({
        -- From snow/mapgen_v7.lua, "snow_biome_sand" biome
        name = "snow_sand",
        description = unilib.utils.brackets(S("Sandy snow biome"), "snow"),
        node_top = "unilib:sand_ordinary",
        depth_top = 3,
        node_filler = "unilib:stone_ordinary",
        depth_filler = 0,
        y_max = 2,
        y_min = unilib.constant.y_min,
        heat_point = 10.0,
        humidity_point = 40.0,
    })

end
