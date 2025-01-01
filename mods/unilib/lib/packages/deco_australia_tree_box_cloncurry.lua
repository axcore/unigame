---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_box_cloncurry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_box_cloncurry.init()

    return {
        description = "Cloncurry box tree as decoration",
        depends = {"biome_australia_gulf_of_carpentaria", "tree_box_cloncurry"},
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_australia_tree_box_cloncurry.post()

    for i = 1, 2 do

        unilib.register_decoration_complete("australia_tree_box_cloncurry_in_gulf_" .. i, nil, {
            -- From australia/biome_gulf_of_carpentaria.lua
            biomes = "australia_gulf_of_carpentaria",
            place_on = {
                "unilib:dirt_ordinary_with_turf_dry",
                "unilib:dirt_ordinary_with_turf_gulf_of_carpentaria",
            },
            y_max = 35,
            y_min = 6,
        })

    end

end
