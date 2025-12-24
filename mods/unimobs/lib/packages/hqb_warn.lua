---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_warn = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_warn.add_to_queue(self, priority, target_obj)

    -- Adapted from mobkit.hq_warn(), duplicated by kitz.hq_warn()
    -- The specified "target_obj" can be a player or another creature.
    -- If "target_obj" is too close, the mob attacks it. Otherwise, the mob turns towards it and
    --      occasionally makes warning sounds
    -- The behaviour terminates when "target_obj" moves far away

    -- (Persistent data used to preserve state between calls to the closure below)
    local init_flag = true
    local timer = 0
    local warn_time = 0

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or
                not unimobs.mobkit_api.is_object_alive(target_obj) then
            return true
        end

        if init_flag then

            unimobs.mobkit_api.do_entity_animation(self, "stand")
            init_flag = false

        end

        local stand_pos = unimobs.mobkit_api.get_standing_pos(self)
        if not stand_pos then
            return true
        end

        local target_pos = target_obj:get_pos()
        local dist = vector.distance(stand_pos, target_pos)

        if dist > 11 then

            return true

        elseif dist < 4 or timer > 12 then

            -- Target object is too close...
            unimobs.mobkit_api.add_mob_memory(self, "hate", target_obj:get_player_name())
            -- ...so initiate hunting behaviour
            unilib.pkg.hqb_hunt.add_to_queue(self, priority + 1, target_obj)

        else

            timer = timer + self.dtime
            if unimobs.mobkit_api.is_low_level_queue_empty(self) then
                unilib.pkg.lqb_turn_to_pos.add_to_queue(self, target_pos)
            end

            -- Make noise at random intervals
            if timer > warn_time then

                unimobs.mobkit_api.do_entity_sound(self, "warn")
                warn_time = timer + 1.1 + (random() * 1.5)

            end
        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_warn", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_warn.init()

    return {
        description = "Standard high-level mob behaviour: warn a nearby player/creature",
        notes = "Initiate the \"hqb_hunt\" behaviour if the object gets too close, or if the" ..
                " timer expires. The closure function returns true when the object moves away",
        depends = {"hqb_hunt", "lqb_turn_to_pos"},
    }

end
