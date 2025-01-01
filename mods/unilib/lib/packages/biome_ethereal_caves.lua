---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_caves = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_caves.init()

    return {
        description = "Cave biome",
        depends = {"sand_ordinary", "stone_desert"},
    }

end

function unilib.pkg.biome_ethereal_caves.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "caves" biome
        name = "ethereal_caves",
        description = unilib.utils.brackets(S("Cave biome"), "ethereal"),
        node_top = "unilib:stone_desert",
        depth_top = 3,
        node_filler = "air",
        depth_filler = 8,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        node_dungeon = "unilib:stone_desert_cobble",
        node_dungeon_alt = "",
        node_dungeon_stair = unilib.stairs.convert_simple("unilib:stone_desert_cobble"),
        y_max = 41,
        y_min = 4,
        vertical_blend = 1,
        heat_point = 70,
        humidity_point = 5,
    })

end
