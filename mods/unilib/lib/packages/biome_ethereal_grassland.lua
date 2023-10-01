---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_grassland = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_grassland.init()

    return {
        description = "Grassland biome",
        depends = {"dirt_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.biome_ethereal_grassland.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "grassland" biome
        name = "ethereal_grassland",
        description = unilib.brackets(S("Grassland biome"), "ethereal"),
        node_top = "unilib:dirt_ordinary_with_turf",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = 71,
        y_min = 3,
        heat_point = 45,
        humidity_point = 65,
    })

end
