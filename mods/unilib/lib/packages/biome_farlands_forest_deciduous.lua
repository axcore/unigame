---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_farlands_forest_deciduous = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_farlands_forest_deciduous.init()

    return {
        description = "Deciduous forest biomes",
        depends = {"dirt_ordinary", "sand_ordinary"},
    }

end

function unilib.pkg.biome_farlands_forest_deciduous.post()

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "deciduous_forest" biome
        name = "farlands_forest_deciduous",
        description = unilib.brackets(S("Deciduous forest biome"), "farlands"),
        node_top = "unilib:dirt_ordinary_with_turf",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = unilib.y_max,
        y_min = 1,
        heat_point = 60,
        humidity_point = 68,
    })

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "deciduous_forest2" biome
        -- N.B. Trees spawning in this biome are not particularly tall; but the set of coniferous
        --      biomes has a "_tall" biome, so we use a similar name in this case
        name = "farlands_forest_deciduous_tall",
        description = unilib.brackets(S("Tall deciduous forest biome"), "farlands"),
        node_top = "unilib:dirt_ordinary_with_turf",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = unilib.y_max,
        y_min = 1,
        heat_point = 62,
        humidity_point = 70,
    })

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "deciduous_forest_shore" biome
        name = "farlands_forest_deciduous_shore",
        description = unilib.brackets(S("Deciduous forest shore biome"), "farlands"),
        node_top = "unilib:dirt_ordinary",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = 0,
        y_min = -1,
        heat_point = 60,
        humidity_point = 68,
    })

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "deciduous_forest_ocean" biome
        name = "farlands_forest_deciduous_ocean",
        description = unilib.brackets(S("Deciduous forest ocean biome"), "farlands"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = -2,
        y_min = -112,
        heat_point = 60,
        humidity_point = 68,
    })

end
