---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_plains = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_plains.init()

    return {
        description = "Plains biomes",
        depends = {"dirt_dried", "dirt_ordinary", "sand_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.biome_ethereal_plains.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "plains" biome
        name = "ethereal_plains",
        description = unilib.utils.brackets(S("Plains biome"), "ethereal"),
        node_top = "unilib:dirt_dried",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:dirt_dried",
        node_dungeon_alt = "",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:dirt_dried"),
        y_max = 25,
        y_min = 3,
        vertical_blend = 1,
        heat_point = 74,
        humidity_point = 23,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "plains_ocean" biome
        name = "ethereal_plains_ocean",
        description = unilib.utils.brackets(S("Plains ocean biome"), "ethereal"),
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
        heat_point = 74,
        humidity_point = 23,
    })

end
