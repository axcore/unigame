---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_hidden = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_hidden.init()

    return {
        description = "Chat command /list_hidden",
        notes = "Lists all hidden (because they can't be unregistered) nodes, craftitems and tools",
    }

end

function unilib.pkg.chat_list_hidden.exec()

    core.register_chatcommand("list_hidden", {
        params = "",
        description = S(
            "Lists all hidden nodes, craftitems and tools (items are \"hidden\" when they" ..
                    " cannot be unregistered)"
        ),
        privs = {unilib_tools = true},

        func = function(name, param)

            local hidden_list = {}
            local count = 0

            for k, v in pairs (unilib.global.hidden_item_table) do

                table.insert(hidden_list, tostring(k))
                count = count + 1

            end

            if count == 0 then

                return false, S("No hidden items found")

            else

                unilib.utils.chat_send_player(name, S("List of hidden items"))

                table.sort(hidden_list)
                for _, full_name in ipairs(hidden_list) do
                    unilib.utils.chat_send_player(name, "   " .. full_name)
                end

                unilib.utils.chat_send_player(
                    name, S("End of list (hidden items found: @1)", count)
                )

            end

        end,
    })

end
