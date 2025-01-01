---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_clear_food_history = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_clear_food_history.init()

    return {
        description = "Chat command /clear_food_history",
        notes = "Clears the player's food history  (if advanced cuisine is enabled)",
    }

end

function unilib.pkg.chat_clear_food_history.exec()

    core.register_chatcommand("clear_food_history", {
        params = "",
        description = S("Clears your food history (if advanced cuisine is enabled)"),
        privs = {unilib_admin = true},

        func = function(name, param)

            if not core.get_player_by_name(name) then
                return false, unilib.constant.chat_offline_msg
            end

            if not unilib.setting.cuisine_advanced_flag then

                return false, S("Advanced cuisine is not enabled!")

            else

                unilib.cuisine.clear_history(core.get_player_by_name(name))
                return true, S("Food history has been cleared")

            end

        end,
    })

end
