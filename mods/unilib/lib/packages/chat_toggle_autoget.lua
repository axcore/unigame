---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_toggle_autoget = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_toggle(name, param)

    if not unilib.setting.magnet_auto_get_flag then

        return false, S("The \"auto-get\" effect has been disabled in settings")

    else

        local enabled_flag = unilib.magnet.toggle_player_auto_get(name)
        if not enabled_flag then
            return true, S("Auto-get has been disabled for @1", name)
        else
            return true, S("Auto-get has been enabled for @1", name)
        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_toggle_autoget.init()

    return {
        description = "Chat commands /toggle_autoget, /autoget",
        notes = "Toggles auto-get for the player (if it's enabled on this server)",
    }

end

function unilib.pkg.chat_toggle_autoget.exec()

    core.register_chatcommand("toggle_autoget", {
        params = "",
        description = S("Toggles auto-get for the player (if it's enabled on this server)"),

        func = function(name, param)
            return do_toggle(name, param)
        end,
    })

    core.register_chatcommand("autoget", {
        params = "",
        description = S("Toggles auto-get for the player (if it's enabled on this server)"),

        func = function(name, param)
            return do_toggle(name, param)
        end,
    })

end
