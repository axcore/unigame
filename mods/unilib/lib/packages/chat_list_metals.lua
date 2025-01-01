---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_metals = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_metals(pname, param)

    if unilib.utils.is_table_empty(unilib.global.metal_table) then

        return false, S("No metal types are registered")

    else

        local metal_list = {}
        for k, _ in pairs(unilib.global.metal_table) do
            table.insert(metal_list, k)
        end

        table.sort(metal_list)

        unilib.utils.chat_send_player(
            pname,
            S(
                "List of registered metal types (A = alloy, F = fictional, P = powder," ..
                        "1-5 = hardness)"
            )
        )

        for _, part_name in ipairs(metal_list) do

            local column = " "
            local data_table = unilib.global.metal_table[part_name]

            if data_table.alloy_flag then
                column = column .. "A"
            else
                column = column .. " "
            end

            if data_table.fictional_flag then
                column = column .. "F"
            else
                column = column .. " "
            end

            if data_table.powder_flag then
                column = column .. "P"
            else
                column = column .. " "
            end

            column = column .. " " .. tostring(data_table.hardness) .. " "

            unilib.utils.chat_send_player(pname, column .. part_name)

        end

        unilib.utils.chat_send_player(pname, S("End of list (metal types found: @1)", #metal_list))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_metals.init()

    return {
        description = "Chat commands /list_metals, /list_metal",
        notes = "Lists all registered metal types",
    }

end

function unilib.pkg.chat_list_metals.exec()

    core.register_chatcommand("list_metals", {
        params = "",
        description = S("Lists all registered metal types"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_metals(name, param)
        end,
    })

    core.register_chatcommand("list_metal", {
        params = "",
        description = S("Lists all registered metal types"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_metals(name, param)
        end,
    })

end
