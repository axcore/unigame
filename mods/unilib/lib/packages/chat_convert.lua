---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_convert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_convert.init()

    return {
        description = "Chat command /convert",
        notes = "Shows the unilib equivalent of a node/craftitems/tools from an original mod",
    }

end

function unilib.pkg.chat_convert.exec()

    core.register_chatcommand("convert", {
        params = "[item]",
        description = S(
            "Shows the unilib equivalent of a node/craftitems/tools from an original mod"
        ),
        privs = {unilib_tools = true},

        func = function(name, param)

            local count = 0

            if param ~= "" then

                match_flag = false

                if unilib.global.node_convert_table[param] ~= nil then

                    match_flag = true
                    unilib.utils.chat_send_player(
                        name, "[node] " .. param .. " > " .. unilib.global.node_convert_table[param]
                    )

                end

                if unilib.global.craftitem_convert_table[param] ~= nil then

                    match_flag = true
                    unilib.utils.chat_send_player(
                        name,
                        "[craftitem] " .. param .. " > " ..
                                unilib.global.craftitem_convert_table[param]
                    )

                end

                if unilib.global.tool_convert_table[param] ~= nil then

                    match_flag = true
                    unilib.utils.chat_send_player(
                        name, "[tool] " .. param .. " > " .. unilib.global.tool_convert_table[param]
                    )

                end

                if not match_flag then
                    return false, S("Item not found in conversion tables: @1", param)
                end

            else

                unilib.utils.chat_send_player(name, S("Original and unilib nodes/craftitems/tools"))

                local node_list = {}
                for k, v in pairs(unilib.global.node_convert_table) do
                    table.insert(node_list, k)
                end

                table.sort(node_list)
                for _, full_name in ipairs(node_list) do

                    unilib.utils.chat_send_player(
                        name,
                        "   [node] " .. full_name .. " > " ..
                                unilib.global.node_convert_table[full_name]
                    )

                    count = count + 1

                end

                local craftitem_list = {}
                for k, v in pairs(unilib.global.craftitem_convert_table) do
                    table.insert(craftitem_list, k)
                end

                table.sort(craftitem_list)
                for _, full_name in ipairs(craftitem_list) do

                    unilib.utils.chat_send_player(
                        name,
                        "   [craftitem] " .. full_name .. " > " ..
                        unilib.global.craftitem_convert_table[full_name]
                    )

                    count = count + 1

                end

                local tool_list = {}
                for k, v in pairs(unilib.global.tool_convert_table) do
                    table.insert(tool_list, k)
                end

                table.sort(tool_list)
                for _, full_name in ipairs(tool_list) do

                    unilib.utils.chat_send_player(
                        name,
                        "   [tool] " .. full_name .. " > " ..
                                unilib.global.tool_convert_table[full_name]
                    )

                    count = count + 1

                end

                unilib.utils.chat_send_player(name, S("End of list (items found: @1)", count))

            end

        end,
    })

end
