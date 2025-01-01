---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_palm_fan = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_palm_fan.init()

    return {
        description = "Australian fan palm tree as decoration",
        depends = {"biome_australia_far_north_queensland", "tree_palm_fan"},
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_australia_tree_palm_fan.post()

    unilib.register_decoration_complete("australia_tree_palm_fan_in_queensland", nil, {
        -- From australia/biome_far_north_queensland.lua
        biomes = "australia_far_north_queensland",
        place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_antipodean_with_turf_far_north_queensland",
        },
        y_max = 20,
        y_min = 5,
    })

end
