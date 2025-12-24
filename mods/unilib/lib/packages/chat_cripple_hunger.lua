---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_cripple_hunger = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_cripple_hunger.init()

    return {
        description = "Chat command /cripple_hunger",
        notes = "Reduces player hunger (if player hunger is enabled); the opposite command is" ..
                " /reset_hunger",
        depends = "shared_chat_cuisine",
    }

end

function unilib.pkg.chat_cripple_hunger.exec()

    core.register_chatcommand("cripple_hunger", {
        params = "",
        description = S(
            "Reduces player hunger (if player hunger is enabled); the opposite command is" ..
                    " /reset_hunger"
        ),
        privs = {unilib_admin = true},

        func = function(pname, param)

            local player = core.get_player_by_name(pname)
            if not player then
                return false, unilib.constant.chat_offline_msg
            end

            if not unilib.setting.hunger_enable_flag then

                return false, S("Player hunger is not enabled!")

            else

                unilib.stamina.set_saturation(
                    player, unilib.pkg.shared_chat_cuisine.cuisine_cripple_level
                )

           end

        end,
    })

end
