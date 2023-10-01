---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_caves = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_caves.init()

    return {
        description = "Cave biome",
        depends = {"stone_desert", "stone_ordinary"},
    }

end

function unilib.pkg.biome_ethereal_caves.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "caves" biome
        name = "ethereal_caves",
        description = unilib.brackets(S("Cave biome"), "ethereal"),
        node_top = "unilib:stone_desert",
        depth_top = 3,
        node_filler = "air",
        depth_filler = 8,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 41,
        y_min = 4,
        heat_point = 15,
        humidity_point = 25,
    })

end
