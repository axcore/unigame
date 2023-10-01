---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_marri = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_marri.init()

    return {
        description = "Marri tree as decoration",
        depends = {"biome_australia_jarrah_karri_forests", "dirt_ordinary", "tree_marri"},
    }

end

function unilib.pkg.deco_australia_tree_marri.post()

    for i = 1, 3 do

        unilib.register_decoration_now("australia_tree_marri_in_forests_" .. i, nil, {
            -- From australia/biome_jarrah_karri_forests.lua
            biomes = "australia_jarrah_karri_forests",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 35,
            y_min = 12,
        })

    end

end
