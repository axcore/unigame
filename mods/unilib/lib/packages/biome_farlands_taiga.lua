---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_farlands_taiga = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_farlands_taiga.init()

    return {
        description = "Taiga biomes",
        depends = {"dirt_ordinary", "sand_ordinary", "snow_ordinary"},
    }

end

function unilib.pkg.biome_farlands_taiga.post()

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "taiga" biome
        name = "farlands_taiga",
        description = unilib.utils.brackets(S("Taiga biome"), "farlands"),
        node_dust = "unilib:snow_ordinary",
        node_top = "unilib:dirt_ordinary_with_cover_snow",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = unilib.constant.y_max,
        y_min = 2,
        heat_point = 25,
        humidity_point = 70,
    })

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "taiga_ocean" biome
        name = "farlands_taiga_ocean",
        description = unilib.utils.brackets(S("Taiga ocean biome"), "farlands"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = 1,
        y_min = -112,
        heat_point = 25,
        humidity_point = 70,
    })

end
