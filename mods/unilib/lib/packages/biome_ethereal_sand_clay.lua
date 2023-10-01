---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_sand_clay = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_sand_clay.init()

    return {
        description = "Sand and clay biome",
        depends = {"clay_ordinary", "sand_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.biome_ethereal_sand_clay.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "sandclay" biome
        name = "ethereal_sand_clay",
        description = unilib.brackets(S("Sand and clay biome"), "ethereal"),
        node_top = "unilib:sand_ordinary",
        depth_top = 3,
        node_filler = "unilib:clay_ordinary",
        depth_filler = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 11,
        y_min = 1,
        heat_point = 65,
        humidity_point = 2,
    })

end
