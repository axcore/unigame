---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_set_hotbar = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_set_hotbar.init()

    return {
        description = "Chat commands /set_hotbar, /reset_hotbar",
        notes = "Sets or resets the size of the player's hotbar",
    }

end

function unilib.pkg.chat_set_hotbar.exec()

    core.register_chatcommand("set_hotbar", {
        params = "[size]",
        description = S("Sets the size of the player's hotbar"),

        func = function(name, param)

            param = tonumber(param)
            if param == nil then

                return false, S("Set hotbar to which size?")

            elseif param < 1 or param > 32 then

                return false, S("The hotbar size must be in the range 1-32")

            else

                local player = core.get_player_by_name(name)
                unilib.utils.set_player_attribute(player, "hotbar_size", param)
                unilib.hotbar.set_size(player, param)
                return true

            end

        end,
    })

    core.register_chatcommand("reset_hotbar", {
        params = "",
        description = S("Resets the size of the player's hotbar"),

        func = function(name, param)

            local player = core.get_player_by_name(name)
            unilib.utils.set_player_attribute(player, "hotbar_size", "")

            if unilib.setting.hotbar_size > 0 then
                unilib.hotbar.set_size(player, unilib.setting.hotbar_size)
            else
                unilib.hotbar.set_size(player)
            end

            return true

        end,
    })

end
