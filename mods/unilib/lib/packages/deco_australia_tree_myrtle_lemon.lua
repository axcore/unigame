---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_myrtle_lemon = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_myrtle_lemon.init()

    return {
        description = "Lemon myrtle tree as decoration",
        depends = {"biome_australia_eastern_coasts", "dirt_ordinary", "tree_myrtle_lemon"},
    }

end

function unilib.pkg.deco_australia_tree_myrtle_lemon.post()

    for i = 1, 2 do

        unilib.register_decoration_now("australia_tree_myrtle_lemon_in_eastern_" .. i, nil, {
            -- From australia/biome_eastern_coasts.lua
            biomes = "australia_eastern_coasts",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 35,
            y_min = 7,
        })

    end

end
