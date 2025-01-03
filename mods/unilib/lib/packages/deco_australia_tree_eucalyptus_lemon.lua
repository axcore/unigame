---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_eucalyptus_lemon = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_eucalyptus_lemon.init()

    return {
        description = "Lemon eucalyptus tree as decoration",
        depends = {"biome_australia_far_north_queensland", "tree_eucalyptus_lemon"},
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_australia_tree_eucalyptus_lemon.post()

    for i = 1, 2 do

        unilib.register_decoration_complete(
            -- From australia/biome_far_north_queensland.lua
            "australia_tree_eucalyptus_lemon_in_queensland_" .. i,
            nil,
            {
                biomes = "australia_far_north_queensland",
                place_on = {
                    "unilib:dirt_ordinary_with_turf",
                    "unilib:dirt_antipodean_with_turf_far_north_queensland",
                },
                y_max = 35,
                y_min = 20,
            }
        )

    end

end
