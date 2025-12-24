---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_die = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_die.add_to_queue(self, priority)

    -- Adapted from mobkit.hq_die(), duplicated by kitz.hq_die()
    -- Called by most brain packages, which typically check the mob is still alive, before calling a
    --      behaviour
    -- On the first call, makes the mob fall over (launching the "lqb_fall_over" behaviour). Then
    --      waits a few seconds, before removing the mob from the world
    -- The "priority" argument, if specified, is ignored; this behaviour is always added to the
    --      queue with the highest priority

    -- (Persistent data used to preserve state between calls to the closure below)
    local start_flag = true
    local timer = 5

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if start_flag then

            start_flag = false

            unilib.pkg.lqb_fall_over.add_to_queue(self)
            unimobs.mobkit_api.apply_brain_death(self)

        end

        timer = timer - self.dtime
        if timer < 0 then
            self.object:remove()
        end

    end

    -- As described in the notes for the function, the -1 value means "make this behaviour the
    --      highest-priority one"
    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_die", func, -1)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_die.init()

    return {
        description = "Standard high-level mob behaviour: default death behaviour",
        notes = "Kill the mob, rotate it, and remove() the entity",
        depends = "lqb_fall_over",
    }

end
