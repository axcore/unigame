---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_mangrove_stilted = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_mangrove_stilted.init()

    return {
        description = "Stilted mangrove tree as decoration",
        depends = {"biome_australia_mangroves", "tree_mangrove_stilted"},
        at_least_one = {"dirt_mud_mangrove", "dirt_ordinary", "sand_ordinary"},
    }

end

function unilib.pkg.deco_australia_tree_mangrove_stilted.post()

    for i = 1, 3 do

        unilib.register_decoration_complete(
            -- From australia/biome_mangroves.lua
            "australia_tree_mangrove_stilted_in_mangroves_" .. i,
            nil,
            {
                biomes = "australia_mangroves",
                place_on = {
                    "unilib:dirt_mud_mangrove",
                    "unilib:dirt_ordinary",
                    "unilib:sand_ordinary",
                },
                y_max = 3,
                y_min = -2,
            }
        )

    end

end
