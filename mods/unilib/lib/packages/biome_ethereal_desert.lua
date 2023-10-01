---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_desert = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_desert.init()

    return {
        description = "Desert biomes",
        depends = {"sand_desert", "sand_ordinary", "stone_desert"},
    }

end

function unilib.pkg.biome_ethereal_desert.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "desert" biome
        name = "ethereal_desert",
        description = unilib.brackets(S("Desert biome"), "ethereal"),
        node_top = "unilib:sand_desert",
        depth_top = 1,
        node_filler = "unilib:sand_desert",
        depth_filler = 3,
        node_stone = "unilib:stone_desert",
        node_dungeon = "unilib:stone_desert",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_desert"),
        y_max = 23,
        y_min = 3,
        heat_point = 35,
        humidity_point = 20,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "desert_ocean" biome
        name = "ethereal_desert_ocean",
        description = unilib.brackets(S("Desert ocean biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 2,
        node_stone = "unilib:stone_desert",
        node_dungeon = "unilib:stone_desert",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_desert"),
        y_max = 3,
        y_min = -192,
        heat_point = 35,
        humidity_point = 20,
    })

end
