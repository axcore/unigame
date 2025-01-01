---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_central_australia = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_central_australia.init()

    return {
        description = "Central Australia biome",
        depends = {"dirt_red_antipodean", "liquid_water_river_muddy", "stone_sandstone_antipodean"},
    }

end

function unilib.pkg.biome_australia_central_australia.post()

    unilib.register_biome({
        -- From australia/biome_central_australia.lua, "central_australia" biome
        name = "australia_central_australia",
        description = unilib.utils.brackets(S("Central Australia biome"), "australia"),
        node_top = "unilib:dirt_red_antipodean",
        depth_top = 1,
        node_filler = "unilib:stone_sandstone_antipodean",
        depth_filler = 2,
        node_river_water = "unilib:liquid_water_river_muddy_source",
        y_max = unilib.constant.y_max,
        y_min = 36,
        heat_point = 80,
        humidity_point = 25,
    })

end
