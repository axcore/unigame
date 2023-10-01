---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_rainforest = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_rainforest.init()

    return {
        description = "Rainforest biomes",
        depends = {"dirt_ordinary", "sand_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.biome_ethereal_rainforest.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "junglee" biome
        name = "ethereal_rainforest",
        description = unilib.brackets(S("Rainforest biome"), "ethereal"),
        node_top = "unilib:dirt_ordinary_with_litter_rainforest",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 71,
        y_min = 1,
        heat_point = 30,
        humidity_point = 60,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "junglee_ocean" biome
        name = "ethereal_rainforest_ocean",
        description = unilib.brackets(S("Rainforest ocean biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 1,
        y_min = -192,
        heat_point = 30,
        humidity_point = 60,
    })

end
