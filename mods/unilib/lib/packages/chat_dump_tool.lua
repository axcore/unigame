---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_dump_tool = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_dump_tool(pname, param)

    local tool_list = {}
    local count = 0

    for k, _ in pairs(core.registered_tools) do

        if param == "" or string.find(k, param) then

            table.insert(tool_list, tostring(k))
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No tools are registered")
        else
            return false, S("No registered tools match the pattern \"@1\"", param)
        end

    else

        if param == "" then
            unilib.utils.chat_send_player(pname, S("List of registered tools"))
        else
            unilib.utils.chat_send_player(pname, S("List of matching tools"))
        end

        table.sort(tool_list)
        for _, full_name in ipairs(tool_list) do

            unilib.utils.chat_send_player(pname, "Tool: " .. full_name)
            unilib.utils.show_table_in_chat(pname, core.registered_tools[full_name])

        end

        unilib.utils.chat_send_player(pname, S("End of list (matching tools found: @1)", count))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_dump_tool.init()

    return {
        description = "Chat command /dump_tool",
        notes = "Dumps definitions of tools with a matching name",
    }

end

function unilib.pkg.chat_dump_tool.exec()

    core.register_chatcommand("dump_tool", {
        params = "<pattern>",
        description = S("Dumps tool definitions for any tool whose name matches the pattern"),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_dump_tool(name, param)
        end,
    })

end
