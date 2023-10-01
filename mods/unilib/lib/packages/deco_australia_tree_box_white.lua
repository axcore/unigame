---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_box_white = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_box_white.init()

    return {
        description = "White box tree as decoration",
        depends = {"biome_australia_victorian_forests", "dirt_ordinary", "tree_box_white"},
    }

end

function unilib.pkg.deco_australia_tree_box_white.post()

    for i = 1, 3 do

        unilib.register_decoration_now("australia_tree_box_white_in_victoria_" .. i, nil, {
            -- From australia/biome_victorian_forests.lua
            biomes = "australia_victorian_forests",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 175,
            y_min = 36,
        })

    end

end
