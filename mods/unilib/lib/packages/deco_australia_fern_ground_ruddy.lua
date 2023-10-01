---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_fern_ground_ruddy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_fern_ground_ruddy.init()

    return {
        description = "Ruddy ground fern as decoration",
        depends = {"dirt_ordinary", "fern_ground_ruddy"},
        at_least_one = {
            "biome_australia_great_dividing_range",
            "biome_australia_tasmania",
            "biome_australia_victorian_forests",
        },
    }

end

function unilib.pkg.deco_australia_fern_ground_ruddy.exec()

    if unilib.pkg_executed_table["biome_australia_tasmania"] ~= nil then

        unilib.register_decoration_now("australia_fern_ground_ruddy_1", nil, {
            -- From australia:fern
            biomes = "australia_tasmania",
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 160,
            y_min = 36,
        })

    end

    if unilib.pkg_executed_table["biome_australia_great_dividing_range"] ~= nil or
            unilib.pkg_executed_table["biome_australia_victorian_forests"] ~= nil then

        unilib.register_decoration_now("australia_fern_ground_ruddy_2", nil, {
            -- From australia:fern
            biomes = {"australia_great_dividing_range", "australia_victorian_forests"},
            place_on = "unilib:dirt_ordinary_with_turf",
            y_max = 160,
            y_min = 36,
        })

    end

end
