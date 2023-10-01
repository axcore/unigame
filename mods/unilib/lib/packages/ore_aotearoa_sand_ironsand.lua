---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_aotearoa_sand_ironsand = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_aotearoa_sand_ironsand.init()

    return {
        description = "Ironsand as ore",
        depends = {"sand_ironsand", "sand_volcanic"},
    }

end

function unilib.pkg.ore_aotearoa_sand_ironsand.post()

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "blob",
        ore                     = "unilib:sand_ironsand",
        wherein                 = "unilib:sand_volcanic",

        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 2,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.2,
            scale = 0.01,
            seed = 86811112,
            spread = {x = 5, y = 5, z = 5},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.y_max,
        y_min                   = unilib.y_min,
    })

end
