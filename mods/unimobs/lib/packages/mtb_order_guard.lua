---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_order_guard = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_order_guard.do_action(self)

    -- Adapted from petz.guard()
    -- Sets the mob's "status" property to "guard", clears the high-level queue, and then calls the
    --      "mtb_order_stand" behaviour to set velocity and acceleration to zero
    -- Other packages - for example, "mtb_attack_player" - will, in some situations, only launch an
    --      attack on the player when the mob's "status" is "guard"

    self.status = unimobs.mobkit_api.add_mob_memory(self, "status", "guard")
    unimobs.mobkit_api.clear_high_level_queue(self)
    unilib.pkg.mtb_order_stand.do_action(self)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_order_guard.init()

    return {
        description = "Standard mob meta-behaviour: guard the current location",
        depends = "mtb_order_stand",
    }

end
