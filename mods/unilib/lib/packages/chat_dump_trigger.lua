---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_dump_trigger = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_dump_trigger(pname, param)

    -- Basic checks
    if not unilib.setting.awards_enable_flag then
        return false, S("Player awards are not enabled in settings")
    end

    -- Filter trigger prototypes
    local trigger_list = {}
    for trigger_name, data_table in pairs(unilib.global.awards_trigger_prototype_table) do

        if param == "" or
                string.find(trigger_name, param) or
                string.find(data_table.title, param) then
            table.insert(trigger_list, trigger_name)
        end

    end

    if #trigger_list == 0 then

        if param == "" then
            return false, S("No trigger prototypes are registered")
        else
            return false, S("No trigger prototypes match the pattern \"@1\"", param)
        end

    end

    -- Show the list of filtered trigger prototypes
    if param == "" then
        unilib.utils.chat_send_player(pname, S("List of trigger prototypes"))
    else
        unilib.utils.chat_send_player(pname, S("List of matching trigger prototypes"))
    end

    table.sort(trigger_list)

    for _, trigger_name in ipairs(trigger_list) do

        local data_table = unilib.global.awards_trigger_prototype_table[trigger_name]

        unilib.utils.chat_send_player(pname, trigger_name)
        unilib.utils.chat_send_player(pname, "   Trigger type: " .. data_table.trigger_type)

        if #data_table.hint_list > 0 then

            unilib.utils.chat_send_player(pname, "   Hint strings: ")
            for _, item in ipairs(data_table.hint_list) do
                unilib.utils.chat_send_player(pname, "      " .. item)
            end

        end

        if #data_table.progress_list > 0 then

            unilib.utils.chat_send_player(pname, "   Progress strings: ")
            for _, item in ipairs(data_table.progress_list) do
                unilib.utils.chat_send_player(pname, "      " .. item)
            end

        end

    end

    unilib.utils.chat_send_player(
        pname, S("End of list (matching trigger prototypes found: @1)", #trigger_list)
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_dump_trigger.init()

    return {
        description = "Chat command /dump_trigger",
        notes = "Dumps data for trigger prototypes with a matching trigger type",
    }

end

function unilib.pkg.chat_dump_trigger.exec()

    core.register_chatcommand("dump_trigger", {
        params = "<pattern>",
        description = S(
            "Dumps data for any trigger prototypes whose trigger type matches the pattern"
        ),
        privs = {unilib_admin = true},

        func = function(pname, param)
            return do_dump_trigger(pname, param)
        end,
    })

end
