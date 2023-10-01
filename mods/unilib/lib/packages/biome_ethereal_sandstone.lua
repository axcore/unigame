---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_sandstone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_sandstone.init()

    return {
        description = "Sandstone biomes",
        depends = {"sand_ordinary", "stone_sandstone_ordinary"},
    }

end

function unilib.pkg.biome_ethereal_sandstone.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "sandstone" biome
        name = "ethereal_sandstone",
        description = unilib.brackets(S("Sandstone biome"), "ethereal"),
        node_top = "unilib:stone_sandstone_ordinary",
        depth_top = 1,
        node_filler = "unilib:stone_sandstone_ordinary",
        depth_filler = 1,
        node_stone = "unilib:stone_sandstone_ordinary",
        node_dungeon = "unilib:stone_sandstone_ordinary",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_sandstone_ordinary"),
        y_max = 23,
        y_min = 3,
        heat_point = 50,
        humidity_point = 20,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "sandstone_ocean" biome
        name = "ethereal_sandstone_ocean",
        description = unilib.brackets(S("Sandstone ocean biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 2,
        node_stone = "unilib:stone_sandstone_ordinary",
        node_dungeon = "unilib:stone_sandstone_ordinary",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_sandstone_ordinary"),
        y_max = 2,
        y_min = -192,
        heat_point = 50,
        humidity_point = 20,
    })

end
