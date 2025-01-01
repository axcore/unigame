---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_entities = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_entities(pname, param)

    local entity_list = {}
    local count = 0

    local not_flag, param = unilib.pkg.shared_chat_list.convert_param(param)

    for k, _ in pairs(core.registered_entities) do

        if param == "" or
                (not not_flag and string.find(k, ":") and param == string.split(k, ":")[1]) or
                (not_flag and string.find(k, ":") and param ~= string.split(k, ":")[1]) then

            table.insert(entity_list, tostring(k))
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No entities are registered")
        elseif not_flag then
            return false, S("No entities are registered for mods other than the  \"@1\" mod", param)
        else
            return false, S("No entities are registered for the \"@1\" mod", param)
        end

    else

        if param == "" then

            unilib.utils.chat_send_player(pname, S("Registered entities"))

        elseif not_flag then

            unilib.utils.chat_send_player(
                pname, S("Registered entities for mods other than the \"@1\" mod", param)
            )

        else

            unilib.utils.chat_send_player(pname, S("Registered entities for the \"@1\" mod", param))

        end

        table.sort(entity_list)
        for _, full_name in ipairs(entity_list) do
            unilib.utils.chat_send_player(pname, "   " .. full_name)
        end

        unilib.utils.chat_send_player(pname, S("End of list (entities found: @1)", count))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_entities.init()

    return {
        description = "Chat commands /list_entities, /list_entity",
        notes = "Lists all registered entities, or just entities from the specified mod",
        depends = "shared_chat_list",
    }

end

function unilib.pkg.chat_list_entities.exec()

    core.register_chatcommand("list_entities", {
        params = "[mod]",
        description = S("Lists all registered entities, or just entities from the specified mod" ..
                " (use \"!<mod>\" to list entities from all mods but the specified one)"
        ),
        privs = {unilib_tools = true},

        func = function(name, param)
            do_list_entities(name, param)
        end,
    })

    core.register_chatcommand("list_entity", {
        params = "[mod]",
        description = S("Lists all registered entities, or just entities from the specified mod" ..
                " (use \"!<mod>\" to list entities from all mods but the specified one)"
        ),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_entities(name, param)
        end,
    })

end
