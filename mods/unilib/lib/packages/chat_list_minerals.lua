---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_minerals = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_minerals(pname, param)

    if unilib.utils.is_table_empty(unilib.global.mineral_table) then

        return false, S("No mineral types are registered")

    else

        local mineral_list = {}
        for k, _ in pairs(unilib.global.mineral_table) do
            table.insert(mineral_list, k)
        end

        unilib.utils.chat_send_player(
            pname,
            S(
                "List of registered mineral types: (F = fictional, G = gem, P = powder," ..
                        " 1-5 = hardness)"
            )
        )

        table.sort(mineral_list)
        for _, part_name in ipairs(mineral_list) do

            local column = " "
            local data_table = unilib.global.mineral_table[part_name]

            if data_table.fictional_flag then
                column = column .. "F"
            else
                column = column .. " "
            end

            if data_table.gem_flag then
                column = column .. "G"
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

        unilib.utils.chat_send_player(
            pname, S("End of list (mineral types found: @1)", #mineral_list)
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_minerals.init()

    return {
        description = "Chat commands /list_minerals, /list_mineral",
        notes = "Lists all registered mineral types",
    }

end

function unilib.pkg.chat_list_minerals.exec()

    core.register_chatcommand("list_minerals", {
        params = "",
        description = S("Lists all registered mineral types"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_minerals(name, param)
        end,
    })

    core.register_chatcommand("list_mineral", {
        params = "",
        description = S("Lists all registered mineral types"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_minerals(name, param)
        end,
    })

end
