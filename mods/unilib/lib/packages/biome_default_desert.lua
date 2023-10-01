---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_default_desert = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_default_desert.init()

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

function unilib.pkg.biome_default_desert.post()

    unilib.register_biome({
        -- From default/mapgen.lua, "desert" biome
        name = "default_desert",
        description = unilib.brackets(S("Desert biome"), "default"),
        node_top = "unilib:sand_desert",
        depth_top = 1,
        node_filler = "unilib:sand_desert",
        depth_filler = 1,
        node_stone = "unilib:stone_desert",
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_desert",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_desert"),
        y_max = unilib.y_max,
        y_min = 4,
        heat_point = 92,
        humidity_point = 16,
    })

    unilib.register_biome({
        -- From default/mapgen.lua, "desert_ocean" biome
        name = "default_desert_ocean",
        description = unilib.brackets(S("Desert ocean biome"), "default"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_desert",
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_cave_liquid = "unilib:liquid_water_ordinary_source",
        node_dungeon = "unilib:stone_desert",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_desert"),
        vertical_blend = 1,
        y_max = 3,
        y_min = -255,
        heat_point = 92,
        humidity_point = 16,
    })

    unilib.register_biome({
        -- From default/mapgen.lua, "desert_under" biome
        name = "default_desert_under",
        description = unilib.brackets(S("Desert deep ocean biome"), "default"),
        node_cave_liquid = {
            "unilib:liquid_water_ordinary_source",
            "unilib:liquid_lava_ordinary_source",
        },
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = -256,
        y_min = unilib.y_min,
        heat_point = 92,
        humidity_point = 16,
    })

end
