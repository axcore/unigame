---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_farlands_grassland_snowy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_farlands_grassland_snowy.init()

    return {
        description = "Snowy grassland biomes",
        depends = {"dirt_ordinary", "sand_ordinary", "snow_ordinary"},
    }

end

function unilib.pkg.biome_farlands_grassland_snowy.post()

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "snowy_grassland" biome
        name = "farlands_grassland_snowy",
        description = unilib.brackets(S("Snowy grassland biome"), "farlands"),
        node_dust = "unilib:snow_ordinary",
        node_top = "unilib:dirt_ordinary_with_cover_snow",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 1,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = unilib.y_max,
        y_min = 5,
        heat_point = 20,
        humidity_point = 35,
    })

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "snowy_grassland_ocean" biome
        name = "farlands_grassland_snowy_ocean",
        description = unilib.brackets(S("Snowy grassland ocean biome"), "farlands"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = 4,
        y_min = -112,
        heat_point = 20,
        humidity_point = 35,
    })

end
