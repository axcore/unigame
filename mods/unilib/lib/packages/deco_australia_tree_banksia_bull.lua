---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_banksia_bull = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_banksia_bull.init()

    return {
        description = "Bull banksia tree as decoration",
        depends = {"biome_australia_jarrah_karri_forests", "tree_banksia_bull"},
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_australia_tree_banksia_bull.post()

    for i = 1, 2 do

        unilib.register_decoration_complete("australia_tree_banksia_bull_in_forests_" .. i, nil, {
            -- From australia/biome_jarrah_karri_forests.lua
            biomes = "australia_jarrah_karri_forests",
            place_on = {
                "unilib:dirt_ordinary_with_turf",
                "unilib:dirt_antipodean_dark_with_turf_jarrah_karri_forests",
            },
            y_max = 35,
            y_min = 8,
        })

    end

end
