---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_plant_cotton_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_plant_cotton_wild.init()

    return {
        description = "Wild cotton plant as decoration",
        notes = "ethereal-ng originally provided its own decoration for wild cotton, but it was" ..
                " later removed, to be replaced with a new decoration in the \"farming_redo\"" ..
                " mod. This package preserves the original decoration, updated to match the new" ..
                " code",
        depends = {"dirt_dry", "plant_cotton_wild"},
    }

end

function unilib.pkg.deco_ethereal_plant_cotton_wild.exec()

    unilib.register_decoration_generic("ethereal_plant_cotton_wild", {
        -- From farming/init.lua
        deco_type = "simple",
        decoration = "unilib:plant_cotton_wild",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.003,
            seed = 4242,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end

function unilib.pkg.deco_ethereal_plant_cotton_wild.post()

    unilib.register_decoration_complete("ethereal_plant_cotton_wild", nil, {
        -- From farming/init.lua
        place_on = {"unilib:dirt_dry_with_turf_dry", "unilib:dirt_ordinary_with_turf_dry"},
        y_max = 120,
        y_min = 1,
    })

end
