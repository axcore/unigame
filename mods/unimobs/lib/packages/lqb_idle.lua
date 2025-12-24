---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.lqb_idle = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_idle.add_to_queue(self, duration, anim)

    -- Adapted from mobkit.lq_idle(), duplicated by kitz.lq_idle()
    -- The mob does the specified animation for "duration" seconds, after which the behaviour
    --      terminates

    -- (Apply default values to optional arguments)
    anim = anim or "stand"

    -- (Persistent data used to preserve state between calls to the closure below)
    local init_flag = true

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        if init_flag then

            unimobs.mobkit_api.do_entity_animation(self, anim)
            init_flag = false

        end

        duration = duration - self.dtime
        if duration <= 0 then
            return true
        end

    end

    unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_idle", func)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_idle.init()

    return {
        description = "Standard low-level mob behaviour: do nothing for the specified duration",
        notes = "The duration is measured in seconds; the mob's \"stand\" animation is set",
    }

end
