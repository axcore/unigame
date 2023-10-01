---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_farlands_grassland = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_farlands_grassland.init()

    return {
        description = "Grassland biomes",
        depends = {"dirt_ordinary", "sand_ordinary"},
    }

end

function unilib.pkg.biome_farlands_grassland.post()

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "grassland" biome
        name = "farlands_grassland",
        description = unilib.brackets(S("Grassland biome"), "farlands"),
        node_top = "unilib:dirt_ordinary_with_turf",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 1,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = unilib.y_max,
        y_min = 6,
        heat_point = 50,
        humidity_point = 35,
    })

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "grassland_dunes" biome
        name = "farlands_grassland_beach",
        description = unilib.brackets(S("Grassland beach biome"), "farlands"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 2,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = 5,
        y_min = 5,
        heat_point = 50,
        humidity_point = 35,
    })

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "grassland_ocean" biome
        name = "farlands_grassland_ocean",
        description = unilib.brackets(S("Grassland ocean biome"), "farlands"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = 4,
        y_min = -112,
        heat_point = 50,
        humidity_point = 35,
    })

end
