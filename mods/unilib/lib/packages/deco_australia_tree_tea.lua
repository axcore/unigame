---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_tea = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_tea.init()

    return {
        description = "Tea tree as decoration",
        depends = {"dirt_ordinary", "tree_tea"},
        at_least_one = {
            "biome_australia_eastern_coasts",
            "biome_australia_great_dividing_range",
        },
    }

end

function unilib.pkg.deco_australia_tree_tea.post()

    if unilib.pkg_executed_table["biome_australia_eastern_coasts"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_tea_in_eastern_" .. i, nil, {
                -- From australia/biome_eastern_coasts.lua
                biomes = "australia_eastern_coasts",
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = 35,
                y_min = 7,
            })

        end

    end
    if unilib.pkg_executed_table["biome_australia_great_dividing_range"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_tea_in_range_" .. i, nil, {
                -- From australia/biome_great_dividing_range.lua
                biomes = "australia_great_dividing_range",
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = 170,
                y_min = 36,
            })

        end

    end

end
