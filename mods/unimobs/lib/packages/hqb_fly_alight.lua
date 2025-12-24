---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_fly_alight = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_fly_alight.add_to_queue(self, priority, end_status)

    -- Adapted from petz.hq_alight()
    -- Standard landing behaviour for flying mobs
    -- If above air, launches the "lqb_fly_alight" behaviour, and waits for the mob to land. If
    --      above water, terminates this behaviour and launches "hqb_fly_wander" instead
    -- Otherwise, the mob is already on the ground. "end_status", if specified, is used to set the
    --      mob's "status" property. If its value is "stand", this behaviour launches the "lqb_idle"
    --      behaviour; in either case, this behaviour terminates immediately

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        local below_node = unimobs.petz_api.get_node_at_named_location(self, "below")
        if below_node and below_node.name == "air" then

            unilib.pkg.lqb_fly_alight.add_to_queue(self)

        elseif below_node and core.get_item_group(below_node.name, "water") >= 1 then

            unilib.pkg.hqb_fly_wander.add_to_queue(self, 0)
            return true

        else

            if end_status == "stand" then

                unimobs.mobkit_api.do_entity_animation(self, end_status)
                unilib.pkg.lqb_idle.add_to_queue(self, 2400)

            end

            self.status = unimobs.mobkit_api.add_mob_memory(self, "status", end_status)
            return true

        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_fly_alight", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_fly_alight.init()

    return {
        description = "Standard high-level mob behaviour: land on the surface",
        notes = "See also the related behaviours in the \"mtb_fly_alight\" and" ..
                " \"lqb_fly_alight\" packages",
        depends = {"hqb_fly_wander", "lqb_fly_alight", "lqb_idle"},
    }

end
