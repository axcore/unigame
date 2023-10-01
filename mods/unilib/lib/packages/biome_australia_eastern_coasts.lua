---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_eastern_coasts = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_eastern_coasts.init()

    return {
        description = "Eastern coasts biome",
        depends = {"dirt_ordinary", "liquid_water_river_muddy"},
    }

end

function unilib.pkg.biome_australia_eastern_coasts.exec()

    unilib.register_biome({
        -- From australia/biome_eastern_coasts.lua, "eastern_coasts" biome
        name = "australia_eastern_coasts",
        description = unilib.brackets(S("Eastern coasts biome"), "australia"),
        node_top = "unilib:dirt_ordinary_with_turf",
        depth_top = 1,
        node_filler = "unilib:dirt_ordinary",
        depth_filler = 3,
        node_river_water = "unilib:liquid_water_river_muddy_source",
        y_max = 35,
        y_min = 4,
        heat_point = 35,
        humidity_point = 60,
    })

end
