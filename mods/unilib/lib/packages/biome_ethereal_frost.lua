---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_frost = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_frost.init()

    return {
        description = "Frost biomes",
        depends = {
            "dirt_ordinary",
            "dirt_ordinary_with_turf_crystal",
            "sand_ordinary",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.biome_ethereal_frost.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "frost" biome
        name = "ethereal_frost",
        description = unilib.brackets(S("Frost biome"), "ethereal"),
        node_top = "unilib:dirt_ordinary_with_turf_crystal",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 71,
        y_min = 1,
        heat_point = 10,
        humidity_point = 40,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "frost_ocean" biome
        name = "ethereal_frost_ocean",
        description = unilib.brackets(S("Frost ocean biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 1,
        y_min = -192,
        heat_point = 10,
        humidity_point = 40,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "frost_floatland" biome
        name = "ethereal_frost_floatland",
        node_top = "unilib:dirt_ordinary_with_turf_crystal",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 1,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 1750,
        y_min = 1025,
        heat_point = 10,
        humidity_point = 40,
    })

end
