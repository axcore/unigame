---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_dirt_dry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_dirt_dry.init()

    return {
        description = "Dry dirt as decoration",
        depends = {"biome_ethereal_savanna", "dirt_dry"},
    }

end

function unilib.pkg.deco_ethereal_dirt_dry.post()

    unilib.register_decoration_complete("default_dirt_dry", "ethereal_dirt_dry", {
        -- From ethereal-ng/decor.lua
        -- Completes decoration in package "dirt_dry"
        biomes = "ethereal_savanna",
        place_on = "unilib:dirt_dry_with_turf_dry",
        y_max = 100,
        y_min = 1,
    })

end
