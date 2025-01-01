---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_snow_ordinary_patchy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_snow_ordinary_patchy.init()

    return {
        description = "Ordinary permafrost dirt with moss as decoration",
        depends = {"biome_ethereal_tundra", "snow_ordinary"},
        at_least_one = {"dirt_permafrost_ordinary", "gravel_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.deco_ethereal_snow_ordinary_patchy.exec()

    unilib.register_decoration_generic("ethereal_snow_ordinary_patchy", {
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

function unilib.pkg.deco_ethereal_snow_ordinary_patchy.post()

    unilib.register_decoration_complete("ethereal_snow_ordinary_patchy", nil, {
        -- From ethereal-ng/decor.lua
        biomes = {"ethereal_tundra", "ethereal_tundra_beach"},
        place_on = {
            "unilib:dirt_permafrost_ordinary_with_litter_stone",
            "unilib:dirt_permafrost_ordinary_with_moss",
            "unilib:gravel_ordinary",
            "unilib:stone_ordinary",
        },
        y_max = 50,
        y_min = 1,
    })

end
