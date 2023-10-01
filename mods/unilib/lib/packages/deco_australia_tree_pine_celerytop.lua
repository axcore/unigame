---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_pine_celerytop = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_pine_celerytop.init()

    return {
        description = "Celerytop pine tree as decoration",
        depends = {"biome_australia_tasmania", "dirt_ordinary", "tree_pine_celerytop"},
    }

end

function unilib.pkg.deco_australia_tree_pine_celerytop.post()

    for i = 1, 2 do

        unilib.register_decoration_now("australia_tree_pine_celerytop_in_tasmania_" .. i, nil, {
            -- From australia/biome_tasmania.lua
            biomes = "australia_tasmania",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 180,
            y_min = 36,
        })

    end

end
