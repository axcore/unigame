---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_fall_asleep = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_fall_asleep.do_action(self, priority)

    -- Adapted from petz.bh_sleep()
    -- Depending on the time of day, and on the mob's properties, the mob falls asleep
    -- The **hqb_sleep_until_wake_up** behaviour is launched automatically (via an API call), and
    --      handles waking up

    if not unimobs.petz_setting.enable_sleeping_flag or
            unimobs.petz_api.is_mob_in_liquid(self) then
        return
    end

    if (self.sleep_in_night_flag and unimobs.petz_api.is_night()) or
            (self.sleep_in_day_flag and not unimobs.petz_api.is_night()) then

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

        if self.status ~= "sleep" and
                current_time > sleep_start_time and
                current_time < sleep_end_time then

            self.previous_status =
                    unimobs.mobkit_api.add_mob_memory(self, "previous_status", self.status)
            unimobs.petz_api.send_mob_to_sleep(self, priority, false)

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_fall_asleep.init()

    return {
        description = "Standard mob meta-behaviour: fall sleep",
    }

end
