---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_acacia_shoestring = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_acacia_shoestring.init()

    return {
        description = "Shoestring acacia tree as decoration",
        depends = {"biome_australia_mulga_lands", "dirt_ordinary", "tree_acacia_shoestring"},
    }

end

function unilib.pkg.deco_australia_tree_acacia_shoestring.post()

    for i = 1, 2 do

        unilib.register_decoration_now(
            -- From australia/biome_mulga_lands.lua
            "australia_tree_acacia_shoestring_in_mulga_lands_" .. i,
            nil,
            {
                biomes = "australia_mulga_lands",
                place_on = "unilib:dirt_ordinary_with_turf_dry",
                y_max = 150,
                y_min = 36,
            }
        )

    end

end
