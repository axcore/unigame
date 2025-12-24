---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_dumb_step = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

-- Localise math functions (for speed)
local ceil = math.ceil
local random = math.random

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_dumb_step.do_action(
    self, height, target_pos, speed_factor, idle_duration
)
    -- Adapted from mobkit.dumbstep(), duplicated by kitz.dumbstep()
    -- Tries to move to an adjacent node at the specified "target_pos" whose height (relative to
    --      the mob's current position) is "height"
    -- First turns in the correct direction ("lqb_turn_to_pos"), then walks ("lqb_dumb_walk") at a
    --      speed set by the specified "speed_factor", or jumps ("lqb_dumb_jump")
    -- Finally, adds the "lqb_idle" behaviour to the queue, to be executed after the turning/
    --      walking/jumping behaviours terminate. The mob idles for no longer than the specified
    --      "idle_duration" (if none is specified, then the maximum idle time is 6 seconds)

    if height <= 0.001 then

        unilib.pkg.lqb_turn_to_pos.add_to_queue(self, target_pos)
        unilib.pkg.lqb_dumb_walk.add_to_queue(self, target_pos, speed_factor)

    else

        unilib.pkg.lqb_turn_to_pos.add_to_queue(self, target_pos)
        unilib.pkg.lqb_dumb_jump.add_to_queue(self, height)

    end

    idle_duration = idle_duration or 6
    unilib.pkg.lqb_idle.add_to_queue(self, random(ceil(idle_duration * 0.5), idle_duration))

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_dumb_step.init()

    return {
        description = "Standard mob meta-behaviour: turn towards a target position, and either" ..
                " walk or jump towards it",
        depends = {"lqb_dumb_jump", "lqb_dumb_walk", "lqb_idle", "lqb_turn_to_pos"},
    }

end
