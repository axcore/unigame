---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- kitz_cron.lua
--      Shared API functions from the petz/kitz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

---------------------------------------------------------------------------------------------------
-- Local functions (from petz/kitz/api/api_cron.lua)
---------------------------------------------------------------------------------------------------

function clear_mobs(cron_time, mod_name)

    -- Was kitz.cron_clear_mobs()
    -- Called periodically by unimobs.kitz_api.create_cron_task_to_clear_mobs()

    for _, player in ipairs(core.get_connected_players()) do

        local player_pos = player:get_pos()
        unimobs.kitz_api.clear_mobs_in_range(player_pos, mod_name)

    end

    -- Continue the cron task
    unimobs.kitz_api.create_cron_task_to_clear_mobs(cron_time, mod_name)

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/kitz/api/api_cron.lua)
---------------------------------------------------------------------------------------------------

function unimobs.kitz_api.create_cron_task_to_clear_mobs(cron_time, mod_name)

    -- Was kitz.cron_clear()
    -- Creates a cron task to clear all the untamed mobs from the mod "mod_name" within range of all
    --      server players, from time to time
    -- If "cron_time" <= 0, then the cron task does not run

    if cron_time > 0 then

        core.after(
            cron_time,
            function()
                clear_mobs(cron_time, mod_name)
            end,
            cron_time,
            mod_name
        )

    end

end
