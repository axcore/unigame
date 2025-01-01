---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_standard_cactus_grow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_cactus_grow.init()

    return {
        description = "ABM to handle cactus growth (from minetest_game/default)",
    }

end

function unilib.pkg.abm_standard_cactus_grow.post()

    -- Adadpted from default/functions.lua
    -- Handles growth of cactus from a single node, in an upwards direction

    unilib.register_abm({
        label = "Cactus growth [abm_standard_cactus_grow]",
        nodenames = {"group:cactus_grow"},
        neighbors = {"group:sand"},

        chance = 83,
        interval = 12,

        action = function(pos, node)
            unilib.flora.grow_cactus(pos, node)
        end,
    })
    unilib.register_obsolete_abm({
        mod_origin = "default",
        label = "Grow cactus",
    })

end
