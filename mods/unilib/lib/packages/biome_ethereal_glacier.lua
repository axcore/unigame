---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_glacier = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_glacier.init()

    return {
        description = "Glacier biomes",
        depends = {"gravel_ordinary", "ice_ordinary", "sand_ordinary", "snow_ordinary"},
    }

end

function unilib.pkg.biome_ethereal_glacier.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "glacier" biome
        name = "ethereal_glacier",
        description = unilib.brackets(S("Glacier biome"), "ethereal"),
        node_dust = "unilib:snow_ordinary_block",
        node_top = "unilib:snow_ordinary_block",
        depth_top = 1,
        node_filler = "unilib:snow_ordinary_block",
        depth_filler = 3,
        node_stone = "unilib:ice_ordinary",
        node_water_top = "unilib:ice_ordinary",
        depth_water_top = 10,
        node_river_water = "unilib:ice_ordinary",
        node_riverbed = "unilib:gravel_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:ice_ordinary_brick",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:ice_ordinary"),
        y_max = unilib.y_max,
        y_min = -8,
        heat_point = 0,
        humidity_point = 50,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "glacier_ocean" biome
        name = "ethereal_glacier_ocean",
        description = unilib.brackets(S("Glacier ocean biome"), "ethereal"),
        node_dust = "unilib:snow_ordinary_block",
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        y_max = -9,
        y_min = -112,
        heat_point = 0,
        humidity_point = 50,
    })

end
