---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_cripple_health = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_cripple_health.init()

    return {
        description = "Chat command /cripple_health",
        notes = "Reduces player health; the opposite command is /reset_health",
        depends = "shared_chat_cuisine",
    }

end

function unilib.pkg.chat_cripple_health.exec()

    core.register_chatcommand("cripple_health", {
        params = "",
        description = S("Reduces player health; the opposite command is /reset_health"),
        privs = {unilib_admin = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then
                return false, unilib.constant.chat_offline_msg
            else
                player:set_hp(unilib.pkg.shared_chat_cuisine.cuisine_cripple_level)
            end

        end,
    })

end
