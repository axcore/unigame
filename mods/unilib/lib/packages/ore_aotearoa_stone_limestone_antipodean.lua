---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_aotearoa_stone_limestone_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_aotearoa_stone_limestone_antipodean.init()

    return {
        description = "Antipodean limestone",
        depends = "stone_limestone_antipodean",
        at_least_one = {"stone_sandstone_grey", "stone_sandstone_pale"},
    }

end

function unilib.pkg.ore_aotearoa_stone_limestone_antipodean.post()

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "blob",
        ore                     = "unilib:stone_limestone_antipodean",
        wherein                 = {
            "unilib:stone_sandstone_grey",
            "unilib:stone_sandstone_pale",
        },

        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 25,
        noise_params            = {
            octaves = 1,
            offset = 0,
            persist = 0.0,
            scale = 1,
            seed = -2018,
            spread = {x = 15, y = 15, z = 15},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.y_max,
        y_min                   = unilib.y_min,
    })

end
