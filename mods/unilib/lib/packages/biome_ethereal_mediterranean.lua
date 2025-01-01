---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_mediterranean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_mediterranean.init()

    return {
        description = "Mediterranean biome",
        depends = {
            "dirt_ordinary",
            "dirt_ordinary_with_turf_grove",
            "sand_ordinary",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.biome_ethereal_mediterranean.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "mediterranean" biome
        name = "ethereal_mediterranean",
        description = unilib.utils.brackets(S("Mediterranean biome"), "ethereal"),
        node_top = "unilib:dirt_ordinary_with_turf_grove",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_ordinary_cobble"),
        y_max = 50,
        y_min = 3,
        vertical_blend = 1,
        heat_point = 30,
        humidity_point = 45,
    })

end
