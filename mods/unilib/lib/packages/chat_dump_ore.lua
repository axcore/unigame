---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_dump_ore = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_dump_ore(pname, param)

    local ore_list = {}
    local count = 0

    for _, ore_table in pairs(core.registered_ores) do

        if param == "" or
                (ore_table.type ~= nil and string.find(ore_table.type, param)) or
                (ore_table.ore ~= nil and string.find(ore_table.ore, param)) or
                (ore_table.wherein ~= nil and string.find(ore_table.wherein, param)) then

            table.insert(ore_list, ore_table)
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No ores are registered")
        else
            return false, S("No registered ores match the pattern \"@1\"", param)
        end

    else

        if param == "" then
            unilib.utils.chat_send_player(pname, S("List of registered ores"))
        else
            unilib.utils.chat_send_player(pname, S("List of matching ores"))
        end

        for _, ore_table in ipairs(ore_list) do

            unilib.utils.chat_send_player(pname, "Ore: " .. ore_table.ore)
            unilib.utils.show_table_in_chat(pname, ore_table)

        end

        unilib.utils.chat_send_player(pname, S("End of list (matching ores found: @1)", count))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_dump_ore.init()

    return {
        description = "Chat command /dump_ore",
        notes = "Dumps definitions of ores with a matching type, ore node or wherein node",
    }

end

function unilib.pkg.chat_dump_ore.exec()

    core.register_chatcommand("dump_ore", {
        params = "<pattern>",
        description = S(
            "Dumps ore definitions for any ore whose type/ore node/wherein node matches the pattern"
        ),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_dump_ore(name, param)
        end,
    })

end
