---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_cripple_me = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_cripple_me.init()

    return {
        description = "Chat command /cripple_me",
        notes = "Reduces player health, hunger and thirst; the opposite command is /reset_me",
        depends = "shared_chat_cuisine",
    }

end

function unilib.pkg.chat_cripple_me.exec()

    core.register_chatcommand("cripple_me", {
        params = "",
        description = S(
            "Reduces player health, hunger and thirst; the opposite command is /reset_me"
        ),
        privs = {unilib_admin = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then
                return false, unilib.constant.chat_offline_msg
            end

            player:set_hp(unilib.pkg.shared_chat_cuisine.cuisine_cripple_level)

            if unilib.setting.hunger_enable_flag then

                unilib.stamina.set_saturation(
                    player, unilib.pkg.shared_chat_cuisine.cuisine_cripple_level
                )

            end

            if unilib.setting.thirst_enable_flag then

                unilib.hydration.set_hydro(
                    player, unilib.pkg.shared_chat_cuisine.cuisine_cripple_level
                )

            end

        end,
    })

end
