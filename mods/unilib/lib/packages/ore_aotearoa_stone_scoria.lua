---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_aotearoa_stone_scoria = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_aotearoa_stone_scoria.init()

    return {
        description = "Scoria as ore",
        depends = "stone_scoria",
        at_least_one = {"stone_andesite_antipodean", "stone_basalt_black"},
    }

end

function unilib.pkg.ore_aotearoa_stone_scoria.post()

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "blob",
        ore                     = "unilib:stone_scoria",
        wherein                 = {
            "unilib:stone_andesite_antipodean",
            "unilib:stone_basalt_black",
        },

        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 3,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.2,
            scale = 0.01,
            seed = 7701112,
            spread = {x = 5, y = 5, z = 5},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.constant.y_max,
        y_min                   = unilib.constant.y_min,
    })

end
