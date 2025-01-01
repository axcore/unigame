---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_toggle_autodrop = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_toggle(name, param)

    if not unilib.setting.magnet_auto_drop_flag then

        return false, S("The \"auto-drop\" effect has been disabled in settings")

    else

        local enabled_flag = unilib.magnet.toggle_player_auto_drop(name)
        if not enabled_flag then
            return true, S("Auto-drop has been disabled for @1", name)
        else
            return true, S("Auto-drop has been enabled for @1", name)
        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_toggle_autodrop.init()

    return {
        description = "Chat commands /toggle_autodrop, /autodrop",
        notes = "Toggles auto-drop for the player (if it's enabled on this server)",
    }

end

function unilib.pkg.chat_toggle_autodrop.exec()

    core.register_chatcommand("toggle_autodrop", {
        params = "",
        description = S("Toggles auto-drop for the player (if it's enabled on this server)"),

        func = function(name, param)
            return do_toggle(name, param)
        end,
    })

    core.register_chatcommand("autodrop", {
        params = "",
        description = S("Toggles auto-drop for the player (if it's enabled on this server)"),

        func = function(name, param)
            return do_toggle(name, param)
        end,
    })

end
