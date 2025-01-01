---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_sandstone_desert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_sandstone_desert.init()

    return {
        description = "Sandstone desert biomes",
        depends = {
            "liquid_lava_ordinary",
            "liquid_water_ordinary",
            "sand_ordinary",
            "stone_sandstone_ordinary",
        },
    }

end

function unilib.pkg.biome_ethereal_sandstone_desert.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "sandstone_desert" biome
        name = "ethereal_sandstone_desert",
        description = unilib.utils.brackets(S("Sandstone desert biome"), "ethereal"),
        node_top = "unilib:stone_sandstone_ordinary",
        depth_top = 1,
        node_filler = "unilib:stone_sandstone_ordinary",
        depth_filler = 1,
        node_stone = "unilib:stone_sandstone_ordinary",
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_sandstone_ordinary",
        node_dungeon_alt = "",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_sandstone_ordinary"),
        y_max = 23,
        y_min = 3,
        vertical_blend = 1,
        heat_point = 60,
        humidity_point = 0,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "sandstone_desert_ocean" biome
        name = "ethereal_sandstone_desert_ocean",
        description = unilib.utils.brackets(S("Sandstone desert ocean biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 2,
        node_stone = "unilib:stone_sandstone_ordinary",
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_sandstone_ordinary",
        node_dungeon_alt = "",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_sandstone_ordinary"),
        y_max = 2,
        y_min = -192,
        heat_point = 60,
        humidity_point = 0,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "sandstone_desert_under" biome
        name = "ethereal_sandstone_desert_under",
        description = unilib.utils.brackets(S("Sandstone desert underground biome"), "ethereal"),
        node_cave_liquid = {
            "unilib:liquid_water_ordinary_source", "unilib:liquid_lava_ordinary_source",
        },
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = -256,
        y_min = unilib.constant.y_min,
        heat_point = 60,
        humidity_point = 0,
    })

end
