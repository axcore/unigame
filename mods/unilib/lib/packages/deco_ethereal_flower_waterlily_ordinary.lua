---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_flower_waterlily_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_flower_waterlily_ordinary.init()

    return {
        description = "Ordinary waterlily as decoration, from ethereal-ng",
        depends = {
            -- (From schematic)
            "flower_waterlily_ordinary",
            "liquid_water_ordinary",
            "sand_ordinary",
        },
        optional = "flower_waterlily_ordinary_alt",
        at_least_one = {
            "biome_ethereal_desert",
            "biome_ethereal_forest_deciduous",
            "biome_ethereal_grove",
            "biome_ethereal_mesa",
            "biome_ethereal_plains",
            "biome_ethereal_sand_clay",
            "biome_ethereal_swamp",
        },
    }

end

function unilib.pkg.deco_ethereal_flower_waterlily_ordinary.exec()

    -- (The "flower_waterlily_ordinary_alt" package can deregister
    --      "unilib:flower_waterlily_ordinary")
    if unilib.pkg_executed_table["flower_waterlily_ordinary_alt"] == nil then

        unilib.register_decoration("ethereal_flower_waterlily_ordinary", {
            -- From ethereal-ng/schems.lua
            deco_type = "schematic",
            schematic = unilib.path_mod .. "/mts/unilib_flower_waterlily_ordinary_ethereal.mts",

            noise_params = {
                octaves = 3,
                offset = -0.12,
                persist = 0.7,
                scale = 0.3,
                seed = 33,
                spread = {x = 200, y = 200, z = 200},
            },
            rotation = "random",
            sidelen = 16,
        })

    end

end

function unilib.pkg.deco_ethereal_flower_waterlily_ordinary.post()

    if unilib.pkg_executed_table["flower_waterlily_ordinary_alt"] == nil then

        unilib.register_decoration_now("ethereal_flower_waterlily_ordinary", nil, {
            -- From ethereal-ng/decor.lua
            biomes = {
                "ethereal_desert_ocean",
                "ethereal_forest_deciduous_ocean",
                "ethereal_grove_ocean",
                "ethereal_mesa_ocean",
                "ethereal_plains_ocean",
                "ethereal_sand_clay",
                "ethereal_swamp_ocean",
            },
            place_on = {"unilib:sand_ordinary"},
            y_max = 0,
            y_min = 0,
        })

    end

end
