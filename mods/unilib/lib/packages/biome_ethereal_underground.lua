---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_ethereal_underground = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_ethereal_underground.init()

    return {
        description = "Underground biome",
        depends = "stone_ordinary",
    }

end

function unilib.pkg.biome_ethereal_underground.post()

    unilib.register_biome({
        -- From ethereal-ng/biomes.lua, "underground" biome
        name = "ethereal_underground",
        description = unilib.brackets(S("Underground biome"), "ethereal"),
        node_dungeon = "unilib:stone_ordinary_cobble",
        node_dungeon_alt = "unilib:stone_ordinary_cobble_mossy",
        node_dungeon_stair = unilib.convert_stairs_simple("unilib:stone_ordinary_cobble"),
        y_max = -192,
        y_min = unilib.y_min,
        heat_point = 50,
        humidity_point = 50,
    })

end
