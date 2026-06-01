---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_show_vocation = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_show(pname)

    -- Basic checks
    if not unilib.setting.awards_enable_flag then
        return false, S("Player awards are not enabled in settings")
    end

    -- Sort vocations by title (not by name)
    local vocation_list = {}
    for vocation_name, _ in pairs(unilib.global.awards_vocation_table) do
        table.insert(vocation_list, vocation_name)
    end

    table.sort(vocation_list, function(a, b)

        return unilib.global.awards_vocation_table[a].title <
            unilib.global.awards_vocation_table[b].title

    end)

    -- Show the list
    unilib.utils.chat_send_player(pname, S("List of vocation awards"))

    for _, vocation_name in ipairs(vocation_list) do

        local data_table = unilib.global.awards_vocation_table[vocation_name]

        unilib.utils.chat_send_player(
            pname, "   " .. data_table.title .. " [" .. vocation_name .. "]"
        )
        unilib.utils.chat_send_player(pname, "      " .. data_table.description)

    end

    unilib.utils.chat_send_player(pname, S("End of list (vocations found: @1)", #vocation_list))

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_show_vocation.init()

    return {
        description = "Chat commands /show_vocation, /show_vocations",
        notes = "Shows a list of vocation awards",
    }

end

function unilib.pkg.chat_show_vocation.exec()

    core.register_chatcommand("show_vocation", {
        params = "",
        description = S("Shows a list of vocation awards"),
        privs = {unilib_admin = true},

        func = function(pname, param)
            return do_show(pname)
        end,
    })

    core.register_chatcommand("show_vocations", {
        params = "",
        description = S("Shows a list of vocation awards"),
        privs = {unilib_admin = true},

        func = function(pname, param)
            return do_show(pname)
        end,
    })

end
