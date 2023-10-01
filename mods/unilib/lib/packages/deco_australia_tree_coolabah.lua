---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_tree_coolabah = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_tree_coolabah.init()

    return {
        description = "Coolabah tree as decoration",
        depends = "tree_coolabah",
        optional = {
            "biome_australia_central_australia",
            "biome_australia_eastern_coasts",
            "biome_australia_flinders_lofty",
            "biome_australia_jarrah_karri_forests",
            "biome_australia_mulga_lands",
            "biome_australia_murray_darling_basin",
            "biome_australia_simpson_desert",
            "biome_australia_victorian_forests",
            "dirt_ordinary",
            "dirt_red_antipodean",
            "sand_red_antipodean",
        },
    }

end

function unilib.pkg.deco_australia_tree_coolabah.post()

    if unilib.pkg_executed_table["biome_australia_central_australia"] ~= nil and
            unilib.pkg_executed_table["dirt_red_antipodean"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_coolabah_in_central_" .. i, nil, {
                -- From australia/biome_central_australia.lua
                biomes = "australia_central_australia",
                place_on = "unilib:dirt_red_antipodean",
                y_max = 140,
                y_min = 36,
            })

        end

    end
    if unilib.pkg_executed_table["biome_australia_eastern_coasts"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_coolabah_in_eastern_" .. i, nil, {
                -- From australia/biome_eastern_coasts.lua
                biomes = "australia_eastern_coasts",
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = 35,
                y_min = 7,
            })

        end

    end
    if unilib.pkg_executed_table["biome_australia_flinders_lofty"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_coolabah_in_flinders_" .. i, nil, {
                -- From australia/biome_flinders_lofty.lua
                biomes = "australia_flinders_lofty",
                place_on = "unilib:dirt_ordinary_with_turf_dry",
                y_max = 140,
                y_min = 36,
            })

        end

    end
    if unilib.pkg_executed_table["biome_australia_jarrah_karri_forests"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_coolabah_in_forests_" .. i, nil, {
                -- From australia/biome_jarrah_karri_forests.lua
                biomes = "australia_jarrah_karri_forests",
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = 35,
                y_min = 8,
            })

        end

    end
    if unilib.pkg_executed_table["biome_australia_mulga_lands"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_coolabah_in_mulga_lands_" .. i, nil, {
                -- From australia/biome_mulga_lands.lua
                biomes = "australia_mulga_lands",
                place_on = "unilib:dirt_ordinary_with_turf_dry",
                y_max = 140,
                y_min = 36,
            })

        end

    end
    if unilib.pkg_executed_table["biome_australia_murray_darling_basin"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_coolabah_in_murray_" .. i, nil, {
                -- From australia/biome_murray_darling_basin.lua
                biomes = "australia_murray_darling_basin",
                place_on = "unilib:dirt_ordinary_with_turf_dry",
                y_max = 140,
                y_min = 36,
            })

        end

    end
    if unilib.pkg_executed_table["biome_australia_simpson_desert"] ~= nil and
            unilib.pkg_executed_table["sand_red_antipodean"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_coolabah_in_simpson_" .. i, nil, {
                -- From australia/biome_simpson_desert.lua
                biomes = "australia_simpson_desert",
                place_on = "unilib:sand_red_antipodean",
                y_max = 150,
                y_min = 36,
            })

        end

    end
    if unilib.pkg_executed_table["biome_australia_victorian_forests"] ~= nil and
            unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        for i = 1, 2 do

            unilib.register_decoration_now("australia_tree_coolabah_in_victoria_" .. i, nil, {
                -- From australia/biome_victorian_forests.lua
                biomes = "australia_victorian_forests",
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = 140,
                y_min = 36,
            })

        end

    end

end
