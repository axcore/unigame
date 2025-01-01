---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_groups = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_groups.init()

    return {
        description = "Chat command /list_groups",
        notes = "List groups, and the items that provide them",
        depends = "shared_chat_missing",
    }

end

function unilib.pkg.chat_list_groups.exec()

    core.register_chatcommand("list_groups", {
        params = "[group_name]",
        description = S("List groups, and the items that provide them"),
        privs = {unilib_tools = true},

        func = function(name, param)

            local group_table = unilib.pkg.shared_chat_missing.compile_group_table()
            if param ~= "" then

                if group_table[param] == nil then

                    return false, S("No items provide the \"@1\" group", param)

                else

                    local item_list = group_table[param]
                    group_table = {}
                    group_table[param] = item_list

                end

            end

            unilib.utils.chat_send_player(name, S("Registered groups"))

            local group_list = unilib.utils.sort_table(group_table)
            for _, group_name in ipairs(group_list) do

                unilib.utils.chat_send_player(name, S("Group: @1", group_name))
                local item_list = group_table[group_name]
                table.sort(item_list)

                for _, full_name in ipairs(item_list) do
                    unilib.utils.chat_send_player(name, "   " .. full_name)
                end

            end

            unilib.utils.chat_send_player(
                name, S("End of list (unique groups found: @1)", #group_list)
            )

        end,
    })

end
