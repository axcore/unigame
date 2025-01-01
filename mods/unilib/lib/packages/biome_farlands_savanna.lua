---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_farlands_savanna = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_farlands_savanna.init()

    return {
        description = "Savanna biomes",
        depends = {"dirt_ordinary", "sand_ordinary", "stone_savanna"},
    }

end

function unilib.pkg.biome_farlands_savanna.post()

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "savanna" biome
        name = "farlands_savanna",
        description = unilib.utils.brackets(S("Savanna biome"), "farlands"),
        node_top = "unilib:dirt_ordinary_with_turf_dry",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 1,
        node_stone = "unilib:stone_savanna",
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = unilib.constant.y_max,
        y_min = 1,
        heat_point = 89,
        humidity_point = 42,
    })

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "savanna_shore" biome
        name = "farlands_savanna_shore",
        description = unilib.utils.brackets(S("Savanna shore biome"), "farlands"),
        node_top = "unilib:dirt_ordinary",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = 0,
        y_min = -1,
        heat_point = 89,
        humidity_point = 42,
    })

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "savanna_ocean" biome
        name = "farlands_savanna_ocean",
        description = unilib.utils.brackets(S("Savanna ocean biome"), "farlands"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = -2,
        y_min = -112,
        heat_point = 89,
        humidity_point = 42,
    })

end
