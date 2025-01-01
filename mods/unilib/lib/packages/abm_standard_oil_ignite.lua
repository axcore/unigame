---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    forest
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_standard_oil_ignite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.forest.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_oil_ignite.init()

    return {
        description = "ABM to handle ignition of oil (from forest)",
        depends = "fire_ordinary",
    }

end

function unilib.pkg.abm_standard_oil_ignite.post()

    -- Adapted from forest/oil.lua
    -- Handle oil ignition

    if not unilib.global.enable_fire_flag then
        return
    end

    unilib.register_abm({
        label = "Oil ignition [abm_standard_oil_ignite]",
        nodenames = {"group:oil"},
        neighbors = {"group:igniter"},

        chance = 10,
        interval = 2,

        action = function(pos)

            core.set_node(pos, {name = "unilib:fire_ordinary"})
            core.sound_play("unilib_cool_lava", {pos = pos, gain = 0.25})

        end,
    })

end
