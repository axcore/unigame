---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_gum_sugar = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_gum_sugar.init()

    return {
        description = "Sugar gum tree as decoration",
        depends = "tree_gum_sugar",
        optional = {
            "biome_australia_central_australia",
            "biome_australia_flinders_lofty",
            "dirt_ordinary",
            "dirt_red_antipodean",
        },
    }

end

function unilib.pkg.deco_australia_tree_gum_sugar.post()

    if unilib.pkg_executed_table["biome_australia_central_australia"] ~= nil and
            unilib.pkg_executed_table["dirt_red_antipodean"] ~= nil then

        for i = 1, 3 do

            unilib.register_decoration_now("australia_tree_gum_sugar_in_central_" .. i, nil, {
                -- From australia/biome_central_australia.lua
                biomes = "australia_central_australia",
                place_on = "unilib:dirt_red_antipodean",
                y_max = 140,
                y_min = 36,
            })

        end

    end
    if unilib.pkg_executed_table["biome_australia_flinders_lofty"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        for i = 1, 3 do

            unilib.register_decoration_now("australia_tree_gum_sugar_in_flinders_" .. i, nil, {
                -- From australia/biome_flinders_lofty.lua
                biomes = "australia_flinders_lofty",
                place_on = "unilib:dirt_ordinary_with_turf_dry",
                y_max = 150,
                y_min = 36,
            })

        end

    end

end
