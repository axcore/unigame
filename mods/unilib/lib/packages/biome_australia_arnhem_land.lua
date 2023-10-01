---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    youngtrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_arnhem_land = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.youngtrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_arnhem_land.init()

    return {
        description = "Arnhem Land biome",
        depends = {"dirt_ordinary", "liquid_water_river_muddy"},
    }

end

function unilib.pkg.biome_australia_arnhem_land.exec()

    unilib.register_biome({
        -- From australia/biome_arnhem_land.lua, "arnhem_land" biome
        name = "australia_arnhem_land",
        description = unilib.brackets(S("Arnhem Land biome"), "australia"),
        node_top = "unilib:dirt_ordinary_with_turf",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_river_water = "unilib:liquid_water_river_muddy_source",
        y_max = 35,
        y_min = 4,
        heat_point = 60,
        humidity_point = 80,
    })

end
