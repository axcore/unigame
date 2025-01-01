---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_aotearoa_air = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_aotearoa_air.init()

    return {
        description = "Air as decoration",
        at_least_one = {
            "stone_basalt_black",
            "stone_limestone_antipodean",
            "stone_limestone_coquina",
            "stone_scoria",
        },
    }

end

function unilib.pkg.ore_aotearoa_air.post()

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "blob",
        ore                     = "air",
        wherein                 = {
            "unilib:stone_basalt_black",
            "unilib:stone_limestone_antipodean",
            "unilib:stone_limestone_coquina",
            "unilib:stone_scoria",
        },

        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 4,
        noise_params            = {
            octaves = 2,
            offset = 0.5,
            persist = 0.9,
            scale = 0.6,
            seed = -999931,
            spread = {x = 10, y = 10, z = 10},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.constant.y_max,
        y_min                   = unilib.constant.y_min,
    })

end
