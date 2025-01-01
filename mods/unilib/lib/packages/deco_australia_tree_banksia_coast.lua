---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_banksia_coast = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_banksia_coast.init()

    return {
        description = "Coast banksia tree as decoration",
        depends = {"biome_australia_eastern_coasts", "tree_banksia_coast"},
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_australia_tree_banksia_coast.post()

    for i = 1, 2 do

        unilib.register_decoration_complete("australia_tree_banksia_coast_in_eastern_" .. i, nil, {
            -- From australia/biome_eastern_coasts.lua
            biomes = "australia_eastern_coasts",
            place_on = {
                "unilib:dirt_ordinary_with_turf",
                "unilib:dirt_antipodean_with_turf_eastern_coasts",
            },
            y_max = 10,
            y_min = 6,
        })

    end
    for i = 3, 4 do

        unilib.register_decoration_complete("australia_tree_banksia_coast_in_eastern_" .. i, nil, {
            -- From australia/biome_eastern_coasts.lua
            biomes = "australia_eastern_coasts",
            place_on = {
                "unilib:dirt_ordinary_with_turf",
                "unilib:dirt_antipodean_with_turf_eastern_coasts",
            },
            y_max = 35,
            y_min = 12,
        })

    end

end
