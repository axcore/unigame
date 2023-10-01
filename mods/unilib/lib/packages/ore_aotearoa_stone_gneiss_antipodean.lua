---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_aotearoa_stone_gneiss_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_aotearoa_stone_gneiss_antipodean.init()

    return {
        description = "ntipodean gneiss as ore",
        depends = "stone_gneiss_antipodean",
        at_least_one = {"stone_ordinary", "stone_schist_antipodean"},
    }

end

function unilib.pkg.ore_aotearoa_stone_gneiss_antipodean.post()

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "blob",
        ore                     = "unilib:stone_gneiss_antipodean",
        wherein                 = {"unilib:stone_ordinary", "unilib:stone_schist_antipodean"},

        clust_scarcity          = 16 * 16 * 16,
        clust_size              = 15,
        noise_params            = {
            octaves = 1,
            offset = 0,
            persist = 0.0,
            scale = 1,
            seed = 56752,
            spread = {x = 15, y = 15, z = 15},
        },
        noise_threshold         = 0.0,
        y_max                   = unilib.y_max,
        y_min                   = unilib.y_min,
    })

end
