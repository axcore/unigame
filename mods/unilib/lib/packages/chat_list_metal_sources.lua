---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_metal_sources = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_metal_sources(pname, param)

    local source_table = {}
    local no_source_list = {}

    for k, _ in pairs(unilib.global.metal_table) do
        source_table[k] = {}
    end

    for k, _ in pairs(unilib.global.mineral_table) do

        for _, v in ipairs(unilib.global.mineral_table[k]["metal_list"]) do

            if source_table[v] == nil then
                source_table[v] = {k}
            else
                table.insert(source_table[v], k)
            end

        end

    end

    if unilib.utils.is_table_empty(source_table) then

        return false, S("No metal sources are registered")

    else

        local source_list = {}
        for k, _ in pairs(source_table) do
            table.insert(source_list, k)
        end

        unilib.utils.chat_send_player(pname, S("List of registered metal sources"))

        table.sort(source_list)
        for _, metal_name in ipairs(source_list) do

            local mineral_list = source_table[metal_name]

            unilib.utils.chat_send_player(pname, "   " .. metal_name)
            if not next(mineral_list) then

                unilib.utils.chat_send_player(pname, "      (no sources)")
                table.insert(no_source_list, metal_name)

            else

                unilib.utils.chat_send_player(pname, "      " .. table.concat(mineral_list, ", "))

            end

        end

        unilib.utils.chat_send_player(
            pname, S("End of list (metal sources found: @1)", #source_list)
        )

        if next(no_source_list) then

            unilib.utils.chat_send_player(pname, S("List of metals with no sources (* = alloy)"))

            table.sort(no_source_list)
            for _, metal_name in ipairs(no_source_list) do

                local data_table = unilib.global.metal_table[metal_name]
                if data_table == nil or data_table.alloy_flag ~= true then
                    unilib.utils.chat_send_player(pname, "   " .. metal_name)
                else
                    unilib.utils.chat_send_player(pname, " * " .. metal_name)
                end

            end

            unilib.utils.chat_send_player(
                pname, S("End of list (unsourced metals found: @1)", #no_source_list)
            )

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_metal_sources.init()

    return {
        description = "Chat commands /list_metal_sources, /list_metal_source",
        notes = "Lists all metals provided by mineral sources",
    }

end

function unilib.pkg.chat_list_metal_sources.exec()

    core.register_chatcommand("list_metal_sources", {
        params = "",
        description = S("Lists all metals provided by mineral sources"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_metal_sources(name, param)
        end,
    })

    core.register_chatcommand("list_metal_source", {
        params = "",
        description = S("Lists all metals provided by mineral sources"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_metal_sources(name, param)
        end,
    })

end
