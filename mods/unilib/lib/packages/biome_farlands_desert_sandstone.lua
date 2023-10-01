---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_farlands_desert_sandstone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_farlands_desert_sandstone.init()

    return {
        description = "Sandstone desert biomes",
        depends = {"sand_ordinary", "stone_sandstone_ordinary"},
    }

end

function unilib.pkg.biome_farlands_desert_sandstone.post()

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "sandstone_desert" biome
        name = "farlands_desert_sandstone",
        description = unilib.brackets(S("Sandstone desert biome"), "farlands"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 0,
        node_stone = "unilib:stone_sandstone_ordinary",
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = unilib.y_max,
        y_min = 5,
        heat_point = 60,
        humidity_point = 0,
    })

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "sandstone_desert_ocean" biome
        name = "farlands_desert_sandstone_ocean",
        description = unilib.brackets(S("Sandstone desert ocean biome"), "farlands"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_ordinary",
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = 4,
        y_min = -112,
        heat_point = 60,
        humidity_point = 0,
    })

end
