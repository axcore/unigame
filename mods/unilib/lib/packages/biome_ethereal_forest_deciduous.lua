---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_forest_deciduous = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_forest_deciduous.init()

    return {
        description = "Deciduous forest biomes",
        depends = {"dirt_ordinary", "gravel_ordinary", "sand_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.biome_ethereal_forest_deciduous.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "deciduous_forest" biome
        name = "ethereal_forest_deciduous",
        description = unilib.brackets(S("Deciduous forest biome"), "ethereal"),
        node_top = "unilib:dirt_ordinary_with_turf",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 91,
        y_min = 3,
        heat_point = 13,
        humidity_point = 40,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "deciduous_forest_ocean" biome
        name = "ethereal_forest_deciduous_ocean",
        description = unilib.brackets(S("Deciduous forest ocean biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 2,
        node_filler = "unilib:gravel_ordinary",
        depth_filler = 1,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 3,
        y_min = unilib.y_min,
        heat_point = 13,
        humidity_point = 40,
    })

end
