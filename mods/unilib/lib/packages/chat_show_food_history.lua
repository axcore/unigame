---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_show_food_history = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_show_food_history.init()

    return {
        description = "Chat command /show_food_history",
        notes = "Shows the player's food history (if advanced cuisine is enabled)",
    }

end

function unilib.pkg.chat_show_food_history.exec()

    core.register_chatcommand("show_food_history", {
        params = "",
        description = S("Shows your food history (if advanced cuisine is enabled)"),
        privs = {unilib_admin = true},

        func = function(pname, param)

            local player = core.get_player_by_name(pname)
            if not player then
                return false, unilib.constant.chat_offline_msg
            end

            if not unilib.setting.cuisine_advanced_flag then

                return false, S("Advanced cuisine is not enabled!")

            else

                local history_list = unilib.cuisine.get_history(player)
                if #history_list == 0 then

                    return false, S("Your food history is empty!")

                else

                    unilib.utils.chat_send_player(pname, S("Food history for player @1", pname))
                    for _, group in pairs(history_list) do
                        unilib.utils.chat_send_player(pname, "   " .. group)
                    end

                    unilib.utils.chat_send_player(
                        pname, S("End of list (food groups found: @1)", #history_list)
                    )

                end

            end

        end,
    })

end
