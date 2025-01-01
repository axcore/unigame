---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_expansion = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_mods(pname, param)

    -- Basic check
    if unilib.utils.is_table_empty(unilib.global.expansion_mod_table) then
        return false, S("No expansion packs are specified by expansion.csv")
    end

    -- Filter out non-matching expansion packs
    local pack_table = {}
    for mod_name, _ in pairs(unilib.global.expansion_mod_table) do
        pack_table[mod_name] = true
    end

    for mod_name, _ in pairs(unilib.global.ext_pack_table) do
        pack_table[mod_name] = true
    end

    local filtered_list = {}
    for _, mod_name in ipairs(unilib.utils.sort_table(pack_table)) do

        if param == "" or string.find(mod_name, param) then
            table.insert(filtered_list, mod_name)
        end

    end

    if #filtered_list == 0 then
        return false, S("No expansion packs matching \"@1\" found in expansion.csv", param)
    end

    -- Show expansion packs (from the file ../csv/mods/expansion.csv)
    unilib.utils.chat_send_player(pname, S("expansion packs (# = loaded, * = official)"))

    for _, mod_name in ipairs(filtered_list) do

        local data_table = unilib.global.expansion_mod_table[mod_name]

        local column, modmod_name
        if not unilib.global.ext_pack_table[mod_name] then
            column = "  "
        else
            column = " #"
        end

        if not unilib.global.expansion_mod_table[mod_name] then
            column = column .. "  "
        else
            column = column .. "* "
        end

        unilib.utils.chat_send_player(pname, column .. mod_name)

    end

    unilib.utils.chat_send_player(
        pname, S("End of list (expansion packs found: @1)", #filtered_list)
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_expansion.init()

    return {
        description = "Chat command /list_expansion",
        notes = "Lists all known expansion packs, or just the specified expansion pack",
    }

end

function unilib.pkg.chat_list_expansion.exec()

    core.register_chatcommand("list_expansion", {
        params = "[mod]",
        description = S("Lists all known expansion packs, or just the specified expansion pack"),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_list_mods(name, param)
        end,
    })

end
