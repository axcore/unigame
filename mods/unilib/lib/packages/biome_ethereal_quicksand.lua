---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_quicksand = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_quicksand.init()

    return {
        description = "Quicksand biome",
        depends = {"gravel_ordinary", "sand_quicksand", "stone_ordinary"},
    }

end

function unilib.pkg.biome_ethereal_quicksand.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "quicksand" biome
        name = "ethereal_quicksand",
        description = unilib.brackets(S("Quicksand biome"), "ethereal"),
        node_top = "unilib:sand_quicksand",
        depth_top = 3,
        node_filler = "unilib:gravel_ordinary",
        depth_filler = 1,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 1,
        y_min = 1,
        heat_point = 50,
        humidity_point = 38,
    })

end
