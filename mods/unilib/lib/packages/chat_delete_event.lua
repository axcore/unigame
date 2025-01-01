---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_delete_event = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_delete_event.init()

    return {
        description = "Chat command /delete_event",
        notes = "Deletes calendar events from the specified game day (e.g. 1 for the first game" ..
                " day, or a string in the form \"YYYYMMDD\"). N.B. Only events of the type" ..
                " \"default\" can be removed with this command (such as those created with the" ..
                " /add_event command)",
    }

end

function unilib.pkg.chat_delete_event.exec()

    core.register_chatcommand("delete_event", {
        params = "<game_day>",
        description = S(
            "Deletes calendar events from the specified game day (e.g. 1 for the first game" ..
                    " day, or a string in the form \"YYYYMMDD\"). Only events of the \"default\"" ..
                    " type can be removed with this command (such as those created with the" ..
                    " /add_event command)"
        ),

        func = function(name, param)

            if not core.get_player_by_name(name) then
                return false, unilib.constant.chat_offline_msg
            elseif not unilib.setting.stats_bio_flag then
                return false, S("Calendar events cannot be modified when player stats are disabled")
            end

            -- N.B. only player events with the "default" event type are removed
            if not unilib.stats.delete_player_event(name, param) then
                return false, S("No events removed")
            else
                return true, S("Removed calendar events from game day @1", param)
            end

        end,
    })

end
