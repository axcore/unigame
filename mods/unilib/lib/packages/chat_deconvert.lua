---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_deconvert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_deconvert.init()

    return {
        description = "Chat command /deconvert",
        notes = "Shows the original mod equivalent or a node/craftitems/tools from unilib",
    }

end

function unilib.pkg.chat_deconvert.exec()

    core.register_chatcommand("deconvert", {
        params = "[item]",
        description = S("Shows the original mod equivalent or a node/craftitems/tools from unilib"),
        privs = {unilib_tools = true},

        func = function(name, param)

            local count = 0

            -- Reverse the conversion tables. It's probably safe to assume that each value in the
            --      original key-value pairs is unique
            local node_convert_table = {}
            for k, v in pairs(unilib.global.node_convert_table) do
                node_convert_table[v] = k
            end

            local craftitem_convert_table = {}
            for k, v in pairs(unilib.global.craftitem_convert_table) do
                craftitem_convert_table[v] = k
            end

            local tool_convert_table = {}
            for k, v in pairs(unilib.global.tool_convert_table) do
                tool_convert_table[v] = k
            end

            if param ~= "" then

                match_flag = false

                if node_convert_table[param] ~= nil then

                    match_flag = true
                    unilib.utils.chat_send_player(
                        name, "[node] " .. param .. " < " .. node_convert_table[param]
                    )

                end

                if craftitem_convert_table[param] ~= nil then

                    match_flag = true
                    unilib.utils.chat_send_player(
                        name, "[craftitem] " .. param .. " < " .. craftitem_convert_table[param]
                    )

                end

                if tool_convert_table[param] ~= nil then

                    match_flag = true
                    unilib.utils.chat_send_player(
                        name, "[tool] " .. param .. " < " .. tool_convert_table[param]
                    )

                end

                if not match_flag then
                    return false, S("Item not found in deconversion tables: @1", param)
                end

            else

                unilib.utils.chat_send_player(name, S("Original and unilib nodes/craftitems/tools"))

                local node_list = {}
                for k, v in pairs(node_convert_table) do
                    table.insert(node_list, k)
                end

                table.sort(node_list)
                for _, full_name in ipairs(node_list) do

                    count = count + 1
                    unilib.utils.chat_send_player(
                        name, "   [node] " .. full_name .. " < " .. node_convert_table[full_name]
                    )

                end

                local craftitem_list = {}
                for k, v in pairs(craftitem_convert_table) do
                    table.insert(craftitem_list, k)
                end

                table.sort(craftitem_list)
                for _, full_name in ipairs(craftitem_list) do

                    count = count + 1
                    unilib.utils.chat_send_player(
                        name,
                        "   [craftitem] " .. full_name .. " < " ..
                                craftitem_convert_table[full_name]
                    )

                end

                local tool_list = {}
                for k, v in pairs(tool_convert_table) do
                    table.insert(tool_list, k)
                end

                table.sort(tool_list)
                for _, full_name in ipairs(tool_list) do

                    count = count + 1
                    unilib.utils.chat_send_player(
                        name, "   [tool] " .. full_name .. " < " .. tool_convert_table[full_name]
                    )

                end

                unilib.utils.chat_send_player(name, S("End of list (items found: @1)", count))

            end

        end,
    })

end
