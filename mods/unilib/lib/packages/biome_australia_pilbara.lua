---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_pilbara = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_pilbara.init()

    return {
        description = "Pilbara biome",
        depends = {
            "gravel_red_antipodean",
            "liquid_water_river_muddy",
            "stone_sandstone_antipodean",
        },
    }

end

function unilib.pkg.biome_australia_pilbara.exec()

    unilib.register_biome({
        -- From australia/biome_pilbara.lua, "pilbara" biome
        name = "australia_pilbara",
        description = unilib.brackets(S("Pilbara biome"), "australia"),
        node_top = "unilib:gravel_red_antipodean",
        depth_top = 2,
        node_filler = "unilib:stone_sandstone_antipodean",
        depth_filler = 2,
        node_river_water = "unilib:liquid_water_river_muddy_source",
        y_max = 35,
        y_min = 4,
        heat_point = 80,
        humidity_point = 20,
    })

end
