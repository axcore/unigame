---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_mountain = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_mountain.init()

    return {
        description = "Mountain biome",
        depends = {"snow_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.biome_ethereal_mountain.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "mountain" biome
        name = "ethereal_mountain",
        description = unilib.brackets(S("Mountain biome"), "ethereal"),
        node_top = "unilib:snow_ordinary",
        depth_top = 1,
        node_filler = "unilib:snow_ordinary_block",
        depth_filler = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = unilib.y_max,
        y_min = 140,
        heat_point = 50,
        humidity_point = 50,
    })

end
