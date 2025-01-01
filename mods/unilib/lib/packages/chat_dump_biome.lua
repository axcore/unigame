---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_dump_biome = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_dump_biome(pname, param)

    local biome_list = {}
    local count = 0

    for k, _ in pairs(core.registered_biomes) do

        if param == "" or string.find(k, param) then

            table.insert(biome_list, tostring(k))
            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No biomes are registered")
        else
            return false, S("No registered biomes match the pattern \"@1\"", param)
        end

    else

        if param == "" then
            unilib.utils.chat_send_player(pname, S("List of registered biomes"))
        else
            unilib.utils.chat_send_player(pname, S("List of matching biomes"))
        end

        table.sort(biome_list)
        for _, biome_name in ipairs(biome_list) do

            unilib.utils.chat_send_player(pname, "Biome: " .. biome_name)
            unilib.utils.show_table_in_chat(pname, core.registered_biomes[biome_name])

        end

        unilib.utils.chat_send_player(pname, S("End of list (matching biomes found: @1)", count))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_dump_biome.init()

    return {
        description = "Chat command /dump_biome",
        notes = "Dumps definitions of biomes with a matching name",
    }

end

function unilib.pkg.chat_dump_biome.exec()

    core.register_chatcommand("dump_biome", {
        params = "<pattern>",
        description = S("Dumps biome definitions for any biome whose name matches the pattern"),
        privs = {unilib_admin = true},

        func = function(name, param)
            return do_dump_biome(name, param)
        end,
    })

end
