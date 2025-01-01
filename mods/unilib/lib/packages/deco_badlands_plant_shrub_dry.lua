---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    badlands
-- Code:    LGPL-3.0
-- Media:   LGPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_badlands_plant_shrub_dry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.badlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_badlands_plant_shrub_dry.init()

    return {
        description = "Dry shrub as decoration",
        depends = {"biome_badlands", "plant_shrub_dry", "sand_barren"},
    }

end

function unilib.pkg.deco_badlands_plant_shrub_dry.exec()

    unilib.register_decoration_generic("badlands_plant_shrub_dry", {
        -- From badlands/init.lua
        deco_type = "simple",
        decoration = "unilib:plant_shrub_dry",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.035,
            seed = 329,
            spread = {x = 100, y = 100, z = 100},
        },
        param2 = 4,
        sidelen = 16,
    })

end

function unilib.pkg.deco_badlands_plant_shrub_dry.post()

    unilib.register_decoration_complete("badlands_plant_shrub_dry", nil, {
        -- From badlands/init.lua
        place_on = "unilib:sand_barren",
        y_max = 30,
        y_min = 1,
    })

end
