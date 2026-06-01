---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_show_trigger = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_show(pname)

    -- Basic checks
    if not unilib.setting.awards_enable_flag then
        return false, S("Player awards are not enabled in settings")
    end

    -- Sort trigger prototypes by name
    local trigger_list = unilib.utils.sort_table(unilib.global.awards_trigger_prototype_table)

    -- Show the list
    unilib.utils.chat_send_player(pname, S("List of trigger prototypes"))

    for _, trigger_name in ipairs(trigger_list) do

        local data_table = unilib.global.awards_trigger_prototype_table[trigger_name]
        unilib.utils.chat_send_player(
            pname,
            "   [ " .. data_table.trigger_type .. string.rep(" ", 7 - #data_table.trigger_type) ..
                " ] " .. trigger_name
        )

    end

    unilib.utils.chat_send_player(
        pname, S("End of list (trigger prototypes found: @1)", #trigger_list)
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_show_trigger.init()

    return {
        description = "Chat commands /show_trigger, /show_triggers",
        notes = "Shows a list of trigger prototypes",
    }

end

function unilib.pkg.chat_show_trigger.exec()

    core.register_chatcommand("show_trigger", {
        params = "",
        description = S("Shows a list of trigger prototypes"),
        privs = {unilib_admin = true},

        func = function(pname, param)
            return do_show(pname)
        end,
    })

    core.register_chatcommand("show_triggers", {
        params = "",
        description = S("Shows a list of trigger prototypes"),
        privs = {unilib_admin = true},

        func = function(pname, param)
            return do_show(pname)
        end,
    })

end
