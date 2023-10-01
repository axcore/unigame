---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_plant_cotton_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_plant_cotton_wild.init()

    return {
        description = "Wild cotton plant as decoration",
        depends = {"biome_ethereal_savanna", "dirt_dry", "plant_cotton_wild"},
    }

end

function unilib.pkg.deco_ethereal_plant_cotton_wild.post()

    unilib.register_decoration_now("farming_plant_cotton_wild", "ethereal_plant_cotton_wild", {
        -- Completes decoration in package "plant_cotton_wild"
        -- From farming/init.lua
        biomes = "ethereal_savanna",
        place_on = "unilib:dirt_dry_with_turf_dry",
        y_max = unilib.y_max,
        y_min = 1,
    })

end

