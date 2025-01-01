---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_remixes = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_remixes(pname, param)

    if unilib.utils.is_table_empty(unilib.global.init_remix_list) then

        return false, S("No remixes are loaded")

    else

        unilib.utils.chat_send_player(pname, S("Loaded remixes"))

        local count = 0
        for _, remix_name in ipairs(unilib.global.init_remix_list) do

            unilib.utils.chat_send_player(pname, "   " .. remix_name)
            unilib.utils.chat_send_player(
                pname, "      " .. unilib.global.remix_dir_table[remix_name]
            )

            count = count + 1

        end

        unilib.utils.chat_send_player(pname, S("End of list (remixes loaded: @1)", count))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_remixes.init()

    return {
        description = "Chat commands /list_remixes, /list_remix",
        notes = "Lists all loaded remixes",
    }

end

function unilib.pkg.chat_list_remixes.exec()

    core.register_chatcommand("list_remixes", {
        params = "",
        description = S("Lists all loaded remixes"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_remixes(name, param)
        end,
    })

    core.register_chatcommand("list_remix", {
        params = "",
        description = S("Lists all loaded remixes"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_remixes(name, param)
        end,
    })

end
