---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_stringybark_daintree = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_stringybark_daintree.init()

    return {
        description = "Daintree stringybark tree as decoration",
        depends = {
            "biome_australia_far_north_queensland",
            "dirt_ordinary",
            "tree_stringybark_daintree",
        },
    }

end

function unilib.pkg.deco_australia_tree_stringybark_daintree.post()

    for i = 1, 2 do

        unilib.register_decoration_now(
            -- From australia/biome_far_north_queensland.lua
            "australia_tree_stringybark_daintree_in_queensland_" .. i,
            nil,
            {
                biomes = "australia_far_north_queensland",
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = 35,
                y_min = 25,
            }
        )

    end

end
