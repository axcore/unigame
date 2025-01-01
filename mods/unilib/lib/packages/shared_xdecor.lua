---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_xdecor = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions (doors)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_xdecor.toggle_door(pos_actuator, pos_door, player)

    -- From xdecor/src/mechanisms.lua, was door_toggle()
    -- Called by door levers and pressure plates (etc) to open or close a door/trapdoor

    local player_name = player:get_player_name()
    local actuator = core.get_node(pos_actuator)
    local door = unilib.access.get_door(pos_door)
    if not door then
        return
    end

    if actuator.name:sub(-4) == "_off" then

        core.set_node(
            pos_actuator,
            {name = actuator.name:gsub("_off", "_on"), param2 = actuator.param2}
        )

    end

    door:open(player)

    core.after(2, function()

        if core.get_node(pos_actuator).name:sub(-3) == "_on" then

            core.set_node(
                pos_actuator,
                {name = actuator.name, param2 = actuator.param2}
            )

        end

        -- Re-obtain player object (or nil) because 'player' could be an invalid object at this time
        --      (e.g. if the player left)
        door:close(core.get_player_by_name(player_name))

    end)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_xdecor.init()

    return {
        description = "Shared functions (from xdecor mod)",
    }

end
