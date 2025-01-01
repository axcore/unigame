---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_reset_health = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_reset_health.init()

    return {
        description = "Chat command /reset_health",
        notes = "Resets player health",
        depends = "shared_chat_cuisine",
    }

end

function unilib.pkg.chat_reset_health.exec()

    core.register_chatcommand("reset_health", {
        params = "",
        description = S("Resets player health"),
        privs = {unilib_admin = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then
                return false, unilib.constant.chat_offline_msg
            else
                player:set_hp(unilib.pkg.shared_chat_cuisine.cuisine_max_level)
            end

        end,
    })

end
