---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_simpson_desert = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_simpson_desert.init()

    return {
        description = "Simpson desert biome",
        depends = {"liquid_water_river_muddy", "sand_red_antipodean", "stone_sandstone_antipodean"},
    }

end

function unilib.pkg.biome_australia_simpson_desert.exec()

    unilib.register_biome({
        -- From australia/biome_simpson_desert.lua, "simpson_desert" biome
        name = "australia_simpson_desert",
        description = unilib.brackets(S("Simpson desert biome"), "australia"),
        node_top = "unilib:sand_red_antipodean",
        depth_top = 3,
        node_filler = "unilib:stone_sandstone_antipodean",
        depth_filler = 2,
        node_river_water = "unilib:liquid_water_river_muddy_source",
        y_max = unilib.y_max,
        y_min = 36,
        heat_point = 85,
        humidity_point = 10,
    })

end
