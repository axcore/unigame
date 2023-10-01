---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_pine_rottnest_island = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_pine_rottnest_island.init()

    return {
        description = "Rottnest Island pine tree as decoration",
        depends = {
            "biome_australia_jarrah_karri_forests",
            "dirt_ordinary",
            "tree_pine_rottnest_island",
        },
    }

end

function unilib.pkg.deco_australia_tree_pine_rottnest_island.post()

    for i = 1, 2 do

        unilib.register_decoration_now(
            -- From australia/biome_jarrah_karri_forests.lua
            "australia_tree_pine_rottnest_island_in_forests_" .. i,
            nil,
            {
                biomes = "australia_jarrah_karri_forests",
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = 20,
                y_min = 6,
            }
        )

    end

end
