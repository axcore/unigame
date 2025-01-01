---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tnt
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_standard_tnt_ignite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.tnt.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_tnt_ignite.init()

    return {
        description = "ABM to handle ignition of ordinary TNT (from minetest_game/tnt)",
    }

end

function unilib.pkg.abm_standard_tnt_ignite.post()

    -- Adapted from tnt/init.lua
    -- Handle ignition of ordinary TNT

    if not unilib.global.enable_explosives_flag then
        return
    end

    unilib.register_abm({
        label = "Ordinary TNT ignition [abm_standard_tnt_ignite]",
        nodenames = {"group:tnt", "unilib:tnt_gunpowder"},
        neighbors = {
            "unilib:fire_ordinary",
            "unilib:liquid_lava_ordinary_flowing",
            "unilib:liquid_lava_ordinary_source",
        },

        chance = 1,
        interval = 4,

        action = function(pos, node)
            unilib.tnt_burn(pos, node.name)
        end,
    })
    unilib.register_obsolete_abm({
        mod_origin = "tnt",
        label = "TNT ignition",
    })

end
