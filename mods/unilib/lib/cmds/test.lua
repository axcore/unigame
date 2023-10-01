---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- test.lua
--      Set up chat commands for testing arbitrary code
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- /test: Runs some arbitrary code
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("test", {
    params = "",
    description = S("Runs some arbitrary code"),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        return true, S("Hello, world!")

    end,
})
