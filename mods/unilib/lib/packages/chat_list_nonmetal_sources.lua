---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_nonmetal_sources = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_nonmetal_sources(pname, param)

    local source_table = {}
    local no_source_list = {}

    for k, _ in pairs(unilib.global.non_metal_table) do
        source_table[k] = {}
    end

    for k, _ in pairs(unilib.global.mineral_table) do

        for _, v in ipairs(unilib.global.mineral_table[k]["non_metal_list"]) do

            if source_table[v] == nil then
                source_table[v] = {k}
            else
                table.insert(source_table[v], k)
            end

        end

    end

    if unilib.utils.is_table_empty(source_table) then

        return false, S("No elemental non-metal sources are registered")

    else

        local source_list = {}
        for k, _ in pairs(source_table) do
            table.insert(source_list, k)
        end

        unilib.utils.chat_send_player(pname, S("List of registered elemental non-metal sources"))

        table.sort(source_list)
        for _, non_metal_name in ipairs(source_list) do

            local mineral_list = source_table[non_metal_name]

            unilib.utils.chat_send_player(pname, "   " .. non_metal_name)
            if not next(mineral_list) then

                unilib.utils.chat_send_player(pname, "      (no sources)")
                table.insert(no_source_list, non_metal_name)

            else

                unilib.utils.chat_send_player(pname, "      " .. table.concat(mineral_list, ", "))

            end

        end

        unilib.utils.chat_send_player(
            pname, S("End of list (elemental non-metal sources found: @1)", #source_list)
        )

        if next(no_source_list) then

            unilib.utils.chat_send_player(pname, S("Non-metals with no sources:"))

            table.sort(no_source_list)
            for _, non_metal_name in ipairs(no_source_list) do
                unilib.utils.chat_send_player(pname, "   " .. non_metal_name)
            end

            unilib.utils.chat_send_player(
                pname,
                S("End of list (unsourced elemental non-metals found: @1)", #no_source_list)
            )

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_nonmetal_sources.init()

    return {
        description = "Chat commands /list_nonmetal_sources, /list_nonmetal_source",
        notes = "Lists all elemental non-metals provided by mineral sources",
    }

end

function unilib.pkg.chat_list_nonmetal_sources.exec()

    core.register_chatcommand("list_nonmetal_sources", {
        params = "",
        description = S("Lists all elemental non-metals provided by mineral sources"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_nonmetal_sources(name, param)
        end,
    })

    core.register_chatcommand("list_nonmetal_source", {
        params = "",
        description = S("Lists all elemental non-metals provided by mineral sources"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_nonmetal_sources(name, param)
        end,
    })

end
