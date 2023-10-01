---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_aotearoa_stone_basalt_black = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_aotearoa_stone_basalt_black.init()

    return {
        description = "Black basalt as ore",
        depends = "stone_basalt_black",
        at_least_one = {
            "stone_granite_antipodean",
            "stone_greywacke_dark",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.ore_aotearoa_stone_basalt_black.post()

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "blob",
        ore                     = "unilib:stone_basalt_black",
        wherein                 = {
            "unilib:stone_granite_antipodean",
            "unilib:stone_greywacke_dark",
            "unilib:stone_ordinary",
        },

        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 15,
        noise_params            = {
            octaves = 1,
            offset = 0,
            persist = 0.0,
            scale = 1,
            seed = -800317,
            spread = {x = 15, y = 15, z = 15},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.y_max,
        y_min                   = unilib.y_min,
    })

end
