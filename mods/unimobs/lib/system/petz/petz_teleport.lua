---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_teleport.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_back_home.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.teleport_mob_back_home(self)

    -- From petz.back_home()
    -- Teleportation function for mobs which have a dreamcatcher, or which have any other item which
    --      sets the mob's .back_home_flag to true, and .back_home_pos to a home position
    -- Normally called by unimobs.petz_api.on_step_callback(), but is available for any other code
    --      that wants it

    local back_home_pos = self.back_home_pos
    if not self.back_home_flag or not back_home_pos then
        return
    end

    local pos = self.object:get_pos()
    local distance = vector.distance(pos, back_home_pos)
    if distance <= unimobs.petz_setting.teleport_back_home_distance then
        return
    end

    local node = core.get_node_or_nil(back_home_pos)
    local map_loaded_flag = false

    if not node then

        -- Load the map at pos and try again
        core.get_voxel_manip():read_from_map(back_home_pos, back_home_pos)
        node = core.get_node(pos)
        map_loaded_flag = true

    end

    if not node then
        return
    end

    if node.name == "air" then

        if map_loaded_flag then

            local forceload_pos = core.forceload_block(back_home_pos)
            if not forceload_pos then
                return
            end

        end

        self.object:set_pos(back_home_pos)
        if map_loaded_flag then
            core.forceload_free_block(pos)
        end

    end

end
