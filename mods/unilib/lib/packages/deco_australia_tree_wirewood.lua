---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_wirewood = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_wirewood.init()

    return {
        description = "Wirewood tree as decoration",
        depends = {"biome_australia_central_australia", "dirt_red_antipodean", "tree_wirewood"},
    }

end

function unilib.pkg.deco_australia_tree_wirewood.post()

    for i = 1, 2 do

        unilib.register_decoration_complete("australia_tree_wirewood_in_central_" .. i, nil, {
            -- From australia/biome_central_australia.lua
            biomes = "australia_central_australia",
            place_on = "unilib:dirt_red_antipodean",
            y_max = 150,
            y_min = 36,
        })

    end

end
