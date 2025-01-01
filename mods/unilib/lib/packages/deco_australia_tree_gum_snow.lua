---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_gum_snow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_gum_snow.init()

    return {
        description = "Snow gum tree as decoration",
        depends = {"biome_australia_australian_alps", "snow_ordinary", "tree_gum_snow"},
    }

end

function unilib.pkg.deco_australia_tree_gum_snow.post()

    for i = 1, 2 do

        unilib.register_decoration_complete("australia_tree_gum_snow_in_alps_" .. i, nil, {
            -- From australia/biome_australian_alps.lua
            biomes = "australia_australian_alps",
            place_on = "unilib:snow_ordinary_block",
            y_max = 180,
            y_min = 150,
        })

    end

end
