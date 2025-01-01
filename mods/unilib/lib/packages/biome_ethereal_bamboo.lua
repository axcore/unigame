---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_bamboo = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_bamboo.init()

    return {
        description = "Bamboo biome",
        depends = {
            "dirt_ordinary",
            "dirt_ordinary_with_turf_bamboo",
            "sand_ordinary",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.biome_ethereal_bamboo.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "bamboo" biome
        name = "ethereal_bamboo",
        description = unilib.utils.brackets(S("Bamboo biome"), "ethereal"),
        node_top = "unilib:dirt_ordinary_with_turf_bamboo",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = 70,
        y_min = 3,
        vertical_blend = 1,
        heat_point = 45,
        humidity_point = 45,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "bamboo_ocean" biome
        name = "ethereal_bamboo_ocean",
        description = unilib.utils.brackets(S("Bamboo ocean biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 2,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = 2,
        y_min = -192,
        heat_point = 45,
        humidity_point = 45,
    })

end
