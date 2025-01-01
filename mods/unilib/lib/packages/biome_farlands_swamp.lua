---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_farlands_swamp = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_farlands_swamp.init()

    return {
        description = "Swamp biome",
        depends = {"dirt_ordinary", "dirt_ordinary_with_turf_swamp", "liquid_water_dirty"},
    }

end

function unilib.pkg.biome_farlands_swamp.post()

    unilib.register_biome({
        -- From farlands, mapgen/mapgen.lua, "swamp" biome
        name = "farlands_swamp",
        description = unilib.utils.brackets(S("Swamp biome"), "farlands"),
        node_top = "unilib:dirt_ordinary_with_turf_swamp",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_water_top = "unilib:liquid_water_dirty_source",
        depth_water_top = 1,
        y_max = 21000,
        y_min = 1,
        heat_point = 40,
        humidity_point = 0,
    })

end
