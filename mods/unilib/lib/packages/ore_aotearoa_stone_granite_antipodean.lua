---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_aotearoa_stone_granite_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_aotearoa_stone_granite_antipodean.init()

    return {
        description = "Antipodean granite as ore",
        depends = "stone_granite_antipodean",
        at_least_one = {
            "stone_gneiss_antipodean",
            "stone_greywacke_dark",
            "stone_ordinary",
            "stone_schist_antipodean",
        },
    }

end

function unilib.pkg.ore_aotearoa_stone_granite_antipodean.post()

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "blob",
        ore                     = "unilib:stone_granite_antipodean",
        wherein                 = {
            "unilib:stone_gneiss_antipodean",
            "unilib:stone_greywacke_dark",
            "unilib:stone_ordinary",
            "unilib:stone_schist_antipodean",
        },

        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 15,
        noise_params            = {
            octaves = 1,
            offset = 0,
            persist = 0.0,
            scale = 1,
            seed = -30027,
            spread = {x = 15, y = 15, z = 15},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.y_max,
        y_min                   = unilib.y_min,
    })

end
