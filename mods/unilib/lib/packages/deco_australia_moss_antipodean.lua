---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_moss_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_moss_antipodean.init()

    return {
        description = "Antipodean moss as decoration",
        depends = {"dirt_ordinary", "moss_antipodean"},
        at_least_one = {
            "biome_australia_great_dividing_range",
            "biome_australia_tasmania",
            "biome_australia_victorian_forests",
        },
    }

end

function unilib.pkg.deco_australia_moss_antipodean.post()

    if unilib.pkg_executed_table["biome_australia_great_dividing_range"] ~= nil then

        unilib.register_decoration_now("australia_moss_antipodean_in_range", nil, {
            -- From australia:moss
            biomes = "australia_great_dividing_range",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = unilib.y_max,
            y_min = 36,
        })

    end

    if unilib.pkg_executed_table["biome_australia_tasmania"] ~= nil then

        unilib.register_decoration_now("australia_moss_antipodean_in_tasmania", nil, {
            -- From australia:moss
            biomes = "australia_tasmania",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = unilib.y_max,
            y_min = 8,
        })

        unilib.register_decoration_now("australia_moss_antipodean_with_fungus", nil, {
            -- From australia:moss_with_fungus
            biomes = "australia_tasmania",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = unilib.y_max,
            y_min = 8,
        })

    end

    if unilib.pkg_executed_table["biome_australia_victorian_forests"] ~= nil then

        unilib.register_decoration_now("australia_moss_antipodean_in_victoria", nil, {
            -- From australia:moss
            biomes = "australia_victorian_forests",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 200,
            y_min = 36,
        })

    end

end
