---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- convert.lua
--      Set up chat commands for converting original items into unilib items, and vice-versa
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Convert names of original or unilib nodes/craftitems/tools
-- /convert: Shows the unilib equivalent of a node/craftitems/tools from an original mod
-- /deconvert: Shows the original mod equivalent or a node/craftitems/tools from unilib
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("convert", {
    params = "[<item>]",
    description = S("Shows the unilib equivalent of a node/craftitems/tools from an original mod"),
    privs = {unilib_tools = true},

    func = function(name, param)

        local count = 0

        if param ~= "" then

            match_flag = false

            if unilib.node_convert_table[param] ~= nil then

                match_flag = true
                minetest.chat_send_player(
                    name, "[node] " .. param .. " > " .. unilib.node_convert_table[param]
                )

            end

            if unilib.craftitem_convert_table[param] ~= nil then

                match_flag = true
                minetest.chat_send_player(
                    name, "[craftitem] " .. param .. " > " .. unilib.craftitem_convert_table[param]
                )

            end

            if unilib.tool_convert_table[param] ~= nil then

                match_flag = true
                minetest.chat_send_player(
                    name, "[tool] " .. param .. " > " .. unilib.tool_convert_table[param]
                )

            end

            if not match_flag then
                return false, S("Item not found in conversion tables", param)
            end

        else

            minetest.chat_send_player(name, S("Original and unilib nodes/craftitems/tools"))

            local node_list = {}
            for k, v in pairs(unilib.node_convert_table) do
                table.insert(node_list, k)
            end

            table.sort(node_list)
            for _, full_name in ipairs(node_list) do

                minetest.chat_send_player(
                    name, "   [node] " .. full_name .. " > " .. unilib.node_convert_table[full_name]
                )

                count = count + 1

            end

            local craftitem_list = {}
            for k, v in pairs(unilib.craftitem_convert_table) do
                table.insert(craftitem_list, k)
            end

            table.sort(craftitem_list)
            for _, full_name in ipairs(craftitem_list) do

                minetest.chat_send_player(
                    name,
                    "   [craftitem] " .. full_name .. " > " ..
                    unilib.craftitem_convert_table[full_name]
                )

                count = count + 1

            end

            local tool_list = {}
            for k, v in pairs(unilib.tool_convert_table) do
                table.insert(tool_list, k)
            end

            table.sort(tool_list)
            for _, full_name in ipairs(tool_list) do

                minetest.chat_send_player(
                    name, "   [tool] " .. full_name .. " > " .. unilib.tool_convert_table[full_name]
                )

                count = count + 1

            end

            minetest.chat_send_player(name, S("End of list (items found: @1)", count))

        end

    end,
})

minetest.register_chatcommand("deconvert", {
    params = "[<item>]",
    description = S("Shows the original mod equivalent or a node/craftitems/tools from unilib"),
    privs = {unilib_tools = true},

    func = function(name, param)

        local count = 0

        -- Reverse the conversion tables. It's probably safe to assume that each value in the
        --      original key-value pairs is unique
        local node_convert_table = {}
        for k, v in pairs(unilib.node_convert_table) do
            node_convert_table[v] = k
        end

        local craftitem_convert_table = {}
        for k, v in pairs(unilib.craftitem_convert_table) do
            craftitem_convert_table[v] = k
        end

        local tool_convert_table = {}
        for k, v in pairs(unilib.tool_convert_table) do
            tool_convert_table[v] = k
        end

        if param ~= "" then

            match_flag = false

            if node_convert_table[param] ~= nil then

                match_flag = true
                minetest.chat_send_player(
                    name, "[node] " .. param .. " < " .. node_convert_table[param]
                )

            end

            if craftitem_convert_table[param] ~= nil then

                match_flag = true
                minetest.chat_send_player(
                    name, "[craftitem] " .. param .. " < " .. craftitem_convert_table[param]
                )

            end

            if tool_convert_table[param] ~= nil then

                match_flag = true
                minetest.chat_send_player(
                    name, "[tool] " .. param .. " < " .. tool_convert_table[param]
                )

            end

            if not match_flag then
                return false, S("Item not found in deconversion tables", param)
            end

        else

            minetest.chat_send_player(name, S("Original and unilib nodes/craftitems/tools"))

            local node_list = {}
            for k, v in pairs(node_convert_table) do
                table.insert(node_list, k)
            end

            table.sort(node_list)
            for _, full_name in ipairs(node_list) do

                count = count + 1
                minetest.chat_send_player(
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
                minetest.chat_send_player(
                    name,
                    "   [craftitem] " .. full_name .. " < " .. craftitem_convert_table[full_name]
                )

            end

            local tool_list = {}
            for k, v in pairs(tool_convert_table) do
                table.insert(tool_list, k)
            end

            table.sort(tool_list)
            for _, full_name in ipairs(tool_list) do

                count = count + 1
                minetest.chat_send_player(
                    name, "   [tool] " .. full_name .. " < " .. tool_convert_table[full_name]
                )

            end

            minetest.chat_send_player(name, S("End of list (items found: @1)", count))

        end

    end,
})
