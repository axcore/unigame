---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_compatible = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_mods(pname, param)

    -- Basic check
    if unilib.utils.is_table_empty(unilib.global.compatible_mod_table) then
        return false, S("No compatible mods are specified by compatible.csv")
    end

    -- Filter out non-matching mods
    local filtered_list = {}
    for _, mod_name in ipairs(unilib.utils.sort_table(unilib.global.compatible_mod_table)) do

        local data_table = unilib.global.compatible_mod_table[mod_name]

        if param == "" or
                string.find(mod_name, param) or
                string.find(data_table.modpack_name, param) then

            table.insert(filtered_list, mod_name)

        end

    end

    if #filtered_list == 0 then
        return false, S("No mods matching \"@1\" found in compatible.csv", param)
    end

    -- Show compatible mods (from the file ../csv/mods/compatible.csv)
    unilib.utils.chat_send_player(pname, S("Compatible mods (# = loaded) [modpack name]"))

    for _, mod_name in ipairs(filtered_list) do

        local data_table = unilib.global.compatible_mod_table[mod_name]

        local column, modpack_name
        if not core.get_modpath(mod_name) then
            column = "   "
        else
            column = " # "
        end

        if data_table.modpack_name == nil or data_table.modpack_name == "" then
            modpack_name = ""
        else
            modpack_name = " [" .. data_table.modpack_name .. "]"
        end

        unilib.utils.chat_send_player(pname, column .. mod_name .. modpack_name)

    end

    unilib.utils.chat_send_player(
        pname, S("End of list (compatible mods found: @1)", #filtered_list)
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_compatible.init()

    return {
        description = "Chat command /list_compatible",
        notes = "Lists all compatible mods, or just the specified compatible mod",
    }

end

function unilib.pkg.chat_list_compatible.exec()

    core.register_chatcommand("list_compatible", {
        params = "[mod]",
        description = S("Lists all compatible mods, or just the specified compatible mod"),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_list_mods(name, param)
        end,
    })

end
