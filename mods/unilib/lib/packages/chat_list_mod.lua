---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_mod = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_mods(pname, param)

    -- Basic check
    if unilib.utils.is_table_empty(unilib.global.source_mod_table) then
        return false, S("No source mods are specified by source.csv")
    end

    -- Filter out non-matching mods
    local filtered_list = {}
    for _, mod_name in ipairs(unilib.utils.sort_table(unilib.global.source_mod_table)) do

        local data_table = unilib.global.source_mod_table[mod_name]

        if param == "" or
                string.find(mod_name, param) or
                string.find(data_table.modpack_name, param) then

            table.insert(filtered_list, mod_name)

        end

    end

    if #filtered_list == 0 then
        return false, S("No mods matching \"@1\" found in source.csv", param)
    end

    -- Show source mods (from the files ../csv/mods/source.csv, imported.csv and updated.csv)
    unilib.utils.chat_send_player(pname, S("Source mods (* = updated) (# = loaded) [modpack name]"))

    for _, mod_name in ipairs(filtered_list) do

        local source_data_table = unilib.global.source_mod_table[mod_name]
        -- (All keys in unilib.global.source_mod_table also exist in
        --      unilib.global.imported_mod_table)
        local imported_data_table = unilib.global.imported_mod_table[mod_name]

        local column, modpack_name
        if source_data_table.update_date == nil then
            column = "  "
        else
            column = " *"
        end

        if not imported_data_table.loaded_flag then
            column = column .. "  "
        else
            column = column .. "# "
        end

        if source_data_table.modpack_name == nil or source_data_table.modpack_name == "" then
            modpack_name = ""
        else
            modpack_name = " [" .. source_data_table.modpack_name .. "]"
        end

        unilib.utils.chat_send_player(pname, column .. mod_name .. modpack_name)

    end

    unilib.utils.chat_send_player(pname, S("End of list (source mods found: @1)", #filtered_list))

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_mod.init()

    return {
        description = "Chat commands /list_mods, /list_mod",
        notes = "Lists all source mods, or just the specified source mod",
    }

end

function unilib.pkg.chat_list_mod.exec()

    core.register_chatcommand("list_mods", {
        params = "[mod]",
        description = S("Lists all source mods, or just the specified source mod"),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_list_mods(name, param)
        end,
    })

    core.register_chatcommand("list_mod", {
        params = "[mod]",
        description = S("Lists all source mods, or just the specified source mod"),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_list_mods(name, param)
        end,
    })

end
