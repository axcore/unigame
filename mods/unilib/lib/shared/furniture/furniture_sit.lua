---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- furniture_sit.lua
--      "Standard" functions for unilib chairs
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function top_face(pointed_thing)

    -- From xdecor/handles/animations.lua

    if not pointed_thing then
        return
    end

    return pointed_thing.above.y > pointed_thing.under.y

end

---------------------------------------------------------------------------------------------------
-- "Standard" functions for unilib chairs
---------------------------------------------------------------------------------------------------

function unilib.furniture._do_sit_chair(pos, node, clicker, pointed_thing)

    -- From xdecor/handlers/animations.lua, was xdecor.sit()
    -- Moves the player to a sitting position
    -- This is the "standard" code for unilib chairs (although some packages may prefer to use their
    --      own code, e.g. items from the "cottages" mod)
    -- For a working example, see the "furniture_chair_simple" package

    if not top_face(pointed_thing) then
        return
    end

    local player_name = clicker:get_player_name()
    local objs = core.get_objects_inside_radius(pos, 0.1)
    local vel = clicker:get_player_velocity()
    local ctrl = clicker:get_player_control()

    for _, obj in pairs(objs) do

        if obj:is_player() and obj:get_player_name() ~= player_name then
            return
        end

    end

--    if default.player_attached[player_name] then
    if unilib.player_api.get_player_attached(player_name) then

        -- N.B. Removed this xdecor adjustment, because the player appears to be standing inside the
        --      cushion/chair when it's executed
--        pos.y = pos.y - 0.5
        clicker:set_pos(pos)
        clicker:set_eye_offset(vector.new(), vector.new())
        clicker:set_physics_override({gravity = 1, jump = 1, speed = 1})
--        default.player_attached[player_name] = false
        unilib.player_api.set_player_attached(player_name, false)
--        default.player_set_animation(clicker, "stand", 30)
        unilib.player_api.set_animation(clicker, "stand", 30)

--    elseif not default.player_attached[player_name] and
    elseif not unilib.player_api.get_player_attached(player_name) and
            node.param2 <= 3 and
            not ctrl.sneak and
            vector.equals(vel, vector.new()) then

        -- N.B. Tweaked the original xdecor camera position, as both the cushion and chair look bad
        --      with the original offsets
--        clicker:set_eye_offset({x = 0, y = -7, z = 2}, vector.new())
        clicker:set_eye_offset({x = 0, y = -3, z = 0}, vector.new())
        clicker:set_physics_override({gravity = 1, jump = 0, speed = 0})
        clicker:set_pos(pos)
--        default.player_attached[player_name] = true
        unilib.player_api.set_player_attached(player_name, true)
--        default.player_set_animation(clicker, "sit", 30)
        unilib.player_api.set_animation(clicker, "sit", 30)

        if node.param2 == 0 then
            clicker:set_look_yaw(3.15)
        elseif node.param2 == 1 then
            clicker:set_look_yaw(7.9)
        elseif node.param2 == 2 then
            clicker:set_look_yaw(6.28)
        elseif node.param2 == 3 then
            clicker:set_look_yaw(4.75)
        end

    end

end

function unilib.furniture._can_dig_chair(pos, digger)

    -- From xdecor/handlers/animations.lua, was xdecor.sit_dig()
    -- Returns true if the item can be dug, or false if someone is sitting on it

    for _, player in pairs(core.get_objects_inside_radius(pos, 0.1)) do

--        if player:is_player() and
--                default.player_attached[player:get_player_name()] then
        if player:is_player() and
                unilib.player_api.get_player_attached(player:get_player_name()) then
            return false

        end

    end

    return true

end
