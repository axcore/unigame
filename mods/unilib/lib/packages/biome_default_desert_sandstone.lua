---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_default_desert_sandstone = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_default_desert_sandstone.init()

    return {
        description = "Sandstone desert biomes",
        depends = {
            "liquid_lava_ordinary",
            "liquid_water_ordinary",
            "sand_ordinary",
            "stone_ordinary",
            "stone_sandstone_ordinary",
        },
    }

end

function unilib.pkg.biome_default_desert_sandstone.post()

    unilib.register_biome({
        -- From default/mapgen.lua, "sandstone_desert" biome
        name = "default_desert_sandstone",
        description = unilib.utils.brackets(S("Desert sandstone biome"), "default"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 1,
        node_stone = "unilib:stone_sandstone_ordinary",
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_sandstone_ordinary_brick",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_sandstone_ordinary_block"),
        y_max = unilib.constant.y_max,
        y_min = 4,
        heat_point = 60,
        humidity_point = 0,
    })

    unilib.register_biome({
        -- From default/mapgen.lua, "sandstone_desert_ocean" biome
        name = "default_desert_sandstone_ocean",
        description = unilib.utils.brackets(S("Desert sandstone ocean biome"), "default"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_stone = "unilib:stone_sandstone_ordinary",
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_cave_liquid = "unilib:liquid_water_ordinary_source",
        node_dungeon = "unilib:stone_sandstone_ordinary_brick",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_sandstone_ordinary_block"),
        y_max = 3,
        y_min = -255,
        heat_point = 60,
        humidity_point = 0,
    })

    unilib.register_biome({
        -- From default/mapgen.lua, "sandstone_desert_under" biome
        name = "default_desert_sandstone_under",
        description = unilib.utils.brackets(S("Desert sandstone deep ocean biome"), "default"),
        node_cave_liquid = {
            "unilib:liquid_water_ordinary_source",
            "unilib:liquid_lava_ordinary_source",
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
