---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_glacier = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_glacier.init()

    return {
        description = "Glacier biomes",
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

function unilib.pkg.biome_ethereal_glacier.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "glacier" biome
        name = "ethereal_glacier",
        description = unilib.utils.brackets(S("Glacier biome"), "ethereal"),
        node_dust = "unilib:snow_ordinary_block",
        node_top = "unilib:snow_ordinary_block",
        depth_top = 1,
        node_filler = "unilib:snow_ordinary_block",
        depth_filler = 3,
        node_stone = "unilib:ice_ordinary",
        node_water_top = "unilib:ice_ordinary",
        depth_water_top = 10,
        node_river_water = "unilib:ice_ordinary",
        node_riverbed = "unilib:gravel_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:ice_ordinary_brick",
        node_dungeon_alt = "",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:ice_ordinary"),
        y_max = unilib.constant.y_max,
        y_min = -8,
        heat_point = 0,
        humidity_point = 73,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "glacier_ocean" biome
        name = "ethereal_glacier_ocean",
        description = unilib.utils.brackets(S("Glacier ocean biome"), "ethereal"),
        node_dust = "unilib:snow_ordinary_block",
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 3,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = -9,
        y_min = -112,
        heat_point = 0,
        humidity_point = 73,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "glacier_under" biome
        name = "ethereal_glacier_under",
        description = unilib.utils.brackets(S("Glacier underground biome"), "ethereal"),
        node_cave_liquid = {
            "unilib:liquid_water_ordinary_source", "unilib:liquid_lava_ordinary_source",
        },
        node_dungeon = "unilib:stone_ordinary_cobble",
        -- N.B. Empty string in original code
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = -256,
        y_min = unilib.constant.y_min,
        heat_point = 0,
        humidity_point = 73,
    })

end
