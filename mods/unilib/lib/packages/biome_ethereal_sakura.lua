---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_sakura = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_sakura.init()

    return {
        description = "Sakura biomes",
        depends = {
            "dirt_ordinary",
            "dirt_ordinary_with_turf_bamboo",
            "sand_ordinary",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.biome_ethereal_sakura.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "sakura" biome
        name = "ethereal_sakura",
        description = unilib.brackets(S("Sakura biome"), "ethereal"),
        node_top = "unilib:dirt_ordinary_with_turf_bamboo",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 25,
        y_min = 3,
        heat_point = 45,
        humidity_point = 75,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "sakura_ocean" biome
        name = "ethereal_sakura_ocean",
        description = unilib.brackets(S("Sakura ocean biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 2,
        y_min = -192,
        heat_point = 45,
        humidity_point = 75,
    })

end
