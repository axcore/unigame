---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_aotearoa_stone_pounamu = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_aotearoa_stone_pounamu.init()

    return {
        description = "Pounamu as ore",
        depends = "stone_pounamu",
        at_least_one = {
            "stone_desert",
            "stone_ordinary",
            "stone_schist_antipodean",
        },
    }

end

function unilib.pkg.ore_aotearoa_stone_pounamu.post()

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "blob",
        ore                     = "unilib:stone_pounamu",
        wherein                 = {
            "unilib:stone_desert",
            "unilib:stone_ordinary",
            "unilib:stone_schist_antipodean",
        },

        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 4,
        noise_params            = {
            octaves = 3,
            offset = 0.5,
            persist = 0.8,
            scale = 0.03,
            seed = -7181,
            spread = {x = 40, y = 40, z = 40},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.constant.y_max,
        y_min                   = unilib.constant.y_min,
    })

end
