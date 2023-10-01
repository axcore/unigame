---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_default_desert_cold = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_default_desert_cold.init()

    return {
        description = "Cold desert biomes",
        depends = {
            "liquid_lava_ordinary",
            "liquid_water_ordinary",
            "sand_ordinary",
            "sand_silver",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.biome_default_desert_cold.post()

    unilib.register_biome({
        -- From default/mapgen.lua, "cold_desert" biome
        name = "default_desert_cold",
        description = unilib.brackets(S("Cold desert biome"), "default"),
        node_top = "unilib:sand_silver",
        depth_top = 1,
        node_filler = "unilib:sand_silver",
        depth_filler = 1,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = unilib.y_max,
        y_min = 4,
        heat_point = 40,
        humidity_point = 0,
    })

    unilib.register_biome({
        -- From default/mapgen.lua, "cold_desert_ocean" biome
        name = "default_desert_cold_ocean",
        description = unilib.brackets(S("Cold desert ocean biome"), "default"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_cave_liquid = "unilib:liquid_water_ordinary_source",
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        vertical_blend = 1,
        y_max = 3,
        y_min = -255,
        heat_point = 40,
        humidity_point = 0,
    })

    unilib.register_biome({
        -- From default/mapgen.lua, "cold_desert_under" biome
        name = "default_desert_cold_under",
        description = unilib.brackets(S("Cold desert deep ocean biome"), "default"),
        node_cave_liquid = {
            "unilib:liquid_water_ordinary_source",
            "unilib:liquid_lava_ordinary_source",
        },
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = -256,
        y_min = unilib.y_min,
        heat_point = 40,
        humidity_point = 0,
    })

end
