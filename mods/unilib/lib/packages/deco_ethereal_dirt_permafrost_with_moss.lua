---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_dirt_permafrost_with_moss = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_dirt_permafrost_with_moss.init()

    return {
        description = "Permafrost dirt with moss as decoration",
        depends = {"biome_ethereal_tundra", "dirt_permafrost"},
        optional = {"gravel_ordinary", "snow_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.deco_ethereal_dirt_permafrost_with_moss.exec()

    if unilib.pkg_executed_table["gravel_ordinary"] ~= nil or
            unilib.pkg_executed_table["snow_ordinary"] ~= nil or
            unilib.pkg_executed_table["stone_ordinary"] ~= nil then

        unilib.register_decoration("ethereal_dirt_permarfrost_with_moss_2", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = "unilib:snow_ordinary",

            noise_params = {
                octaves = 3,
                seed = 172555,
                spread = {x = 100, y = 100, z = 100},
                persist = 1,
                offset = 0,
                scale = 1,
            },
            sidelen = 4,
        })

    end

end

function unilib.pkg.deco_ethereal_dirt_permafrost_with_moss.post()

    unilib.register_decoration_now(
        -- From ethereal-ng/decor.lua
        -- Completes decoration in package "dirt_permafrost"
        "default_dirt_permafrost_with_moss",
        "ethereal_dirt_permarfrost_with_moss_1",
        {
            biomes = "ethereal_tundra",
            place_on = "unilib:dirt_permafrost_with_stonelet",
            y_max = 50,
            y_min = 2,
        }
    )

    if unilib.pkg_executed_table["gravel_ordinary"] ~= nil or
            unilib.pkg_executed_table["snow_ordinary"] ~= nil or
            unilib.pkg_executed_table["stone_ordinary"] ~= nil then

        unilib.register_decoration_now("ethereal_dirt_permarfrost_with_moss_2", nil, {
            -- From ethereal-ng/decor.lua
            biomes = {"ethereal_tundra", "ethereal_tundra_beach"},
            place_on = {
                "unilib:dirt_permafrost_with_moss",
                "unilib:dirt_permafrost_with_stonelet",
                "unilib:gravel_ordinary",
                "unilib:stone_ordinary",
            },
            y_max = 50,
            y_min = 1,
        })

    end

end
