---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_oak_desert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_oak_desert.init()

    return {
        description = "Desert oak tree as decoration",
        depends = "tree_oak_desert",
        optional = {
            "biome_australia_central_australia",
            "biome_australia_pilbara",
            "dirt_red_antipodean",
            "gravel_red_antipodean",
        },
    }

end

function unilib.pkg.deco_australia_tree_oak_desert.post()

    if unilib.global.pkg_executed_table["biome_australia_central_australia"] ~= nil and
            unilib.global.pkg_executed_table["dirt_red_antipodean"] ~= nil then

        for i = 1, 3 do

            unilib.register_decoration_complete("australia_tree_oak_desert_in_central_" .. i, nil, {
                -- From australia/biome_central_australia.lua
                biomes = "australia_central_australia",
                place_on = "unilib:dirt_red_antipodean",
                y_max = 140,
                y_min = 36,
            })

        end

    end
    if unilib.global.pkg_executed_table["biome_australia_pilbara"] ~= nil and
            unilib.global.pkg_executed_table["gravel_red_antipodean"] ~= nil then

        for i = 1, 3 do

            unilib.register_decoration_complete("australia_tree_oak_desert_in_pilbara_" .. i, nil, {
                -- From australia/biome_pilbara.lua
                biomes = "australia_pilbara",
                place_on = "unilib:gravel_red_antipodean",
                y_max = 35,
                y_min = 10,
            })

        end

    end

end
