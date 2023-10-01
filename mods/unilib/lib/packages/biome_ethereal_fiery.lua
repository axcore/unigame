---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_fiery = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_fiery.init()

    return {
        description = "Fiery biomes",
        depends = {
            "dirt_ordinary",
            "dirt_ordinary_with_turf_fiery",
            "sand_ordinary",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.biome_ethereal_fiery.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "fiery" biome
        name = "ethereal_fiery",
        description = unilib.brackets(S("Fiery biome"), "ethereal"),
        node_top = "unilib:dirt_ordinary_with_turf_fiery",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 20,
        y_min = 5,
        heat_point = 75,
        humidity_point = 10,
    })

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "fiery_ocean" biome
        name = "ethereal_fiery_ocean",
        description = unilib.brackets(S("Fiery ocean biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 1,
        node_filler = "unilib:sand_ordinary",
        depth_filler = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 4,
        y_min = -192,
        heat_point = 75,
        humidity_point = 10,
    })

end
