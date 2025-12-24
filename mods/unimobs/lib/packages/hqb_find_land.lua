---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_find_land = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_find_land.add_to_queue(self, priority)

    -- Adapted from mobkit.hq_liquid_recovery(), duplicated by kitz.hq_liquid_recovery()
    -- Scans for a nearby non-liquid node. If found, approaches it and tries to jump onto it
    -- If not already in a liquid, the behaviour terminates without doing anything.
    -- N.B. This function's behaviour differs when unimobs.setting.tweak_mobkit_engine_flag is set

    -- (Persistent data used to preserve state between calls to the closure below)
    local radius = 1
    local yaw = 0

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or not self.isinliquid then
            return true
        end

        -- N.B. The original version of the code scans for nodes at a questionable vertical location
--      local stand_pos = self.object:get_pos()
        local stand_pos = unimobs.mobkit_api.get_standing_pos(self.object)
        local vec = core.yaw_to_dir(yaw)
        local target_pos =
                unimobs.mobkit_api.shift_pos_by_vector(stand_pos, vector.multiply(vec, radius))
        local height, liquid_flag = unimobs.mobkit_api.get_walkable_terrain_height(target_pos)
        if height and not liquid_flag then

            unilib.pkg.hqb_swim_to.add_to_queue(self, priority, target_pos)
            return true

        end

        yaw = yaw + (math.pi * 0.25)
        if yaw > (2 * math.pi) then

            yaw = 0
            radius = radius + 1
            if radius > self.view_range then

                if not unimobs.setting.tweak_mobkit_engine_flag then
                    self.hp = 0
                else
                    unimobs.mobkit_api.apply_damage(self, self.hp, "stuck in liquid")
                end

                return true

            end

        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_find_land", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_find_land.init()

    return {
        description = "Standard high-level mob behaviour: when submerged in a liquid, scan for" ..
                " the nearest land",
        notes = "If land is found within the mob's view range, the \"hqb_swim_to\" behaviour" ..
                " is initiated; otherwise the mob dies",
        depends = "hqb_swim_to",
    }

end
