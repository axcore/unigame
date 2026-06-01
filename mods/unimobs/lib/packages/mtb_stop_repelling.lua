---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_stop_repelling = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_stop_repelling.do_action(self, player)

    -- Original to unimobs
    -- Called for a mob which is moving away from the specified player, because they are wielding a
    --      particular item
    -- If "player" is not specified, or if they are no longer wielding the right item, then the
    --      behaviour "mtb_order_autonomy" is called; otherwise do nothing

    if not player then

        unilib.pkg.mtb_order_autonomy.do_action(self)
        return true

    else

        local wielded_name = player:get_wielded_item():get_name()
        if not unimobs.petz_api.check_lookup_table_in_msetting_by_group(
            self.mob_type, "repel_item_table", wielded_name
        ) then

            unilib.pkg.mtb_order_autonomy.do_action(self)
            return true

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_stop_repelling.init()

    return {
        description = "Standard mob meta-behaviour: the mob stops being repelled by something",
        notes = "See also the related behaviour in the \"mtb_start_repelling\" package",
        depends = "mtb_order_autonomy",
    }

end
