---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_lifespan.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_lifetime.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.check_lifespan(self)

    -- From petz.check_lifetime()
    -- Called from unimobs.petz_api.on_step_callback()
    -- Returns the mob's lifespan (in seconds), or nil
    -- N.B. Original code returned false, rather than nil

    local custom_lifespan = unimobs.petz_api.get_custom_msetting(self.mob_type, "custom_lifespan")

    if self.has_dreamcatcher_flag or (
        unimobs.petz_setting.disable_lifespan_for_tamed_mobs_flag and self.is_tamed_flag
    ) or (
        unimobs.petz_setting.disable_lifespan_for_breeding_mobs_flag and self.can_breed_flag
    ) then
        return
    elseif unimobs.petz_setting.default_lifespan > 0 and
            not (custom_lifespan and custom_lifespan < 0) then
        return unimobs.petz_setting.default_lifespan
    elseif custom_lifespan and custom_lifespan > 0 then
        return custom_lifespan
    else
        return
    end

end

function unimobs.petz_api.lifespan_timer(self, lifespan, on_step_time)

    -- From petz.lifetime_timer()
    -- Function called regularly, by unimobs.petz_api.on_step_callback(), to apply damage to a mob
    --      whose lifespan has expired (does not apply to mobs without a lifespan)

    if not self.lifespan then

        -- Apply the variability first
        local variability =
                lifespan * (random(0, unimobs.petz_setting.lifespan_variability * 100) / 100)

        if random(1, 2) == 1 then
            variability = -variability
        end

        lifespan = unimobs.kitz_api.round_number(lifespan - variability)
        self.lifespan = unimobs.mobkit_api.add_mob_memory(self, "lifespan", lifespan)

    end

    self.lifespan =
            unimobs.mobkit_api.add_mob_memory(self, "lifespan", self.lifespan - on_step_time)
    if self.lifespan <= 0 and not self.is_dead_flag then
        unimobs.mobkit_api.apply_damage(self, self.hp, "lifespan ran out")
    end

end
