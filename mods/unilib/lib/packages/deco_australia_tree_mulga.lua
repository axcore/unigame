---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_mulga = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_mulga.init()

    return {
        description = "Mulga tree as decoration",
        depends = {"biome_australia_mulga_lands", "tree_mulga"},
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_australia_tree_mulga.post()

    for i = 1, 2 do

        unilib.register_decoration_complete("australia_tree_mulga_in_mulga_lands_" .. i, nil, {
            -- From australia/biome_mulga_lands.lua
            biomes = "australia_mulga_lands",
            place_on = {
                "unilib:dirt_ordinary_with_turf_dry",
                "unilib:dirt_ordinary_with_turf_mulga_lands",
            },
            y_max = 150,
            y_min = 36,
        })

    end

end
