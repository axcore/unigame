---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_default_taiga = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_default_taiga.init()

    return {
        description = "Taiga biomes",
        depends = {
            "dirt_ordinary",
            "liquid_lava_ordinary",
            "liquid_water_ordinary",
            "sand_ordinary",
            "snow_ordinary",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.biome_default_taiga.post()

    unilib.register_biome({
        -- From default/mapgen.lua, "taiga" biome
        name = "default_taiga",
        description = unilib.brackets(S("Taiga biome"), "default"),
        node_dust = "unilib:snow_ordinary",
        node_top = "unilib:dirt_ordinary_with_cover_snow",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = unilib.y_max,
        y_min = 4,
        heat_point = 25,
        humidity_point = 70,
    })

    unilib.register_biome({
        -- From default/mapgen.lua, "taiga_ocean" biome
        name = "default_taiga_ocean",
        description = unilib.brackets(S("Taiga ocean biome"), "default"),
        node_dust = "unilib:snow_ordinary",
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
        heat_point = 25,
        humidity_point = 70,
    })

    unilib.register_biome({
        -- From default/mapgen.lua, "taiga_under" biome
        name = "default_taiga_under",
        description = unilib.brackets(S("Taiga deep ocean biome"), "default"),
        node_cave_liquid = {
            "unilib:liquid_water_ordinary_source",
            "unilib:liquid_lava_ordinary_source",
        },
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = -256,
        y_min = unilib.y_min,
        heat_point = 25,
        humidity_point = 70,
    })

end
