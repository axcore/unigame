---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_find_liquid = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_find_liquid.add_to_queue(self, priority)

    -- Adapted from petz.hq_liquid_search()
    -- Scans for a nearby liquid. If found, approaches it and tries to jump in
    -- If already in a liquid, the behaviour terminates without doing anything

    -- (Persistent data used to preserve state between calls to the closure below)
    local radius = 1
    local yaw = 0

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or self.isinliquid then
            return true
        end

        -- N.B. The original version of the code scans for nodes at a questionable vertical location
--      local stand_pos = self.object:get_pos()
        local stand_pos = unimobs.mobkit_api.get_standing_pos(self.object)
        local vec = core.yaw_to_dir(yaw)
        local target_pos =
                unimobs.mobkit_api.shift_pos_by_vector(stand_pos, vector.multiply(vec, radius))
        local height, liquid_flag = unimobs.mobkit_api.get_walkable_terrain_height(target_pos)

        -- N.B. The original version of the code seems to be using the wrong logic
--      if height and not liquid_flag then
        if height and liquid_flag then

            unilib.pkg.hqb_goto_liquid.add_to_queue(self, priority, target_pos)
            return true

        end

        -- N.B. The original version of the code seems to be unfinished; modified it so that it
        --      resembles the corresponding code in "hqb_find_land"
        yaw = yaw + (math.pi * 0.25)
        if yaw > (2 * math.pi) then

            yaw = 0
            radius = radius + 1
            if radius > self.view_range then
                return true
            end

        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_find_liquid", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_find_liquid.init()

    return {
        description = "Standard high-level mob behaviour: scan for the nearest liquid, then" ..
                " approach it and jump in",
        depends = "hqb_goto_liquid",
    }

end
