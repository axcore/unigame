---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_aotearoa_dirt_mud_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_aotearoa_dirt_mud_antipodean.init()

    return {
        description = "Wet Antipodean mud as decoration",
        depends = "dirt_mud_antipodean",
        at_least_one = {"clay_gumland", "dirt_peat_restiad", "dirt_peat_forest"},
    }

end

function unilib.pkg.ore_aotearoa_dirt_mud_antipodean.post()

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "blob",
        ore                     = "unilib:dirt_mud_antipodean_wet",
        wherein                 = {
            "unilib:clay_gumland_topsoil",
            "unilib:dirt_peat_restiad",
            "unilib:dirt_peat_forest",
        },

        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 3,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.3,
            scale = 0.6,
            seed = 74331,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.y_max,
        y_min                   = unilib.y_min,
    })

end
