---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_cron.lua
--      Server cron calls from the petz/petz mod (NOT part of the petz API)
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

---------------------------------------------------------------------------------------------------
-- Setup code (from /petz/petz/server/cron.lua)
---------------------------------------------------------------------------------------------------

if unimobs.petz_setting.clear_untamed_mobs_interval > 0 then

    unimobs.kitz_api.create_cron_task_to_clear_mobs(
        unimobs.petz_setting.clear_untamed_mobs_interval, modname
    )

end
