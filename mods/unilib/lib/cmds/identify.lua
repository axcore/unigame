---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- identify.lua
--      Set up chat commands for identifying the pointed node
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- /what: Enables the HUD for identifying the node at which the mouse is pointed
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("what", {
    params = "",
    description = S("Enables the HUD for identifying the node at which the mouse is pointed"),

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        -- (When the HUD is only visible after punching, the confirm the change in the chat window;
        --      otherwise, don't bother)
        local result = unilib.toggle_identify_mode(name)
        if result ~= nil then
            return true, result
        end

    end,
})
