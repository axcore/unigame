---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_xdecor = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function top_face(pointed_thing)

    if not pointed_thing then
        return
    end

    return pointed_thing.above.y > pointed_thing.under.y

end

---------------------------------------------------------------------------------------------------
-- Shared functions (doors)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_xdecor.toggle_door(pos_actuator, pos_door, player)

    -- From xdecor/src/mechanisms.lua, was door_toggle()
    -- Called by door levers and pressure plates (etc) to open or close a door/trapdoor

    local player_name = player:get_player_name()
    local actuator = minetest.get_node(pos_actuator)
    local door = unilib.get_door(pos_door)
    if not door then
        return
    end

    if actuator.name:sub(-4) == "_off" then

        minetest.set_node(
            pos_actuator,
            {name = actuator.name:gsub("_off", "_on"), param2 = actuator.param2}
        )

    end

    door:open(player)

    minetest.after(2, function()

        if minetest.get_node(pos_actuator).name:sub(-3) == "_on" then

            minetest.set_node(
                pos_actuator,
                {name = actuator.name, param2 = actuator.param2}
            )

        end

        -- Re-obtain player object (or nil) because 'player' could be an invalid object at this time
        --      (e.g. if the player left)
        door:close(minetest.get_player_by_name(player_name))

    end)

end

---------------------------------------------------------------------------------------------------
-- Shared functions (sitting)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_xdecor.do_sit(pos, node, clicker, pointed_thing)

    -- From xdecor/handlers/animations.lua, was xdecor.sit()
    -- Moves the player to a sitting position

    if not top_face(pointed_thing) then
        return
    end

    local player_name = clicker:get_player_name()
    local objs = minetest.get_objects_inside_radius(pos, 0.1)
    local vel = clicker:get_player_velocity()
    local ctrl = clicker:get_player_control()

    for _, obj in pairs(objs) do

        if obj:is_player() and obj:get_player_name() ~= player_name then
            return
        end

    end

--    if default.player_attached[player_name] then
    if unilib.player_api.get_player_attached(player_name) then

        pos.y = pos.y - 0.5
        clicker:set_pos(pos)
        clicker:set_eye_offset(vector.new(), vector.new())
        clicker:set_physics_override({speed = 1, jump = 1, gravity = 1})
--        default.player_attached[player_name] = false
        unilib.player_api.set_player_attached(player_name, false)
--        default.player_set_animation(clicker, "stand", 30)
        unilib.player_api.set_animation(clicker, "stand", 30)

--    elseif not default.player_attached[player_name] and
    elseif not unilib.player_api.get_player_attached(player_name) and
            node.param2 <= 3 and
            not ctrl.sneak and
            vector.equals(vel, vector.new()) then

        clicker:set_eye_offset({x = 0, y = -7, z = 2}, vector.new())
        clicker:set_physics_override({speed = 0, jump = 0, gravity = 1})
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

function unilib.pkg.shared_xdecor.can_dig_chair(pos, digger)

    -- From xdecor/handlers/animations.lua, was xdecor.sit_dig()
    -- Returns true if the item can be dug, or false if someone is sitting on it

    for _, player in pairs(minetest.get_objects_inside_radius(pos, 0.1)) do

--        if player:is_player() and
--                default.player_attached[player:get_player_name()] then
        if player:is_player() and
                unilib.player_api.get_player_attached(player:get_player_name()) then
            return false

        end

    end

    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_xdecor.init()

    return {
        description = "Shared functions (from xdecor mod)",
    }

end

function unilib.pkg.shared_xdecor.exec()

    -- Calls to unilib.pkg.shared_xdecor.do_sit() and
    --      unilib.pkg.shared_xdecor.can_dig_chair() require code imported from
    --      minetest_game/player_api, if not already loaded
    unilib.load_player_api()

end
