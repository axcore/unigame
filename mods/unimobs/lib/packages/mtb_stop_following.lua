---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_stop_following = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_stop_following.do_action(self, player)

    -- Adapted from petz.bh_stop_follow()
    -- Called for a mob which is following the specified player, because they are wielding a
    --      particular item
    -- If "player" is not specified, or if they are no longer wielding the right item, then the
    --      "mtb_order_autonomy" behaviour is called; otherwise do nothing

    if not player then

        unilib.pkg.mtb_order_autonomy.do_action(self)

    else

        local wielded_name = player:get_wielded_item():get_name()
        if not unimobs.petz_api.check_lookup_table_in_msetting_by_group(
            self.mob_type, "follow_item_table", wielded_name
        ) then

            unilib.pkg.mtb_order_autonomy.do_action(self)
            return true

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_stop_following.init()

    return {
        description = "Standard mob meta-behaviour: the mob stops following something",
        notes = "See also the related behaviour in the \"mtb_start_following\" package",
        depends = "mtb_order_autonomy",
    }

end
