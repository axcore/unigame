---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_plant_spinifex = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_plant_spinifex.init()

    return {
        description = "Spinifex as decoration",
        depends = "plant_spinifex",
        optional = {
            "biome_australia_central_australia",
            "biome_australia_goldfields_esperance",
            "biome_australia_pilbara",
            "dirt_red_antipodean",
            "gravel_red_antipodean",
            "sand_desert",
        },
    }

end

function unilib.pkg.deco_australia_plant_spinifex.post()

    if unilib.global.pkg_executed_table["biome_australia_central_australia"] ~= nil and
            unilib.global.pkg_executed_table["dirt_red_antipodean"] ~= nil then

        unilib.register_decoration_complete(
            -- From australia:spinifex
            "australia_plant_spinifex_1",
            "australia_plant_spinifex_1",
            {
                biomes = "australia_central_australia",
                place_on = "unilib:dirt_red_antipodean",
                y_max = 170,
                y_min = 37,
            }
        )

    end

    if unilib.global.pkg_executed_table["biome_australia_goldfields_esperance"] ~= nil and
            unilib.global.pkg_executed_table["sand_desert"] ~= nil then

        -- N.B. "australia_plant_spinifex_1" is not an error
        unilib.register_decoration_complete(
            -- From australia:spinifex
            "australia_plant_spinifex_1",
            "australia_plant_spinifex_2",
            {
                biomes = "australia_goldfields_esperance",
                place_on = "unilib:sand_desert",
                y_max = 35,
                y_min = 6,
            }
        )

    end

    if unilib.global.pkg_executed_table["biome_australia_pilbara"] ~= nil and
            unilib.global.pkg_executed_table["gravel_red_antipodean"] ~= nil then

        unilib.register_decoration_complete("australia_plant_spinifex_3", nil, {
            -- From australia:spinifex
            biomes = "australia_pilbara",
            place_on = "unilib:gravel_red_antipodean",
            y_max = unilib.constant.y_max,
            y_min = 8,
        })

    end

end
