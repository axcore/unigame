---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_nonmetals = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_nonmetals(pname, param)

    if unilib.utils.is_table_empty(unilib.global.non_metal_table) then

        return false, S("No elemental non-metal types are registered")

    else

        local non_metal_list = {}
        for k, _ in pairs(unilib.global.non_metal_table) do
            table.insert(non_metal_list, k)
        end

        unilib.utils.chat_send_player(pname, S("List of registered elemental types"))

        table.sort(non_metal_list)
        for _, part_name in ipairs(non_metal_list) do
            unilib.utils.chat_send_player(pname, "   " .. part_name)
        end

        unilib.utils.chat_send_player(
            pname, S("End of list (elemental non-metal types found: @1)", #non_metal_list)
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_nonmetals.init()

    return {
        description = "Chat commands /list_nonmetals, /list_nonmetal",
        notes = "Lists all registered elemental non-metal types",
    }

end

function unilib.pkg.chat_list_nonmetals.exec()

    core.register_chatcommand("list_nonmetals", {
        params = "",
        description = S("Lists all registered elemental non-metal types"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_nonmetals(name, param)
        end,
    })

    core.register_chatcommand("list_nonmetal", {
        params = "",
        description = S("Lists all registered elemental non-metal types"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_nonmetals(name, param)
        end,
    })

end
