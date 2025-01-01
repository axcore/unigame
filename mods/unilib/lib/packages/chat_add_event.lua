---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_add_event = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_add_event.init()

    return {
        description = "Chat command /add_event",
        notes = "Adds a calendar event, e.g. \"You ate a nice sandwich\"",
    }

end

function unilib.pkg.chat_add_event.exec()

    core.register_chatcommand("add_event", {
        params = "[message]",
        description = S("Adds a calendar event, e.g. \"You ate a nice sandwich\""),

        func = function(name, param)

            if not core.get_player_by_name(name) then
                return false, unilib.constant.chat_offline_msg
            elseif not unilib.setting.stats_bio_flag then
                return false, S("Calendar events cannot be added when player stats are disabled")
            end

            if not unilib.stats.add_player_event(name, "default", param) then
                return false, S("No events added")
            elseif param ~= nil and param ~= "" then
                return true, S("Added event") .. ": " .. param
            else
                return true, S("Added event")
            end

        end,
    })

end
