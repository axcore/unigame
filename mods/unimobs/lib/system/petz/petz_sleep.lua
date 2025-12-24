---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_sleep.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_sleep.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.calculate_sleep_times(self)

    -- From petz.calculate_sleep_times()
    -- Called from unimobs.petz_api.calculate_sleep_times()
    -- If sleeping is enabled, sets the specified mob's .sleep_start_time and .sleep_end_time
    --      properties

    if unimobs.petz_setting.enable_sleeping_flag and
            (self.sleep_in_night_flag or self.sleep_in_day_flag) then

        local sleep_time, sleep_start_time, sleep_end_time, sleep_end_time_limit

        if self.sleep_in_night_flag then

            local night_start = 19500
            local night_duration = 9000
            local almost_day = 23999

            sleep_time = night_duration * (self.sleep_ratio or 1)
            sleep_end_time_limit = almost_day + 4500
            sleep_start_time = random(night_start, (sleep_end_time_limit - sleep_time))
            sleep_end_time = sleep_start_time + sleep_time

            if sleep_start_time > almost_day then
                sleep_start_time = sleep_end_time_limit - sleep_start_time
            end

            if sleep_end_time > almost_day then
                sleep_end_time = sleep_end_time - almost_day
            end

        else

            -- (self.sleep_in_day_flag == true)
            local day_start = 4500
            local day_duration = 15000

            sleep_time = day_duration * (self.sleep_ratio or 1)
            sleep_end_time_limit = 19500
            sleep_start_time = random(day_start, (sleep_end_time_limit - sleep_time))
            sleep_end_time = sleep_start_time + sleep_time

        end

        self.sleep_start_time =
                unimobs.mobkit_api.add_mob_memory(self, "sleep_start_time", sleep_start_time)
        self.sleep_end_time =
                unimobs.mobkit_api.add_mob_memory(self, "sleep_end_time", sleep_end_time)

    end

end

function unimobs.petz_api.send_mob_to_sleep(self, priority, force_flag)

    -- From petz.sleep()
    -- Can be called by anything, to put the specified mob into sleep mode
    -- Having set new textures and a few properties, starts the "hqb_sleep_until_wake_up" behaviour
    --      (so sleep mode won't start if that package is not loaded)
    -- The "priority" and "force_flag" arguments are passed directly to the
    --      "hqb_sleep_until_wake_up" behaviour

    if unilib.global.pkg_executed_table["hqb_sleep_until_wake_up"] == nil then
        return
    end

    self.status = unimobs.mobkit_api.add_mob_memory(self, "status", "sleep")
    unimobs.mobkit_api.do_entity_animation(self, "sleep")

    -- (Update textures to apply closed eyelids)
    local mob_texture_num = self.mob_texture_num or 1
    local texture = self.textures[mob_texture_num]
    self.object:set_properties(
        self,
        {textures = {texture .. "^unilib_mob_" .. self.mob_type .. "_sleep_overlay.png"}}
    )

    unilib.pkg.hqb_sleep_until_wake_up.add_to_queue(self, priority, force_flag)

end
