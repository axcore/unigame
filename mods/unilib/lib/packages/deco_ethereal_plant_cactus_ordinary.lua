---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_plant_cactus_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_plant_cactus_ordinary.init()

    return {
        description = "Alternative ordinary cactus decoration from ethereal-ng",
        depends = "plant_cactus_ordinary",
        optional = {
            "biome_ethereal_desert",
            "biome_ethereal_sandstone_desert",
            "sand_desert",
            "stone_sandstone_ordinary",
        },
    }

end

function unilib.pkg.deco_ethereal_plant_cactus_ordinary.exec()

    if unilib.global.pkg_executed_table["biome_ethereal_sandstone_desert"] ~= nil and
            unilib.global.pkg_executed_table["stone_sandstone_ordinary"] ~= nil then

        -- Cactus decoration placed as a single node; the ABM causes it to grow upwards
        unilib.register_decoration_generic("ethereal_plant_cactus_ordinary_1", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = "unilib:plant_cactus_ordinary",

            fill_ratio = 0.002,
            height_max = 2,
            sidelen = 80,
        })

    end

    if unilib.global.pkg_executed_table["biome_ethereal_desert"] ~= nil and
            unilib.global.pkg_executed_table["sand_desert"] ~= nil then

        -- Cactus decoration placed as a single node; the ABM causes it to grow upwards
        unilib.register_decoration_generic("ethereal_plant_cactus_ordinary_2", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = "unilib:plant_cactus_ordinary",

            fill_ratio = 0.005,
            height_max = 4,
            sidelen = 80,
        })

        -- Cactus decoration placed as a multi-node plant
        unilib.register_decoration_generic("ethereal_plant_cactus_ordinary_3", {
            -- From ethereal-ng/schems.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_plant_cactus_ordinary_large.mts",

            flags = "place_center_x",
            rotation = "random",
            noise_params = {
                octaves = 3,
                offset = -0.0005,
                persist = 0.6,
                scale = 0.0015,
                seed = 230,
                spread = {x = 200, y = 200, z = 200},
            },
            rotation = "random",
            sidelen = 80,
        })

    end

end

function unilib.pkg.deco_ethereal_plant_cactus_ordinary.post()

    if unilib.global.pkg_executed_table["biome_ethereal_sandstone_desert"] ~= nil and
            unilib.global.pkg_executed_table["stone_sandstone_ordinary"] ~= nil then

        unilib.register_decoration_complete("ethereal_plant_cactus_ordinary_1", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_sandstone_desert",
            place_on = "unilib:stone_sandstone_ordinary",
            y_max = 100,
            y_min = 1,
        })

    end

    if unilib.global.pkg_executed_table["biome_ethereal_desert"] ~= nil and
            unilib.global.pkg_executed_table["sand_desert"] ~= nil then

        unilib.register_decoration_complete("ethereal_plant_cactus_ordinary_2", nil, {
            -- From ethereal-ng/decor.lua
            biomes = "ethereal_desert",
            place_on = "unilib:sand_desert",
            y_max = 100,
            y_min = 1,
        })

        unilib.register_decoration_complete("ethereal_plant_cactus_ordinary_3", nil, {
            -- From ethereal-ng/schems.lua
            biomes = "ethereal_desert",
            place_on = "unilib:sand_desert",
            y_max = 100,
            y_min = 5,
        })

    end

end

