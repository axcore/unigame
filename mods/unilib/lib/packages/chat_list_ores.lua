---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_ores = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function find_match(param, data)

    -- Original to unilib
    -- Looks for param in data, which might be a string or a list. Returns true if a match is found,
    --      false if not
    -- Since this is a local function, we can assume that "data" is a list-table, not a key-value
    --      table

    if type(data) == "string" then

        if param == data then
            return true
        else
            return false
        end

    elseif type(data) == "table" then

        for _, v in ipairs(data) do

            if v == param then
                return true
            end

        end

    end

    return false

end

local function compile_string(data)

    -- Original to unilib
    -- Compiles a string from data, which might be a string or a list
    -- Since this is a local function, we can assume that "data" is a list-table, not a key-value
    --      table

    if type(data) == "string" then

        return data

    elseif type(data) == "table" then

        return table.concat(data, ", ")

    else

        return ""

    end

end

local function do_list_ores(pname, param)

    local description_list = {}
    local count = 0
    local param_num = tonumber(param)

    for k, ore_table in pairs(core.registered_ores) do

        local mod_name = string.split(ore_table.ore, ":")[1]

        if param == "" or
                param == ore_table.ore_type or
                param == mod_name or
                param == ore_table.ore or
                find_match(param, ore_table.wherein) or
                find_match(param, ore_table.biomes) or
                (
                    type(param_num) == "number" and param_num <= ore_table.y_max and
                    param_num >= ore_table.y_min
                ) then

            table.insert(
                description_list,
                mod_name .. " - [" .. ore_table.ore_type .. "] " .. ore_table.ore ..
                        "\n      In: " .. compile_string(ore_table.wherein) ..
                        "\n      Biomes: " .. compile_string(ore_table.biomes) ..
                        "\n      Pos: max " .. tostring(ore_table.y_max) .. " min " ..
                        tostring(ore_table.y_min)
            )

            count = count + 1

        end

    end

    if count == 0 then

        if param == "" then
            return false, S("No ores are registered")
        else
            return false, S("No ores matching \"@1\"", param)
        end

    else

        if param == "" then
            unilib.utils.chat_send_player(pname, S("Registered ores"))
        else
            unilib.utils.chat_send_player(pname, S("Registered ores matching \"@1\"", param))
        end

        table.sort(description_list)
        for _, description in ipairs(description_list) do
            unilib.utils.chat_send_player(pname, "   " .. description)
        end

        unilib.utils.chat_send_player(pname, S("End of list (ores found: @1)", count))

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_ores.init()

    return {
        description = "Chat commands /list_ores, /list_ore",
        notes = "Lists all registered ores, or just ores of the specified type/mod/node/biome",
    }

end

function unilib.pkg.chat_list_ores.exec()

    core.register_chatcommand("list_ores", {
        params = "[matching_text]",
        description = S(
            "Lists all registered ores, or just ores of the specified type (stratum, etc), from" ..
                    " the specified mod, or matching the specified node/biome, or at the" ..
                    " specified height"
        ),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_ores(name, param)
        end,
    })

    core.register_chatcommand("list_ore", {
        params = "[matching_text]",
        description = S(
            "Lists all registered ores, or just ores of the specified type (stratum, etc), from" ..
                    " the specified mod, or matching the specified node/biome, or at the" ..
                    " specified height"
        ),
        privs = {unilib_tools = true},

        func = function(name, param)
            return do_list_ores(name, param)
        end,
    })

end
