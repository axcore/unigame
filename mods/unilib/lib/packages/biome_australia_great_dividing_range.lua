---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_great_dividing_range = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_great_dividing_range.init()

    return {
        description = "Great dividing range biome",
        depends = {"dirt_ordinary", "liquid_water_river_muddy"},
    }

end

function unilib.pkg.biome_australia_great_dividing_range.exec()

    unilib.register_biome({
        -- From australia/biome_great_dividing_range.lua, "great_dividing_range" biome
        name = "australia_great_dividing_range",
        description = unilib.brackets(S("Great dividing range biome"), "australia"),
        node_top = "unilib:dirt_ordinary_with_turf",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_river_water = "unilib:liquid_water_river_muddy_source",
        y_max = unilib.y_max,
        y_min = 36,
        heat_point = 25,
        humidity_point = 65,
    })

end
