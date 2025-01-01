---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_aotearoa_mineral_coal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_aotearoa_mineral_coal.init()

    return {
        description = "Coal blocks as ore",
        depends = "mineral_coal",
        at_least_one = {"stone_sandstone_grey", "stone_sandstone_pale"},
    }

end

function unilib.pkg.ore_aotearoa_mineral_coal.post()

    if unilib.global.pkg_executed_table["stone_sandstone_grey"] ~= nil then

        unilib.register_ore({
            -- From aotearoa/ores.lua
            ore_type            = "blob",
            ore                 = "unilib:mineral_coal_block",
            wherein             = "unilib:stone_sandstone_grey",

            clust_scarcity      = 16 * 16 * 16,
            clust_size          = 5,
            noise_params        = {
                octaves = 3,
                offset = 0.5,
                persist = 0.8,
                scale = 0.03,
                seed = 7886,
                spread = {x = 40, y = 40, z = 40},
            },
            noise_threshold     = 0.0,
            y_max               = unilib.constant.y_max,
            y_min               = unilib.constant.y_min,
        })

    end

    if unilib.global.pkg_executed_table["stone_sandstone_pale"] ~= nil then

        unilib.register_ore({
            -- From aotearoa/ores.lua
            ore_type            = "blob",
            ore                 = "unilib:mineral_coal_block",
            wherein             = "unilib:stone_sandstone_pale",

            clust_scarcity      = 16 * 16 * 16,
            clust_size          = 2,
            noise_params        = {
                octaves = 3,
                offset = 0.5,
                persist = 0.8,
                scale = 0.03,
                seed = 7886,
                spread = {x = 40, y = 40, z = 40},
            },
            noise_threshold     = 0.0,
            y_max               = unilib.constant.y_max,
            y_min               = unilib.constant.y_min,
        })

    end

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "scatter",
        ore                     = "unilib:mineral_coal_block",
        wherein                 = {
            "unilib:stone_sandstone_grey",
            "unilib:stone_sandstone_pale",
        },

        clust_num_ores          = 5,
        clust_scarcity          = 9 * 9 * 9,
        clust_size              = 3,
        y_max                   = -256,
        y_min                   = unilib.constant.y_min,
    })

end
