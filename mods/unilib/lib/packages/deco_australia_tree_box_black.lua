---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_box_black = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_box_black.init()

    return {
        description = "Black box tree as decoration",
        depends = {"biome_australia_murray_darling_basin", "tree_box_black"},
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_australia_tree_box_black.post()

    for i = 1, 3 do

        unilib.register_decoration_complete("australia_tree_box_black_in_murray_" .. i, nil, {
            -- From australia/biome_murray_darling_basin.lua
            biomes = "australia_murray_darling_basin",
            place_on = {
                "unilib:dirt_ordinary_with_turf_dry",
                "unilib:dirt_ordinary_with_turf_murray_darling_basin",
            },
            y_max = 150,
            y_min = 36,
        })

    end

end
