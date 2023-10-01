---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_default_icesheet = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_default_icesheet.init()

    return {
        description = "Icesheet biomes",
        depends = {
            "gravel_ordinary",
            "ice_ordinary",
            "liquid_lava_ordinary",
            "liquid_water_ordinary",
            "sand_ordinary",
            "snow_ordinary",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.biome_default_icesheet.post()

    unilib.register_biome({
        -- From default/mapgen.lua, "icesheet" biome
        name = "default_icesheet",
        description = unilib.brackets(S("Ice sheet biome"), "default"),
        node_dust = "unilib:snow_ordinary_block",
        node_top = "unilib:snow_ordinary_block",
        depth_top = 1,
        node_filler = "unilib:snow_ordinary_block",
        depth_filler = 3,
        node_stone = "unilib:ice_ordinary_cave",
        node_water_top = "unilib:ice_ordinary",
        depth_water_top = 10,
        node_river_water = "unilib:ice_ordinary",
        node_riverbed = "unilib:gravel_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:ice_ordinary",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:ice_ordinary"),
        y_max = unilib.y_max,
        y_min = -8,
        heat_point = 0,
        humidity_point = 73,
    })

    unilib.register_biome({
        -- From default/mapgen.lua, "icesheet_ocean" biome
        name = "default_icesheet_ocean",
        description = unilib.brackets(S("Ice sheet ocean biome"), "default"),
        node_dust = "unilib:snow_ordinary_block",
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_water_top = "unilib:ice_ordinary",
        depth_water_top = 10,
        node_cave_liquid = "unilib:liquid_water_ordinary_source",
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = -9,
        y_min = -255,
        heat_point = 0,
        humidity_point = 73,
    })

    unilib.register_biome({
        -- From default/mapgen.lua, "icesheet_under" biome
        name = "default_icesheet_under",
        description = unilib.brackets(S("Ice sheet deep ocean biome"), "default"),
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
        humidity_point = 73,
    })

end
