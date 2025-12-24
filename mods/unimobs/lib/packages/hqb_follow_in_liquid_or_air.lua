---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_follow_in_liquid_or_air = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_follow_in_liquid_or_air.add_to_queue(self, priority, player)

    -- Adapted from petz.hq_followliquidair()
    -- Called only for flying and aquatic mobs
    -- Makes the mob follow the specified player, launching the "lqb_follow_in_liquid_or_air"
    --      behaviour to do so
    -- This behaviour terminates when the player is outside the mob's view range. It also terminates
    --      when an aquatic mob is above a non-liquid node. In both cases, "mtb_order_autonomy" is
    --      called instead

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        local stand_pos = unimobs.mobkit_api.get_standing_pos(self)
        if not stand_pos then
            return true
        end

        local target_pos = player:get_pos()

        if self.can_swim_flag then

            if not unimobs.petz_api.is_mob_in_liquid(self) then

                -- Check if water is below
                local below_node = unimobs.petz_api.get_node_at_named_location(self, "below")
                if not below_node or core.get_item_group(below_node.name, "water") == 0 then

                    unilib.pkg.mtb_order_autonomy.do_action(self)
                    return true

                end

            end

        end

        if stand_pos and target_pos then

            local distance = vector.distance(stand_pos, target_pos)
            if distance < 3 then

                return

            elseif distance < self.view_range then

                if unimobs.mobkit_api.is_low_level_queue_empty(self) then
                    unilib.pkg.lqb_follow_in_liquid_or_air.add_to_queue(self, player)
                end

            elseif distance >= self.view_range then

                unilib.pkg.mtb_order_autonomy.do_action(self)
                return true

            end

        else

            return true

        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_follow_in_liquid_or_air", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_follow_in_liquid_or_air.init()

    return {
        description = "Standard high-level mob behaviour: follow something",
        notes = "See also the related behaviour in the \"lqb_follow_in_liquid_or_air\" package",
        depends = {"lqb_follow_in_liquid_or_air", "mtb_order_autonomy"},
    }

end
