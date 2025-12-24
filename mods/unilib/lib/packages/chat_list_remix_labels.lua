---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_remix_labels = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_labels(pname, param)

    if unilib.utils.is_table_empty(unilib.global.init_remix_list) then
        return false, S("No remixes are loaded")
    elseif unilib.utils.is_table_empty(unilib.global.remix_label_table) then
        return false, S("No loaded remixes have labels")
    end

    unilib.utils.chat_send_player(pname, S("Loaded remixes with labels"))

    local count = 0
    for _, remix_name in ipairs(unilib.global.init_remix_list) do

        if unilib.global.remix_label_table[remix_name] ~= nil then

            unilib.utils.chat_send_player(pname, "   Remix  : " .. remix_name)

            local sorted_list = unilib.utils.sort_table(unilib.global.remix_label_table[remix_name])
            unilib.utils.chat_send_player(pname, "   Labels :   " .. table.concat(sorted_list, " "))

            count = count + #sorted_list

        end

    end

    unilib.utils.chat_send_player(pname, S("End of list (labels found: @1)", count))

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_remix_labels.init()

    return {
        description = "Chat commands /list_remix_labels, /list_remix_label",
        notes = "Lists all loaded remixes which have labels",
    }

end

function unilib.pkg.chat_list_remixes.exec()

    core.register_chatcommand("list_remix_labels", {
        params = "",
        description = S("Lists all loaded remixes which have labels"),
        privs = {unilib_tools = true},

        func = function(pname, param)
            return do_list_labels(pname, param)
        end,
    })

    core.register_chatcommand("list_remix_label", {
        params = "",
        description = S("Lists all loaded remixes which have labels"),
        privs = {unilib_tools = true},

        func = function(pname, param)
            return do_list_labels(pname, param)
        end,
    })

end
