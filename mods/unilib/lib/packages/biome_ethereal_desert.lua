---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_desert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_desert.init()

    return {
        description = "Desert biomes",
        depends = {
            "liquid_lava_ordinary",
            "liquid_water_ordinary",
            "sand_desert",
            "sand_ordinary",
            "stone_desert",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.biome_ethereal_desert.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "desert" biome
        name = "ethereal_desert",
        description = unilib.utils.brackets(S("Desert biome"), "ethereal"),
        node_top = "unilib:sand_desert",
        depth_top = 1,
        node_filler = "unilib:sand_desert",
        depth_filler = 3,
        node_stone = "unilib:stone_desert",
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_desert",
        node_dungeon_alt = "",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_desert"),
        y_max = 23,
        y_min = 3,
        vertical_blend = 1,
        heat_point = 92,
        humidity_point = 16,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "desert_ocean" biome
        name = "ethereal_desert_ocean",
        description = unilib.utils.brackets(S("Desert ocean biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 2,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_stone = "unilib:stone_desert",
        node_dungeon = "unilib:stone_desert",
        node_dungeon_alt = "",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_desert"),
        y_max = 3,
        y_min = -192,
        heat_point = 92,
        humidity_point = 16,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "desert_under" biome
        name = "ethereal_desert_under",
        description = unilib.utils.brackets(S("Desert underground biome"), "ethereal"),
        node_cave_liquid = {
            "unilib:liquid_water_ordinary_source", "unilib:liquid_lava_ordinary_source",
        },
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = -256,
        y_min = unilib.constant.y_min,
        heat_point = 92,
        humidity_point = 16,
    })

end
