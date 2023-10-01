---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_farlands_icesheet = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_farlands_icesheet.init()

    return {
        description = "Icesheet biomes",
        depends = {"gravel_ordinary", "ice_ordinary", "sand_ordinary", "snow_ordinary"},
    }

end

function unilib.pkg.biome_farlands_icesheet.post()

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "icesheet" biome
        name = "farlands_icesheet",
        description = unilib.brackets(S("Ice sheet biome"), "farlands"),
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
        y_max = unilib.y_max,
        y_min = -8,
        heat_point = 0,
        humidity_point = 73,
    })

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "icesheet_ocean" biome
        name = "farlands_icesheet_ocean",
        description = unilib.brackets(S("Ice sheet ocean biome"), "farlands"),
        node_dust = "unilib:snow_ordinary_block",
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_water_top = "unilib:ice_ordinary",
        depth_water_top = 10,
        y_max = -9,
        y_min = -112,
        heat_point = 0,
        humidity_point = 73,
    })

end
