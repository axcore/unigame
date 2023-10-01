---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_farlands_tundra = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_farlands_tundra.init()

    return {
        description = "Tundra biomes",
        depends = {"gravel_ordinary", "sand_ordinary", "snow_ordinary"},
    }

end

function unilib.pkg.biome_farlands_tundra.post()

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "tundra" biome
        name = "farlands_tundra",
        description = unilib.brackets(S("Tundra biome"), "farlands"),
        node_dust = "unilib:snow_ordinary_block",
        node_riverbed = "unilib:gravel_ordinary",
        depth_riverbed = 2,
        y_max = unilib.y_max,
        y_min = 2,
        heat_point = 0,
        humidity_point = 40,
    })

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "tundra_beach" biome
        name = "farlands_tundra_beach",
        description = unilib.brackets(S("Tundra beach biome"), "farlands"),
        node_top = "unilib:gravel_ordinary",
        depth_top = 1,
        node_filler = "unilib:gravel_ordinary",
        depth_filler = 2,
        node_riverbed = "unilib:gravel_ordinary",
        depth_riverbed = 2,
        y_max = 1,
        y_min = -3,
        heat_point = 0,
        humidity_point = 40,
    })

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "tundra_ocean" biome
        name = "farlands_tundra_ocean",
        description = unilib.brackets(S("Tundra ocean biome"), "farlands"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:gravel_ordinary",
        depth_riverbed = 2,
        y_max = -4,
        y_min = -112,
        heat_point = 0,
        humidity_point = 40,
    })

end
