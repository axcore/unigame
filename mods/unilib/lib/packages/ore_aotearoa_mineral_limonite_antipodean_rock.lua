---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_aotearoa_mineral_limonite_antipodean_rock = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_aotearoa_mineral_limonite_antipodean_rock.init()

    return {
        description = "Antipodean limonite as ore",
        depends = "mineral_limonite_antipodean_rock",
        optional = {
            "stone_basalt_black",
            "stone_claystone_white",
            "stone_conglomerate_normal",
            "stone_sandstone_grey",
            "stone_sandstone_pale",
            "stone_siltstone_dark",
        },
    }

end

function unilib.pkg.ore_aotearoa_mineral_limonite_antipodean_rock.post()

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "blob",
        ore                     = "unilib:mineral_limonite_antipodean_rock",
        wherein                 = {
            "unilib:stone_claystone_white",
            "unilib:stone_conglomerate_normal",
            "unilib:stone_siltstone_dark",
        },

        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 5,
        noise_params            = {
            octaves = 3,
            offset = 0.5,
            persist = 0.8,
            scale = 0.03,
            seed = 1184053,
            spread = {x = 40, y = 40, z = 40},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.constant.y_max,
        y_min                   = unilib.constant.y_min,
    })

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "blob",
        ore                     = "unilib:mineral_limonite_antipodean_rock",
        wherein                 = {
            "unilib:stone_basalt_black",
            "unilib:stone_sandstone_grey",
            "unilib:stone_sandstone_pale",
        },

        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 2,
        noise_params            = {
            octaves = 3,
            offset = 0.5,
            persist = 0.8,
            scale = 0.03,
            seed = 1184053,
            spread = {x = 40, y = 40, z = 40},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.constant.y_max,
        y_min                   = unilib.constant.y_min,
    })

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "scatter",
        ore                     = "unilib:mineral_limonite_antipodean_rock",
        wherein                 = {
            "unilib:stone_basalt_black",
            "unilib:stone_claystone_white",
            "unilib:stone_conglomerate_normal",
            "unilib:stone_sandstone_grey",
            "unilib:stone_sandstone_pale",
            "unilib:stone_siltstone_dark",
        },

        clust_num_ores         = 5,
        clust_scarcity         = 9 * 9 * 9,
        clust_size             = 3,
        y_max                  = -256,
        y_min                  = unilib.constant.y_min,
    })

end
