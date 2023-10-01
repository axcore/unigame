---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_farlands_forest_coniferous = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_farlands_forest_coniferous.init()

    return {
        description = "Coniferous forest biomes",
        depends = {"dirt_ordinary", "dirt_ordinary_with_litter_leafy", "sand_ordinary"},
    }

end

function unilib.pkg.biome_farlands_forest_coniferous.post()

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "coniferous_forest" biome
        name = "farlands_forest_coniferous",
        description = unilib.brackets(S("Coniferous forest biome"), "farlands"),
        node_top = "unilib:dirt_ordinary_with_turf",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = unilib.y_max,
        y_min = 6,
        heat_point = 45,
        humidity_point = 70,
    })

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "coniferous_forest_tall" biome
        name = "farlands_forest_coniferous_tall",
        description = unilib.brackets(S("Tall coniferous forest biome"), "farlands"),
        node_top = "unilib:dirt_ordinary_with_litter_leafy",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = unilib.y_max,
        y_min = 6,
        heat_point = 50,
        humidity_point = 70,
    })

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "coniferous_forest_dunes" biome
        name = "farlands_forest_coniferous_beach",
        description = unilib.brackets(S("Coniferous forest beach"), "farlands"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = 5,
        y_min = 5,
        heat_point = 45,
        humidity_point = 70,
    })

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "coniferous_forest_ocean" biome
        name = "farlands_forest_coniferous_ocean",
        description = unilib.brackets(S("Coniferous forest ocean biome"), "farlands"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = 4,
        y_min = -112,
        heat_point = 45,
        humidity_point = 70,
    })

end
