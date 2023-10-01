---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_taiga = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_taiga.init()

    return {
        description = "Taiga biome",
        depends = {"dirt_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.biome_ethereal_taiga.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "taiga" biome
        name = "ethereal_taiga",
        description = unilib.brackets(S("Taiga biome"), "ethereal"),
        node_top = "unilib:dirt_ordinary_with_cover_snow",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 2,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 140,
        y_min = 40,
        heat_point = 10,
        humidity_point = 40,
    })

end
