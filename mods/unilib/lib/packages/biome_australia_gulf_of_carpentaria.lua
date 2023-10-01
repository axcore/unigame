---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_gulf_of_carpentaria = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_gulf_of_carpentaria.init()

    return {
        description = "Gulf of Carpentaria biome",
        depends = {"dirt_ordinary", "liquid_water_river_muddy", "stone_sandstone_ordinary"},
    }

end

function unilib.pkg.biome_australia_gulf_of_carpentaria.exec()

    unilib.register_biome({
        -- From australia/biome_gulf_of_carpentaria.lua, "gulf_of_carpentaria" biome
        name = "australia_gulf_of_carpentaria",
        description = unilib.brackets(S("Gulf of Carpentaria biome"), "australia"),
        node_top = "unilib:dirt_ordinary_with_turf_dry",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 2,
        node_stone = "unilib:stone_sandstone_ordinary",
        node_river_water = "unilib:liquid_water_river_muddy_source",
        y_max = 35,
        y_min = 4,
        heat_point = 75,
        humidity_point = 55,
    })

end
