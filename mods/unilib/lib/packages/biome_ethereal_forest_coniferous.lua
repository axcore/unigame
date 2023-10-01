---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_forest_coniferous = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_forest_coniferous.init()

    return {
        description = "Coniferous forest biome",
        depends = {"dirt_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.biome_ethereal_forest_coniferous.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "coniferous_forest" biome
        name = "ethereal_forest_coniferous",
        description = unilib.brackets(S("Coniferous forest biome"), "ethereal"),
        node_top = "unilib:dirt_ordinary_with_litter_coniferous",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 40,
        y_min = 4,
        heat_point = 10,
        humidity_point = 40,
    })

end
