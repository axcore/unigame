---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_farlands_forest_bamboo = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_farlands_forest_bamboo.init()

    return {
        description = "Bamboo forest biome",
        depends = {"dirt_ordinary", "sand_ordinary"},
    }

end

function unilib.pkg.biome_farlands_forest_bamboo.post()

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "bamboo_forest" biome
        name = "farlands_forest_bamboo",
        description = unilib.utils.brackets(S("Bamboo forest biome"), "farlands"),
        node_top = "unilib:dirt_ordinary_with_turf",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 1,
        node_riverbed = "unilib:sand_ordinary",
        depth_riverbed = 2,
        y_max = unilib.constant.y_max,
        y_min = 6,
        heat_point = 50,
        humidity_point = 32,
    })

end
