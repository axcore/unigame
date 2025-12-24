---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_look_at = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_look_at.add_to_queue(self, priority, player_pos)

    -- Adapted from petz.hq_look_at()
    -- The mob turns its head to look at the player at "player_pos". A few seconds later, it turns
    --      its head back to the neutral position

    -- (Persistent data used to preserve state between calls to the closure below)
    local looking_flag = false

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        -- Allow the code in the core.after() call to complete, before finishing this behaviour
        if not looking_flag then

            local random_time = random(1, 2)
            unilib.pkg.mtb_move_head.do_action(self, player_pos)
            unimobs.mobkit_api.do_entity_animation(self, "idle")

            core.after(random_time, function()

                if unimobs.mobkit_api.is_object_alive(self) then

                    unimobs.mobkit_api.clear_both_queues(self)
                    unilib.pkg.mtb_restore_head.do_action(self)
                    looking_flag = false
                    return true

                end

            end, self)

            looking_flag = true

        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_look_at", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_look_at.init()

    return {
        description = "Standard high-level mob behaviour: look at a nearby player",
        notes = "See also the related behaviour in the \"mtb_look_at\" package",
        depends = {"mtb_move_head", "mtb_restore_head"},
    }

end
