---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_toggle_identify = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_toggle(name, param)

    if not core.get_player_by_name(name) then
        return false, unilib.constant.chat_offline_msg
    end

    if not unilib.setting.identify_enable_hud_flag then
        return false, S("The \"identify\" effect has been disabled in settings")
    end

    -- (When the HUD is only visible after punching, the confirm the change in the chat window;
    --      otherwise, don't bother)
    local result = unilib.identify.toggle_mode(name)
    if result ~= nil then
        return true, result
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_toggle_identify.init()

    return {
        description = "Chat commands /toggle_identify, /identify, /what",
        notes = "Toggles the HUD for identifying the node at which the mouse is pointed",
    }

end

function unilib.pkg.chat_toggle_identify.exec()

    core.register_chatcommand("toggle_identify", {
        params = "",
        description = S("Toggles the HUD for identifying the node at which the mouse is pointed"),

        func = function(name, param)
            return do_toggle(name, param)
        end,
    })

    core.register_chatcommand("identify", {
        params = "",
        description = S("Toggles the HUD for identifying the node at which the mouse is pointed"),

        func = function(name, param)
            return do_toggle(name, param)
        end,
    })

    core.register_chatcommand("what", {
        params = "",
        description = S("Toggles the HUD for identifying the node at which the mouse is pointed"),

        func = function(name, param)
            return do_toggle(name, param)
        end,
    })

end
