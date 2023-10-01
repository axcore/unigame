---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_aotearoa_mineral_diamond = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_aotearoa_mineral_diamond.init()

    return {
        description = "Diamond blocks as ore",
        depends = "mineral_diamond",
        at_least_one = {"stone_gneiss_antipodean", "stone_schist_antipodean"},
    }

end

function unilib.pkg.ore_aotearoa_mineral_diamond.post()

    unilib.register_ore({
        -- From aotearoa/ores.lua
        ore_type                = "scatter",
        ore                     = "unilib:mineral_diamond_block",
        wherein                 = {
            "unilib:stone_gneiss_antipodean",
            "unilib:stone_schist_antipodean",
        },

        clust_num_ores          = 4,
        clust_scarcity          = 15 * 15 * 15,
        clust_size              = 3,
        y_max                   = -256 * 1.5,
        y_min                   = unilib.y_min,
    })

end
