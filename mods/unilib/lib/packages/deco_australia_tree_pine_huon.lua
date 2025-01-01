---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_pine_huon = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_pine_huon.init()

    return {
        description = "Huon pine tree as decoration",
        depends = {"biome_australia_tasmania", "tree_pine_huon"},
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_australia_tree_pine_huon.post()

    unilib.register_decoration_complete("australia_tree_pine_huon_in_tasmania", nil, {
        -- From australia/biome_tasmania.lua
        biomes = "australia_tasmania",
        place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_antipodean_dark_with_turf_tasmania",
        },
        y_max = 150,
        y_min = 36,
    })

end
