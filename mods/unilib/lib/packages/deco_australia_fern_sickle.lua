---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_fern_sickle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_fern_sickle.init()

    return {
        description = "Sickle fern as decoration",
        depends = "fern_sickle",
        optional = {
            "biome_australia_great_dividing_range",
            "biome_australia_tasmania",
            "biome_australia_victorian_forests",
            "dirt_custom_antipodean",
            "dirt_ordinary",
        },
    }

end

function unilib.pkg.deco_australia_fern_sickle.post()

    if unilib.global.pkg_executed_table["biome_australia_tasmania"] ~= nil and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        unilib.register_decoration_complete("australia_fern_sickle_1", nil, {
            -- From australia:small_fern
            biomes = "australia_tasmania",
            place_on = {
                "unilib:dirt_ordinary_with_turf",
                "unilib:dirt_antipodean_dark_with_turf_tasmania",
            },
            y_max = 140,
            y_min = 36,
        })

    end

    if (
        unilib.global.pkg_executed_table["biome_australia_great_dividing_range"] ~= nil or
        unilib.global.pkg_executed_table["biome_australia_victorian_forests"] ~= nil
    ) and (
        unilib.global.pkg_executed_table["dirt_custom_antipodean"] ~= nil or
        unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil
    ) then

        unilib.register_decoration_complete("australia_fern_sickle_2", nil, {
            -- From australia:small_fern
            biomes = {"australia_great_dividing_range", "australia_victorian_forests"},
            place_on = {
                "unilib:dirt_ordinary_with_turf",
                "unilib:dirt_antipodean_with_turf_great_dividing_range",
                "unilib:dirt_antipodean_dark_with_turf_victorian_forests",
            },
            y_max = 140,
            y_min = 36,
        })

    end

end
