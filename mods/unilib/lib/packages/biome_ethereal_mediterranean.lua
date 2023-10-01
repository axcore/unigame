---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_mediterranean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_mediterranean.init()

    return {
        description = "Mediterranean biome",
        depends = {"dirt_ordinary", "dirt_ordinary_with_turf_grove", "stone_ordinary"},
    }

end

function unilib.pkg.biome_ethereal_mediterranean.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "mediterranean" biome
        name = "ethereal_mediterranean",
        description = unilib.brackets(S("Mediterranean biome"), "ethereal"),
        node_top = "unilib:dirt_ordinary_with_turf_grove",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 50,
        y_min = 3,
        heat_point = 20,
        humidity_point = 45,
    })

end
