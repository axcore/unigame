---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_dirt_permafrost_ordinary_with_moss = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_dirt_permafrost_ordinary_with_moss.init()

    return {
        description = "Ordinary permafrost dirt with moss as decoration",
        depends = {"biome_ethereal_tundra", "dirt_permafrost_ordinary"},
    }

end

function unilib.pkg.deco_ethereal_dirt_permafrost_ordinary_with_moss.post()

    unilib.register_decoration_complete(
        -- From ethereal-ng/decor.lua
        -- Completes decoration in package "dirt_permafrost_ordinary"
        "default_dirt_permafrost_ordinary_with_moss",
        "ethereal_dirt_permafrost_with_moss",
        {
            biomes = "ethereal_tundra",
            place_on = "unilib:dirt_permafrost_ordinary_with_litter_stone",
            y_max = 50,
            y_min = 2,
        }
    )

end
