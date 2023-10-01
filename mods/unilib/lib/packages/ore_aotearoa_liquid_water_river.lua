---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_aotearoa_liquid_water_river = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_aotearoa_liquid_water_river.init()

    return {
        description = "River water as decoration (on surface peat)",
        depends = {"dirt_peat_forest", "liquid_water_river"},
    }

end

function unilib.pkg.ore_aotearoa_liquid_water_river.post()

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "blob",
        ore                     = "unilib:liquid_water_river_source",
        wherein                 = "unilib:dirt_peat_forest",

        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 5,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.3,
            scale = 0.6,
            seed = 110388,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.y_max,
        y_min                   = unilib.y_min,
    })

end
