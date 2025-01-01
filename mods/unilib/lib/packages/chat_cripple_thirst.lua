---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_cripple_thirst = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_cripple_thirst.init()

    return {
        description = "Chat command /cripple_thirst",
        notes = "Reduces player thirst (if hydration is enabled); the opposite command is" ..
                " /reset_thirst",
        depends = "shared_chat_cuisine",
    }

end

function unilib.pkg.chat_cripple_thirst.exec()

    core.register_chatcommand("cripple_thirst", {
        params = "",
        description = S(
            "Reduces player thirst (if hydration is enabled); the opposite command is /reset_thirst"
        ),
        privs = {unilib_admin = true},

        func = function(name, param)

            if not core.get_player_by_name(name) then
                return false, unilib.constant.chat_offline_msg
            end

            if not unilib.setting.thirst_enable_flag then

                return false, S("Hydration is not enabled!")

            else

                unilib.hydration.set_hydro(
                    core.get_player_by_name(name),
                    unilib.pkg.shared_chat_cuisine.cuisine_cripple_level
                )

            end

        end,
    })

end
