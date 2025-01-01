---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_stones = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_stones(pname, param)

    if unilib.utils.is_table_empty(unilib.global.stone_table) then

        return false, S("No stone types have been registered")

    elseif param ~= nil and param ~= "" then

        -- Ignore multiple stone types, if specified
        local stone_list = unilib.utils.split_string_by_whitespace(param)
        local stone_type = stone_list[1]

        if stone_type == nil or
                stone_type == "" or
                unilib.global.stone_table[stone_type] == nil then

            return false, S("Unrecognised stone type, try /list_stones")

        else

            local mini_table = unilib.global.stone_table[stone_type]

            unilib.utils.chat_send_player(pname, S("Information for stone type \"@1\"", stone_type))

            if mini_table.description and mini_table.description ~= "" then

                unilib.utils.chat_send_player(
                    pname, "   " .. S("Description") .. ": " .. mini_table.description
                )

            end

            if mini_table.category and mini_table.category ~= "" then

                unilib.utils.chat_send_player(
                    pname, "   " .. S("Category") .. ": " .. mini_table.category
                )

            end

            if mini_table.super_flag and mini_table.super_flag == true then
                unilib.utils.chat_send_player(pname, "   " .. S("Super stone: YES"))
            end

            if mini_table.fictional_flag and mini_table.fictional_flag == true then
                unilib.utils.chat_send_player(pname, "   " .. S("Fictional: YES"))
            end

            if mini_table.grinder_flag and mini_table.grinder_flag == true then
                unilib.utils.chat_send_player(pname, "   " .. S("Technic grinder recipe: YES"))
            end

            if mini_table.hardness and mini_table.hardness ~= "" then

                unilib.utils.chat_send_player(
                    pname, "   " .. S("Hardness (in-game)") .. ": " .. mini_table.hardness
                )

            end

            if mini_table.hardness_real and mini_table.hardness_real ~= "" then

                unilib.utils.chat_send_player(
                    pname, "   " .. S("Hardness (real)") .. ": " .. mini_table.hardness_real
                )

            end

            if mini_table.moss_flag and mini_table.moss_flag == true then
                unilib.utils.chat_send_player(pname, "   " .. S("Moss growth: YES"))
            end

            if mini_table.no_smooth_flag and mini_table.no_smooth_flag == true then
                unilib.utils.chat_send_player(pname, "   " .. S("No smooth stone variant: YES"))
            end

            if mini_table.platform_list and mini_table.platform_list ~= "" then

                unilib.utils.chat_send_player(pname,
                    "   " .. S("Train platforms") .. ": " ..
                            unilib.utils.convert_to_string(mini_table.platform_list)
                )

            end

            unilib.utils.chat_send_player(pname, S("End of stone type information"))

        end

    else

        local stone_list = {}
        for k, _ in pairs(unilib.global.stone_table) do
            table.insert(stone_list, k)
        end

        table.sort(stone_list)

        unilib.utils.chat_send_player(
            pname,
            S(
                "List of stone types (* = super stone, F = fictional, G = grinder recipe," ..
                        " 1-5 = hardness)"
            )
        )

        unilib.utils.chat_send_player(
            pname,
            S(
                "<S = smoothstone, B = block, b = brick, C = cobble, M = mossy cobble," ..
                        " R = rubble, p = compressed, d = condensed>"
            )
        )

        for _, stone_type in ipairs(stone_list) do

            local mini_table = unilib.global.stone_table[stone_type]

            local column = " "
            if mini_table.super_flag and mini_table.super_flag == true then
                column = column .. "*"
            else
                column = column .. " "
            end

            if mini_table.fictional_flag and mini_table.fictional_flag == true then
                column = column .. "F"
            else
                column = column .. " "
            end

            if mini_table.grinder_flag and mini_table.grinder_flag == true then
                column = column .. "G"
            else
                column = column .. " "
            end

            if mini_table.hardness and mini_table.hardness ~= "" then
                column = column .. tostring(mini_table.hardness)
            else
                column = column .. " "
            end

            local postscript = ""
            local full_name = "unilib:stone_" .. stone_type

            if core.registered_nodes[full_name] ~= nil then
                postscript = postscript .. "S"
            end

            if core.registered_nodes[full_name .. "_block"] ~= nil then
                postscript = postscript .. "B"
            end

            if core.registered_nodes[full_name .. "_brick"] ~= nil then
                postscript = postscript .. "b"
            end

            if core.registered_nodes[full_name .. "_cobble"] ~= nil then
                postscript = postscript .. "C"
            end

            if core.registered_nodes[full_name .. "_cobble_mossy"] ~= nil then
                postscript = postscript .. "M"
            end

            if core.registered_nodes[full_name .. "_rubble"] ~= nil then
                postscript = postscript .. "R"
            end

            if core.registered_nodes[full_name .. "_cobble_compressed"] ~= nil or
                    core.registered_nodes[full_name .. "_rubble_compressed"] ~= nil or
                    core.registered_nodes[full_name .. "_compressed"] ~= nil then
                postscript = postscript .. "p"
            end

            if core.registered_nodes[full_name .. "_cobble_condensed"] ~= nil or
                    core.registered_nodes[full_name .. "_rubble_condensed"] ~= nil or
                    core.registered_nodes[full_name .. "_condensed"] ~= nil then
                postscript = postscript .. "d"
            end

            if postscript ~= "" then
                postscript = " <" .. postscript .. ">"
            end

            unilib.utils.chat_send_player(
                pname,
                column .. " " .. stone_type .. " [" .. mini_table.category .. "]" .. postscript
            )

        end

        unilib.utils.chat_send_player(pname, S("End of list (stone types found: @1)", #stone_list))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_stones.init()

    return {
        description = "Chat commands /list_stones, /list_stone",
        notes = "Lists stone types, or details for the specified stone type",
    }

end

function unilib.pkg.chat_list_stones.exec()

    core.register_chatcommand("list_stones", {
        params = "",
        description = S("Lists all stone types, or details for the specified stone type"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_stones(name, param)
        end,
    })

    core.register_chatcommand("list_stone", {
        params = "",
        description = S("Lists all stone types, or details for the specified stone type"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_stones(name, param)
        end,
    })

end
