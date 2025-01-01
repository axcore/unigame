---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_biomes = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_list_biomes(pname, param)

    local biome_list = {}
    local count = 0

    for k, _ in pairs(core.registered_biomes) do

        -- (The LUA sorting mechanism fails, if it is asked to compare strings and numbers)
        table.insert(biome_list, tostring(k))
        count = count + 1

    end

    if count == 0 then

        return false, S("No biomes are registered")

    else

        unilib.utils.chat_send_player(pname, S("Registered biomes"))

        table.sort(biome_list)
        for _, biome_name in ipairs(biome_list) do
            unilib.utils.chat_send_player(pname, "   " .. biome_name)
        end

        unilib.utils.chat_send_player(pname, S("End of list (biomes found: @1)", count))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_biomes.init()

    return {
        description = "Chat commands /list_biomes, /list_biome",
        notes = "Lists all registered biomes",
    }

end

function unilib.pkg.chat_list_biomes.exec()

    core.register_chatcommand("list_biomes", {
        params = "",
        description = S("Lists all registered biomes"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_biomes(name, param)
        end,
    })

    core.register_chatcommand("list_biome", {
        params = "",
        description = S("Lists all registered biomes"),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_biomes(name, param)
        end,
    })

end
