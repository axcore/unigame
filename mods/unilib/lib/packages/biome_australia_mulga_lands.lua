---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_mulga_lands = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_mulga_lands.init()

    return {
        description = "Mulga lands biome",
        depends = {"dirt_ordinary", "liquid_water_river_muddy"},
    }

end

function unilib.pkg.biome_australia_mulga_lands.exec()

    unilib.register_biome({
        -- From australia/biome_mulga_lands.lua, "mulga_lands" biome
        name = "australia_mulga_lands",
        description = unilib.brackets(S("Mulga lands biome"), "australia"),
        node_top = "unilib:dirt_ordinary_with_turf_dry",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 2,
        node_river_water = "unilib:liquid_water_river_muddy_source",
        y_max = unilib.y_max,
        y_min = 36,
        heat_point = 75,
        humidity_point = 45,
    })

end
