---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_utils.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local cos = math.cos
local floor = math.floor
local random = math.random
local sin = math.sin

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/brains/helper_functions.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.get_mob_height(self)

    -- Was petz.check_height()
    -- Checks the specified mob's height above the surface (or above the nearest block directly
    --      below, in case of buildings, trees etc)
    -- If the height is within the mob's .max_roam_height, then returns the height; otherwise
    --      returns nil

    local yaw = self.object:get_yaw()
    local cbox = self.object:get_properties().collisionbox
    local dir_x = -sin(yaw) * (cbox[4] + 0.5)
    local dir_z = cos(yaw) * (cbox[4] + 0.5)
    local pos = self.object:get_pos()

    local mob_bottom = pos.y - cbox[2]
    local pos2 = {x = pos.x + dir_x, y = mob_bottom, z = pos.z + dir_z}

    -- N.B. Original code did not check that self.max_roam_height is defined; the value 10 matches
    --      the default value used in unimobs.petz_api.register_standard_mob()
    local max_roam_height = self.max_roam_height or 10
    local pos3 = {x = pos.x + dir_x, y = mob_bottom - max_roam_height, z = pos.z + dir_z}

    local blocking_node, blocking_node_pos = core.line_of_sight(pos2, pos3, 1)
    if not blocking_node then

        return mob_bottom - blocking_node_pos.y

    else

        -- N.B. The original version of this function returned false
        return nil

    end

end

function unimobs.petz_api.get_node_at_named_location(self, location)

    -- Was petz.node_name_in()
    -- On success, returns a list of two values:
    --      - The pos of the specified "location", relative to the specified mob
    --      - The node at that pos
    -- On failure, returns nil
    --
    -- The "location" argument must be one of the strings "front", "top", "below", "back", "self",
    --      "front_top" or "front_below"
    --
    -- N.B. The original version of this argument returned a list of three values in the form
    --      (node.name, pos, node)

    local pos = self.object:get_pos()
    local yaw = self.object:get_yaw()
    if not pos or not yaw then
        return
    end

    local dir_x = -sin(yaw)
    local dir_z = cos(yaw)
    local pos2

    if location == "front" then

        pos2 = {x = pos.x + dir_x, y = pos.y, z = pos.z + dir_z}

    elseif location == "top" then

        pos2 = {x = pos.x, y = pos.y + 0.5, z = pos.z}

    elseif location == "below" then

        pos2 = unimobs.mobkit_api.get_standing_pos(self)
        if not pos2 then
            return
        end

        pos2.y = pos2.y - 0.1

    elseif location == "back" then

        pos2 = {x = pos.x - dir_x, y = pos.y, z = pos.z - dir_z}

    elseif location == "self" then

        pos2 = {x = pos.x, y = pos.y - 0.75, z = pos.z}

    elseif location == "front_top" then

        pos2 = {x = pos.x + dir_x, y = pos.y + 1, z = pos.z + dir_z}

    elseif location == "front_below" then

        pos2 = {x = pos.x + dir_x, y = pos.y - 1, z = pos.z + dir_z}

    end

    local node = core.get_node_or_nil(pos2)
    if node and core.registered_nodes[node.name] then
        return node, pos2
    else
        return
    end

end

function unimobs.petz_api.is_mob_in_group(self)

    -- Was petz.bh_check_pack()
    -- Returns true if the specified mob is close to another mob of the same type
    -- This is useful for certain types of mob in certain situations; for example, for wolves in
    --      hunting mode, the calling code might be able to assume that they are behaving as if in a
    --      wolfpack
    -- N.B. Despite the name of the original function, this is not a meta-behaviour

    if unimobs.mobkit_api.get_closest_entity(self, "unilib:mob_" .. self.mob_type) then
        return true
    else
        return false
    end

end

function unimobs.petz_api.is_mob_standing_still(self)

    -- Was petz.is_standing()
    -- Returns true if the mob's (scalar) speed is 0, false otherwise

    local velocity = self.object:get_velocity()
    local speed = vector.length(velocity)

    if speed == 0 then
        return true
    else
        return false
    end

end

function unimobs.petz_api.is_mob_jumping(self)

    -- Was petz.is_jumping()
    -- Counterpart to unimobs.petz_api.is_mob_standing_still(); this function is really just a
    --      wrapper to check self.isonground; in unimobs, we retain the function rather than
    --      checking self.isonground directly, so that a block of code that checks both functions is
    --      easier to read

    if self.isonground then
        return false
    else
        return true
    end

end

function unimobs.petz_api.is_obstacle_in_front_of_mob(self)

    -- Was petz.check_front_obstacle()
    -- Returns true if there are any obstacles in front of the mob, checking up to a maximum
    --      distance (default value is 5); false otherwise
    -- N.B. This is the OPPOSITE behaviour of the original function, which returned false when an
    --      obstacle was detected

    local yaw = self.object:get_yaw()
    local cbox = self.object:get_properties().collisionbox
    local dir_x = -sin(yaw) * (cbox[4] + 0.5)
    local dir_z = cos(yaw) * (cbox[4] + 0.5)
    local pos = self.object:get_pos()

    local check_distance = 5
    if core.line_of_sight(
        {x = pos.x + dir_x, y = pos.y, z = pos.z + dir_z},
        {x = pos.x + dir_x + check_distance, y = pos.y, z = pos.z + dir_z + check_distance},
        1
    ) then
        return true
    else
        return false
    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_helper_functions.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.convert_value_to_stringified_bool(val)

    -- From petz.vartostring()
    -- Converts any value to a stringified boolean, returning either the string "true" or the string
    --      "false"
    -- "false" is returned when the specified "val" is nil, 0 or false

    if not val or val == nil or val == 0 or val == "false" then
        return "false"
    else
        return "true"
    end

end

function unimobs.petz_api.get_pos_behind_player(player)

    -- Adapted from petz.get_player_back_pos()
    -- Returns the pos behind the specified "player"
    -- N.B. The original version of this function returned two values, the position itself and the
    --      node at that position

    local pos = player:get_pos()
    local yaw = player:get_look_horizontal()
    local dir_x = -sin(yaw)
    local dir_z = cos(yaw)

    -- N.B. The original version of this function returned useless values (for example, when the
    --      player teleports to exactly x = 0, it may return a value like x = 0.99978 instead of the
    --      expected x = 1)
    -- In this version, we round the values to 1dp, which should produce the values we're expecting
    return {
        x = unimobs.petz_api.round_numeric_value((pos.x - dir_x), 1),
        y = pos.y + 0.5,
        z = unimobs.petz_api.round_numeric_value((pos.z - dir_z), 1),
    }

end

function unimobs.petz_api.get_pos_in_front_of_player(player)

    -- From petz.pos_front_player()
    -- Returns the pos in front of the specified "player"

    local pos = player:get_pos()
    local yaw = player:get_look_horizontal()
    local dir_x = -sin(yaw) + 0.5
    local dir_z = cos(yaw) + 0.5

    -- N.B. The original version of this function returned useless values (for example, when the
    --      player teleports to exactly x = 0, it may return a value like x = 0.99978 instead of the
    --      expected x = 1)
    -- In this version, we round the values to 1dp, which should produce the values we're expecting
    return {
        x = unimobs.petz_api.round_numeric_value((pos.x + dir_x), 1),
        y = pos.y + 0.5,
        z = unimobs.petz_api.round_numeric_value((pos.z + dir_z), 1),
    }

end

function unimobs.petz_api.is_day()

    -- Original to unimobs, adapted from petz.is_night()
    -- Returns true during the day, false at night, or nil if the world has not yet been loaded

    local timeofday = core.get_timeofday()
    -- Value may be nil if the world has not been loaded
    if timeofday == nil then
        return nil
    end

    -- (Convert value in the range 0-1, to a value in the range 0-24000)
    local current_time = timeofday * 24000
    if current_time < 4500 or current_time > 19500 then
        return false
    else
        return true
    end

end

function unimobs.petz_api.is_mob_in_liquid(self)

    -- From petz.isinliquid()
    -- Returns true if the specified mob is in a liquid, false otherwise

    local pos = self.object:get_pos()

    local node_under =
            unimobs.mobkit_api.get_node_defn_at_pos(vector.new(pos.x, pos.y - 0.5, pos.z))
    local node_above =
            unimobs.mobkit_api.get_node_defn_at_pos(vector.new(pos.x, pos.y + 0.5, pos.z))

    if (
        node_under and (node_under.drawtype == "liquid" or node_under.drawtype == "flowingliquid")
    ) or (
        node_above and (node_above.drawtype == "liquid" or node_above.drawtype == "flowingliquid")
    ) then
        return true
    else
        return false
    end

end

function unimobs.petz_api.is_night()

    -- From petz.is_night()
    -- Returns true at night, false during the day, or nil if the world has not yet been loaded

    local timeofday = core.get_timeofday()
    -- Value may be nil if the world has not been loaded
    if timeofday == nil then
        return nil
    end

    -- (Convert value in the range 0-1, to a value in the range 0-24000)
    local current_time = timeofday * 24000
    if current_time < 4500 or current_time > 19500 then
        return true
    else
        return false
    end

end

function unimobs.petz_api.is_string_empty(val)

    -- From petz.str_is_empty()
    -- Returns true if the specified "val" is an empty string (or nil); false otherwise

    return val == nil or val == ""

end

function unimobs.petz_api.set_mob_properties(self, prop_table)

    -- From petz.set_properties()
    -- Sets the specified mob's properties, first checking that the "self" argument is the correct
    --      thing to be updating

    if type(self) == "table" then
        self = self.object
    end

    self:set_properties(prop_table)

end

function unimobs.petz_api.round_numeric_value(value, decimal_places)

    -- Original to unimobs
    -- Rounds up/down a numeric value to the specified precision

    local power = 10 ^ decimal_places
    return floor((value * power) + 0.5) / power

end

function unimobs.petz_api.truncate_numeric_value(value, decimal_places)

    -- From petz.truncate()
    -- Rounds down a numeric value to the specified precision
    -- Example behaviour:
    --      value = 1.23456789, decimal_places = 3    ->   1.234
    --      value = 1.23456789, decimal_places = 1    ->   1.2
    --      value = 1.23456789, decimal_places = 0    ->   1
    --      value = 1234.5, decimal_places = -1       ->   1230
    --      value = 1234.5, decimal_places = -6       ->   0

    local power = 10 ^ decimal_places
    return floor(value * power) / power

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_datetime.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.get_os_month()

    -- From petz.get_os_month()
    -- Returns a number in the range 1-12, representing the current (real-world) month

    local now_table = os.date("*t")
    return now_table.month

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from elsewhere)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.can_jump_in_liquid(self, pos)

    -- Was petz.can_jump()
    -- Called by unilib.pkg.brain_aquatic.brain() to test whether a mob in a liquid can jump. If
    --      successful, the calling code launches the "hqb_aqua_jump" behaviour

    local vel = self.object:get_velocity()
    local front_pos = vector.add(pos, vel)
    local front_pos_below = vector.new(front_pos.x, front_pos.y - 1, front_pos.z)

    if not unimobs.kitz_api.is_liquid(front_pos_below) then
        return false
    else
        return true
    end

end

function unimobs.petz_api.check_tree(self)

    -- Was petz.check_tree()
    -- Called by the "mtb_climb_tree" and "hqb_climb_tree" packages
    -- Checks whether the specified mob can climb the tree in front of it

    local front_node = unimobs.petz_api.get_node_at_named_location(self, "front")
    local top_node = unimobs.petz_api.get_node_at_named_location(self, "top")
    if front_node and
            top_node and
            top_node.name == "air" and
            unimobs.petz_api.is_tree_like(front_node) then
        return true
    else
        return false
    end

end

function unimobs.petz_api.is_tree_like(node)

    -- Was petz.is_tree_like()
    -- Checks whether the specified node it a tree trunk or leaves node

    if core.registered_nodes[node.name].groups.leaves or
            (node.param1 == 0 and core.registered_nodes[node.name].groups.tree) then
        return true
    else
        return false
    end

end

function unimobs.petz_api.get_displayable_formspec_image(def_table)

    -- Adapted from code in /petz/petz/api/api_forms.lua
    -- Returns an image that can be added to a formspec string.
    -- For craftitems, returns the .inventory_image, but for nodes, returns an inventory cube
    -- On failure, return an empty string

    if def_table.inventory_image then
        return def_table.inventory_image or ""
    else
        return unimobs.kitz_api.create_inv_cube(def_table.tiles) or ""
    end

end

function unimobs.petz_api.is_pos_inside_collisionbox(self, pos, box_pos, cbox)

    -- Was petz.is_pos_in_box()
    -- Returns true if the specified "pos" is inside the specified mob's collision box "cbox" at the
    --      position "box_pos", taking into account any offset specified in the mob's properties
    -- N.B. In the original code, this function was called only by commented-out code

    if not self.collisionbox_offset then
        self.collisionbox_offset = {x = 0, y = 0, z = 0}
    end

    return pos.x > (box_pos.x + cbox[1] + (self.collisionbox_offset.x or 0)) and
            pos.x < (box_pos.x + cbox[4] + (self.collisionbox_offset.x or 0)) and
            pos.y > (box_pos.y + cbox[2] + (self.collisionbox_offset.y or 0)) and
            pos.y < (box_pos.y + cbox[5] + (self.collisionbox_offset.y or 0)) and
            pos.z > (box_pos.z + cbox[3] + (self.collisionbox_offset.z or 0)) and
            pos.z < (box_pos.z + cbox[6] + (self.collisionbox_offset.z or 0))

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (original to unimobs)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.get_insertion(mob_type, insertion_type)

    -- Original to unimobs
    -- Convenience function for looking up a value in a translation insertion table in
    --      unimobs.petz_global.mob_table
    -- "insertion_type" should be one of the strings "subject", "subject_an", "subject_the",
    --      "object", "object_an", "object_the"

    -- Failsafe: return something that's obviously a placeholder
    local failsafe = "MOB"

    local data_table = unimobs.petz_global.mob_table[mob_type]
    if not data_table or not data_table.insertion_table then
        return failsafe
    else
        return data_table.insertion_table[insertion_type] or failsafe
    end

end

function unimobs.petz_api.get_random_interval(average_time)

    -- Original to unimobs, using code split off from unimobs.petz_api.lay_egg()
    -- Returns a random value in the vicinity of "average_time", plus or minus 20%

    return random(
        average_time - (average_time * 0.2),
        average_time + (average_time * 0.2)
    )

end

function unimobs.petz_api.get_standard_visual_size(scale_factor)

    -- Original to unimobs
    -- Returns a standard .visual_size table for those mobs that use it

    return {
        x = unimobs.petz_const.visual_size.x * scale_factor,
        y = unimobs.petz_const.visual_size.y * scale_factor,
    }

end

function unimobs.petz_api.pos_to_string(pos, decimal_places)

    -- Original to unimobs
    -- Truncates the values in the specified pos, then returns the return value of a call to
    --      core.pos_to_string()
    -- This ensures that (for example) any log messages use values like 11.7, and not values like
    --      11.700000762939

    -- (The "decimal_places" argument is optional in this function)
    decimal_places = decimal_places or 0

    return core.pos_to_string({
        x = unimobs.petz_api.truncate_numeric_value(pos.x, decimal_places),
        y = unimobs.petz_api.truncate_numeric_value(pos.y, decimal_places),
        z = unimobs.petz_api.truncate_numeric_value(pos.z, decimal_places),
    })

end
