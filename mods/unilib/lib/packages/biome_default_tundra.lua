---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_default_tundra = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_default_tundra.init()

    return {
        description = "Tundra biomes",
        depends = {
            "dirt_permafrost",
            "gravel_ordinary",
            "liquid_lava_ordinary",
            "liquid_water_ordinary",
            "sand_ordinary",
            "snow_ordinary",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.biome_default_tundra.post()

    unilib.register_biome({
        -- From default/mapgen.lua, "tundra" biome
        name = "default_tundra",
        description = unilib.brackets(S("Tundra biome"), "default"),
        node_top = "unilib:dirt_permafrost_with_stonelet",
        depth_top = 1,
        node_filler = "unilib:dirt_permafrost",
        depth_filler = 1,
        node_riverbed = "unilib:gravel_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        vertical_blend = 4,
        y_max = 46,
        y_min = 2,
        heat_point = 0,
        humidity_point = 40,
    })

    unilib.register_biome({
        -- From default/mapgen.lua,"tundra_highland" biome
        name = "default_tundra_highland",
        description = unilib.brackets(S("Highland tundra biome"), "default"),
        node_dust = "unilib:snow_ordinary",
        node_riverbed = "unilib:gravel_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = unilib.y_max,
        y_min = 47,
        heat_point = 0,
        humidity_point = 40,
    })

    unilib.register_biome({
        -- From default/mapgen.lua, "tundra_beach" biome
        name = "default_tundra_beach",
        description = unilib.brackets(S("Tundra beach biome"), "default"),
        node_top = "unilib:gravel_ordinary",
        depth_top = 1,
        node_filler = "unilib:gravel_ordinary",
        depth_filler = 2,
        node_riverbed = "unilib:gravel_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        vertical_blend = 1,
        y_max = 1,
        y_min = -3,
        heat_point = 0,
        humidity_point = 40,
    })

    unilib.register_biome({
        -- From default/mapgen.lua, "tundra_ocean" biome
        name = "default_tundra_ocean",
        description = unilib.brackets(S("Tundra ocean biome"), "default"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:gravel_ordinary",
        depth_riverbed = 2,
        node_cave_liquid = "unilib:liquid_water_ordinary_source",
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        vertical_blend = 1,
        y_max = -4,
        y_min = -255,
        heat_point = 0,
        humidity_point = 40,
    })

    unilib.register_biome({
        -- From default/mapgen.lua, "tundra_under" biome
        name = "default_tundra_under",
        description = unilib.brackets(S("Tundra deep ocean biome"), "default"),
        node_cave_liquid = {
            "unilib:liquid_water_ordinary_source",
            "unilib:liquid_lava_ordinary_source",
        },
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = -256,
        y_min = unilib.y_min,
        heat_point = 0,
        humidity_point = 40,
    })

end
