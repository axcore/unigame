---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_farlands_desert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_farlands_desert.init()

    return {
        description = "Desert biomes",
        depends = {"sand_desert", "sand_ordinary", "stone_desert"},
    }

end

function unilib.pkg.biome_farlands_desert.post()

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "desert" biome
        name = "farlands_desert",
        description = unilib.utils.brackets(S("Desert biome"), "farlands"),
        node_top = "unilib:sand_desert",
        depth_top = 1,
        node_filler = "unilib:sand_desert",
        depth_filler = 1,
        node_stone = "unilib:stone_desert",
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = unilib.constant.y_max,
        y_min = 5,
        heat_point = 92,
        humidity_point = 16,
    })

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "desert_ocean" biome
        name = "farlands_desert_ocean",
        description = unilib.utils.brackets(S("Desert ocean biome"), "farlands"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_desert",
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = 4,
        y_min = -112,
        heat_point = 92,
        humidity_point = 16,
    })

end
