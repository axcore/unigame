---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_dump_expansion = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_dump_mods(pname, param)

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

        if not unilib.global.ext_pack_table[mod_name] then

            unilib.utils.chat_send_player(pname, "       Path:   n/a")

        else

            unilib.utils.chat_send_player(
                pname, "       Path:   " .. unilib.global.ext_pack_table[mod_name]
            )

        end

        if unilib.global.expansion_mod_table[mod_name] then

            unilib.utils.chat_send_player(pname, "       Source: " .. data_table.url)
            unilib.utils.chat_send_player(pname, "       Notes:  " .. data_table.notes)

        end

    end

    unilib.utils.chat_send_player(
        pname, S("End of list (expansion packs found: @1)", #filtered_list)
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_dump_expansion.init()

    return {
        description = "Chat command /dump_expansion",
        notes = "Dumps details about all known expansion packs, or just the specified expansion" ..
                " pack",
    }

end

function unilib.pkg.chat_dump_expansion.exec()

    core.register_chatcommand("dump_expansion", {
        params = "[mod]",
        description = S(
            "Dumps details about all known expansion packs, or just the specified expansion pack"
        ),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_dump_mods(name, param)
        end,
    })

end
