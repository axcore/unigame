---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_swim_to = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_swim_to.add_to_queue(self, priority, target_pos)

    -- Adapted from mobkit.hq_swimto(), duplicated by kitz.hq_swimto()
    -- The mob swims towards the specified "target_pos", jumping if necessary

    -- (Persistent data used to preserve state between calls to the closure below)
    local cbox = self.object:get_properties().collisionbox
    local column_list = {}

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        if not self.isinliquid then

            -- N.B. Original mobkit function returned false; here, we return nil (like every other
            --      behaviour)
            if self.isonground then
                return true
            else
                return
            end

        end

        local stand_pos = unimobs.mobkit_api.get_standing_pos(self)
        if not stand_pos then
            return true
        end

        local y = self.object:get_velocity().y
        local adjust_pos = {x = stand_pos.x, y = target_pos.y, z = stand_pos.z}
        local dir = vector.normalize(vector.direction(adjust_pos, target_pos))
        local yaw = core.dir_to_yaw(dir)

        if unimobs.mobkit_api.check_main_timer(self, 1) then

            column_list =
                    unimobs.mobkit_api.get_columns_displaced_by_node_box(stand_pos, cbox, dir, 1)
            for _, column_pos in ipairs(column_list[1]) do

                column_pos.y = stand_pos.y
                local height, _ = unimobs.mobkit_api.get_walkable_terrain_height(column_pos)
                if height and height > stand_pos.y and self.isinliquid then

                    unilib.pkg.lqb_free_jump.add_to_queue(self)
                    break

                end

            end

        elseif unimobs.mobkit_api.turn_to_yaw(self, yaw) then

            dir.y = y
            self.object:set_velocity(dir)

        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_swim_to", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_swim_to.init()

    return {
        description = "Standard high-level mob behaviour: swim towards the target position",
        notes = "The closure function returns true when the mob is standing on dry land",
        depends = "lqb_free_jump",
    }

end
