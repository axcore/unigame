---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_liquids = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_liquids(pname, param)

    if unilib.utils.is_table_empty(unilib.global.generic_liquid_table) then

        return false, S("No liquid types have been registered")

    elseif param ~= nil and param ~= "" then

        -- Ignore multiple liquid types, if specified
        local liquid_list = unilib.utils.split_string_by_whitespace(param)
        local liquid_type = liquid_list[1]

        if liquid_type == nil or
                liquid_type == "" or
                unilib.global.generic_liquid_table[liquid_type] == nil then

            return false, S("Unrecognised liquid type, try /list_liquids")

        else

            local mini_table = unilib.global.generic_liquid_table[liquid_type]

            unilib.utils.chat_send_player(
                pname, S("Information for liquid type \"@1\"", liquid_type)
            )

            if mini_table.description and mini_table.description ~= "" then

                unilib.utils.chat_send_player(
                    pname, "   " .. S("Description") .. ": " .. mini_table.description
                )

           end

            if mini_table.source_name and mini_table.source_name ~= "" then

                unilib.utils.chat_send_player(
                    pname, "   " .. S("Source node") .. ": " .. mini_table.source_name
                )

            end

            if mini_table.flowing_name and mini_table.flowing_name ~= "" then

                unilib.utils.chat_send_player(
                    pname, "   " .. S("Flowing node") .. ": " .. mini_table.flowing_name
                )

            end

            if mini_table.burntime and mini_table.burntime ~= "" then

                unilib.utils.chat_send_player(
                    pname, "   " .. S("Burntime") .. ": " .. mini_table.burntime
                )

            end

            if mini_table.force_renew_flag and mini_table.force_renew_flag == true then
                unilib.utils.chat_send_player(pname, "   " .. S("Force renew: YES"))
            end

            if mini_table.potable_flag and mini_table.potable_flag == true then
                unilib.utils.chat_send_player(pname, "   " .. S("Potable: YES"))
            end

            if mini_table.water_flag and mini_table.water_flag == true then
                unilib.utils.chat_send_player(pname, "   " .. S("Water: YES"))
            end

            unilib.utils.chat_send_player(pname, S("End of liquid type information"))

        end

    else

        local liquid_list = {}
        for k, _ in pairs(unilib.global.generic_liquid_table) do
            table.insert(liquid_list, k)
        end

        table.sort(liquid_list)

        unilib.utils.chat_send_player(
            pname, S("List of liquid types (F = force renew, P = potable, W = water)")
        )

        for _, liquid_type in ipairs(liquid_list) do

            local mini_table = unilib.global.generic_liquid_table[liquid_type]

            local column = " "
            if mini_table.force_renew_flag and mini_table.force_renew_flag == true then
                column = column .. "F"
            else
                column = column .. " "
            end

            if mini_table.potable_flag and mini_table.potable_flag == true then
                column = column .. "P"
            else
                column = column .. " "
            end

            if mini_table.water_flag and mini_table.water_flag == true then
                column = column .. "W"
            else
                column = column .. " "
            end

            unilib.utils.chat_send_player(
                pname, column .. " " .. liquid_type .. " [" .. mini_table.description .. "]"
            )

        end

        unilib.utils.chat_send_player(
            pname, S("End of list (liquid types found: @1)", #liquid_list)
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_liquids.init()

    return {
        description = "Chat commands /list_liquids, /list_liquid",
        notes = "Lists all liquid types, or details for the specified liquid type",
    }

end

function unilib.pkg.chat_list_liquids.exec()

    core.register_chatcommand("list_liquids", {
        params = "",
        description = S("Lists all liquid types, or details for the specified liquid type"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_liquids(name, param)
        end,
    })

    core.register_chatcommand("list_liquid", {
        params = "",
        description = S("Lists all liquid types, or details for the specified liquid type"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_liquids(name, param)
        end,
    })

end
