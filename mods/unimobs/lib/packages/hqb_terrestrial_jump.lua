---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_terrestrial_jump = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_terrestrial_jump.add_to_queue(self, priority)

    -- Adapted from petz.hq_terrestial_jump()
    -- The mob jumps in the forward direction, calling the "mtb_set_forward_velocity" behaviour to
    --      do so
    -- This behaviour is not added to the queue at all, when the mob is near water or air (e.g. a
    --      cliff)

    -- Before adding the behaviour to the queue, check for water and air (i.e. a cliff)
    local front_below_node = unimobs.petz_api.get_node_at_named_location(self, "front_below")
    if not front_below_node or
            core.registered_nodes[front_below_node.name]["liquidtype"] == "source" or
            core.registered_nodes[front_below_node.name]["liquidtype"] == "flowing" or
            front_below_node.name == "air" then
        return
    end

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        -- Fixed bug in original code, which just assumes that self.jump_impulse is set
        local jump_impulse = self.jump_impulse or 1

        local vel = {
            x = self.max_speed * (jump_impulse / 3),
            y = self.max_speed * jump_impulse,
            z = self.max_speed * (jump_impulse / 3),
        }

        unilib.pkg.mtb_set_forward_velocity.do_action(self, vel)

        unimobs.mobkit_api.do_entity_animation(self, "jump")
        self.object:set_acceleration({x = 1.0, y = jump_impulse, z = 1.0})
        self.status = unimobs.mobkit_api.add_mob_memory(self, "status", "jump")
        unimobs.mobkit_api.do_entity_animation(self, "fly")

        core.after(0.5, function()

            if unimobs.mobkit_api.is_object_alive(self.object) then

                self.status = unimobs.mobkit_api.add_mob_memory(self, "status", nil)
                unimobs.mobkit_api.clear_high_level_queue(self)

            end

        end, self, vel)

        return true

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_terrestrial_jump", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_terrestrial_jump.init()

    return {
        description = "Standard high-level mob behaviour: while on the ground, jump",
        depends = "mtb_set_forward_velocity",
    }

end
