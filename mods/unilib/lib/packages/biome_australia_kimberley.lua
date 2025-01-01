---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.biome_australia_kimberley = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.biome_australia_kimberley.init()

    return {
        description = "Kimberley biome",
        depends = {"dirt_red_antipodean", "liquid_water_river_muddy", "stone_sandstone_ordinary"},
    }

end

function unilib.pkg.biome_australia_kimberley.post()

    unilib.register_biome({
        -- From australia/biome_kimberley.lua, "kimberley" biome
        name = "australia_kimberley",
        description = unilib.utils.brackets(S("Kimberley biome"), "australia"),
        node_top = "unilib:dirt_red_antipodean",
        depth_top = 2,
        node_filler = "unilib:stone_sandstone_ordinary",
        depth_filler = 3,
        node_river_water = "unilib:liquid_water_river_muddy_source",
        y_max = 35,
        y_min = 4,
        heat_point = 80,
        humidity_point = 75,
    })

end
