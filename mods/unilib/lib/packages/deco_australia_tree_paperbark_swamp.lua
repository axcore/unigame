---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_paperbark_swamp = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_paperbark_swamp.init()

    return {
        description = "Swamp paperbark tree as decoration",
        depends = {"biome_australia_jarrah_karri_forests", "dirt_ordinary", "tree_paperbark_swamp"},
    }

end

function unilib.pkg.deco_australia_tree_paperbark_swamp.post()

    for i = 1, 2 do

        unilib.register_decoration_now("australia_tree_paperbark_swamp_in_forests_" .. i, nil, {
            -- From australia/biome_jarrah_karri_forests.lua
            biomes = "australia_jarrah_karri_forests",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 25,
            y_min = 7,
        })

    end

end
