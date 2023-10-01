---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_mushroom = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_mushroom.init()

    return {
        description = "Mushroom biomes",
        depends = {
            "dirt_ordinary",
            "dirt_ordinary_with_turf_mushroom",
            "sand_ordinary",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.biome_ethereal_mushroom.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "mushroom" biome
        name = "ethereal_mushroom",
        description = unilib.brackets(S("Mushroom biome"), "ethereal"),
        node_top = "unilib:dirt_ordinary_with_turf_mushroom",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 50,
        y_min = 3,
        heat_point = 45,
        humidity_point = 55,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "mushroom_ocean" biome
        name = "ethereal_mushroom_ocean",
        description = unilib.brackets(S("Mushroom ocean biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 2,
        y_min = -192,
        heat_point = 45,
        humidity_point = 55,
    })

end
