---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mobkit
-- Code:    MIT
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_mobkit_aqua = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.mobkit.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function check_pos(pos, shallow_flag)

    local node = unimobs.mobkit_api.get_node_defn_at_pos(pos)
    if node then

        if node.drawtype == "liquid" then

            local above_node = unimobs.mobkit_api.get_node_defn_at_pos(
                unimobs.mobkit_api.shift_pos_by_vector(pos, {y = 1})
            )
            local below_node = unimobs.mobkit_api.get_node_defn_at_pos(
                unimobs.mobkit_api.shift_pos_by_vector(pos, {y = -1})
            )

            if shallow_flag or
                    (above_node and above_node.drawtype == "liquid") or
                    (below_node and below_node.drawtype == "liquid") then
                return true
            else
                return false
            end

        else

            local height, _ = unimobs.mobkit_api.get_walkable_terrain_height(pos)
            if height then

                local node2 = unimobs.mobkit_api.get_node_defn_at_pos(
                    {x = pos.x, y = height + 1.99, z = pos.z}
                )

                if node2 and node2.drawtype == "liquid" then
                    return true, height
                else
                    return false        -- N.B. Not in original code
                end

            else

                return false

            end

        end

    else

        return false

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_mobkit_aqua.check_swimming_direction(
    pos, yaw, range, reverse_flag, shallow_flag
)
    -- From example_behaviours.lua, aqua_radar_dumb()
    -- Checks whether the position in front of a moving entity is swimmable, returning that position
    --      if so, or a new position if not
    -- Assumes that a mob will avoid shallows
    -- N.B. The "shallow_flag" argument is not found in the original code; it fixes the swimming
    --      issue described in the comments in the "hqb_aqua_roam" package

    range = range or 4

    local test_pos = unimobs.mobkit_api.shift_pos_by_horizontal_distance(pos, yaw, range)
    local ok_flag, height = check_pos(test_pos, shallow_flag)

    if not ok_flag then

        -- Position in front is not OK; look for the same position at a different height
        local start, stop, step
        if reverse_flag then
            start, stop, step = 3, 1, -1
        else
            start, stop, step = 1, 3, 1
        end

        for i = start, stop, step  do

            ok_flag, height = check_pos(
                unimobs.mobkit_api.shift_pos_by_horizontal_distance(pos, yaw + i, range),
                shallow_flag
            )

            if ok_flag then
                return yaw + i, height
            end

            ok_flag, height = check_pos(
                unimobs.mobkit_api.shift_pos_by_horizontal_distance(pos, yaw - i, range),
                shallow_flag
            )

            if ok_flag then
                return yaw - i, height
            end

        end

        return yaw + math.pi, height

    else

        return yaw, height

    end

end

function unilib.pkg.shared_mobkit_aqua.is_deep_in_liquid(target_obj)

    -- Adapted from mobkit.is_in_deep(), duplicated by kitz.is_in_deep()
    -- Checks whether an object is in a liquid that's at least 2 nodes deep, returning true if so,
    --      false otherwise

    if not target_obj then
        return false
    end

    local target_pos = unimobs.mobkit_api.get_standing_pos(target_obj)
    if not target_pos then
        return false
    end

    local node1 = unimobs.mobkit_api.get_node_defn_at_pos(target_pos)

    target_pos.y = target_pos.y + 1
    local node2 = unimobs.mobkit_api.get_node_defn_at_pos(target_pos)

    target_pos.y = target_pos.y - 2
    local node3 = unimobs.mobkit_api.get_node_defn_at_pos(target_pos)

    if node1 and
            node2 and
            node3 and
            node1.drawtype == "liquid" and
            (node2.drawtype == "liquid" or node3.drawtype == "liquid") then
        return true
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_mobkit_aqua.init()

    return {
        description = "Shared functions for mob behaviours in liquids (from mobkit)",
    }

end
