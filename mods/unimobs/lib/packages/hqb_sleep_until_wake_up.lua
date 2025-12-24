---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_sleep_until_wake_up = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function has_sleeping_place(self)

    local node = core.get_node(unimobs.mobkit_api.get_standing_pos(self))
    if core.get_item_group(node.name, "sleeping_place") > 0 then
        return true
    else
        return false
    end

end

local function wake_up(self)

    -- N.B. In original code, both queues are cleared, but the mob tends to go straight back to
    --      sleep (which is no good, if a cat's basket was destroyed by the player)
    -- We can prevent this problem by launching a roaming behaviour
--  unimobs.mobkit_api.clear_high_level_queue(self)
    unilib.pkg.mtb_order_autonomy.do_action(self)

    -- (Update textures to remove closed eyelids)
    local texture = self.textures[self.mob_texture_num]
    self.object:set_properties(self, {textures = {texture}})
    self.status = unimobs.mobkit_api.add_mob_memory(self, "status", self.previous_status)

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_sleep_until_wake_up.add_to_queue(self, priority, force_flag)

    -- Adapted from petz.hq_sleep()
    -- This behaviour should not be called directly; instead, call
    --      unilib.pkg.mtb_fall_asleep.do_action() (or call **unimobs.petz_api.send_mob_to_sleep()
    --      directly)
    -- Checks whether it's time for the sleeping mob to wake up and, if so, wakes them up
    -- "force_flag" is true when the mob is sleeping indefinitely (for example, when a cat is placed
    --      in a basket). In that case, the mob only wakes up when the basket is destroyed (or the
    --      game restarts)

    -- (Persistent data used to preserve state between calls to the closure below)
    local timer = 2
    local init_flag = true
    local sleeping_place_flag = false

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        -- N.B. In original code, there was no way to awake a cat which was placed (as a spawn egg)
        --      in a cat basket
        -- Fix that problem here; a cat sleeping on a node with the sleeping_place = 1 group is
        --      awakened when the node is destroyed, regardless of whether it was placed as a
        --      spawn egg, or fell asleep of its own accord
        if init_flag then

            init_flag = false
            sleeping_place_flag = has_sleeping_place(self)

        end

        timer = timer - self.dtime
        if timer <  0 then

            -- N.B. Second part of fix above: check the cat basket (etc) has not been destroyed
            if sleeping_place_flag and not has_sleeping_place(self) then

                wake_up(self)
                return true

            -- N.B. Original code resumes here
            elseif not force_flag then

                -- (Convert value in the range 0-1, to a value in the range 0-24000)
                local current_time = core.get_timeofday() * 24000
                local sleep_start_time = self.sleep_start_time
                local sleep_end_time = self.sleep_end_time

                if self.sleep_in_night_flag then

                    if current_time > 19500 then
                        sleep_end_time = 23999
                    elseif current_time < 4500 then
                        sleep_start_time = 0
                    end

                end

                -- Check the status has not changed
                if self.status == "sleep" and timer < 0 and (
                    (self.sleep_in_night_flag and not unimobs.petz_api.is_night()) or
                    (self.sleep_in_day_flag and unimobs.petz_api.is_night()) or
                    current_time < sleep_start_time or
                    current_time > sleep_end_time
                ) then

                    wake_up(self)
                    return true

                else

                    unimobs.petz_api.show_standard_particles(self.object:get_pos(), "sleep")

                end

            else

                unimobs.petz_api.show_standard_particles(self.object:get_pos(), "sleep")

            end

            timer = 2

        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_sleep_until_wake_up", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_sleep_until_wake_up.init()

    return {
        description = "Standard high-level mob behaviour: continue sleeping until it's time to" ..
                " wake up",
    }

end
