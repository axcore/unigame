---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_swamp = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_swamp.init()

    return {
        description = "Swamp biomes",
        depends = {
            "clay_ordinary",
            "dirt_ordinary",
            "sand_ordinary",
            "sand_quicksand",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.biome_ethereal_swamp.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "swamp" biome
        name = "ethereal_swamp",
        description = unilib.utils.brackets(S("Swamp biome"), "ethereal"),
        node_top = "unilib:dirt_ordinary_with_turf",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = 7,
        y_min = 1,
        vertical_blend = 1,
        heat_point = 80,
        humidity_point = 90,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "swamp_beach" biome
        name = "ethereal_swamp_beach",
        description = unilib.utils.brackets(S("Swamp beach biome"), "ethereal"),
        node_top = "unilib:sand_quicksand",
        depth_top = 3,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = 0,
        y_min = -1,
        vertical_blend = 1,
        heat_point = 80,
        humidity_point = 90,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "swamp_ocean" biome
        name = "ethereal_swamp_ocean",
        description = unilib.utils.brackets(S("Swamp ocean biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 2,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = 1,
        y_min = -192,
        vertical_blend = 2,
        heat_point = 80,
        humidity_point = 90,
    })

end
