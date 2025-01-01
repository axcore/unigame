---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_snow_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.snow.add_mode

local min_height = 3

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_snow_normal.init()

    return {
        description = "Normal snow biome",
        depends = "dirt_ordinary",
    }

end

function unilib.pkg.biome_snow_normal.post()

    unilib.register_biome({
        -- From snow/mapgen_v7.lua, "snow_biome_default" biome
        name = "snow_normal",
        description = unilib.utils.brackets(S("Normal snow biome"), "snow"),
        node_top = "unilib:dirt_ordinary_with_cover_snow",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 2,
        y_max = min_height + 60,
        y_min = min_height,
        heat_point = 10.0,
        humidity_point = 40.0,
    })

end
