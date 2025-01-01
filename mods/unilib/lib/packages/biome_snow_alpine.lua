---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_snow_alpine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.snow.add_mode

local min_height = 3

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_snow_alpine.init()

    return {
        description = "Alpine snow biome",
        depends = "stone_ordinary",
    }

end

function unilib.pkg.biome_snow_alpine.post()

    unilib.register_biome({
        -- From snow/mapgen_v7.lua, "snow_biome_alpine" biome
        name = "snow_alpine",
        description = unilib.utils.brackets(S("Alpine snow biome"), "snow"),
        node_top = "unilib:stone_ordinary",
        depth_top = 1,
        node_filler = "unilib:stone_ordinary",
        y_max = unilib.constant.y_max,
        y_min = min_height + 60,
        heat_point = 10.0,
        humidity_point = 40.0,
    })

end
