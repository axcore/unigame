---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_aotearoa_stone_quartz_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_aotearoa_stone_quartz_antipodean.init()

    return {
        description = "Antipodean quartz as ore",
        depends = "stone_quartz_antipodean",
        at_least_one = {
            "stone_andesite_antipodean",
            "stone_schist_antipodean",
        },
    }

end

function unilib.pkg.ore_aotearoa_stone_quartz_antipodean.post()

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "blob",
        ore                     = "unilib:stone_quartz_antipodean",
        wherein                 = {
            "unilib:stone_andesite_antipodean",
            "unilib:stone_schist_antipodean",
        },

        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 3,
        noise_params            = {
            octaves = 3,
            offset = 0.5,
            persist = 0.8,
            scale = 0.03,
            seed = -7444,
            spread = {x = 40, y = 40, z = 40},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.y_max,
        y_min                   = unilib.y_min,
    })

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "scatter",
        ore                     = "unilib:stone_quartz_antipodean",
        wherein                 = {
            "unilib:stone_andesite_antipodean",
            "unilib:stone_schist_antipodean",
        },

        clust_num_ores          = 5,
        clust_scarcity          = 9 * 9 * 9,
        clust_size              = 3,
        y_max                   = -256,
        y_min                   = unilib.y_min,
    })

end
