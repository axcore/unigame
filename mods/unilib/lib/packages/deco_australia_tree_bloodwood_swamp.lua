---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_bloodwood_swamp = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_bloodwood_swamp.init()

    return {
        description = "Swamp bloodwood tree as decoration",
        depends = {"biome_australia_kimberley", "dirt_red_antipodean", "tree_bloodwood_swamp"},
    }

end

function unilib.pkg.deco_australia_tree_bloodwood_swamp.post()

    for i = 1, 2 do

        unilib.register_decoration_now("australia_tree_bloodwood_swamp_in_kimberley_" .. i, nil, {
            -- From australia/biome_kimberley.lua
            biomes = "australia_kimberley",
            place_on = "unilib:dirt_red_antipodean",
            y_max = 35,
            y_min = 7,
        })

    end

end
