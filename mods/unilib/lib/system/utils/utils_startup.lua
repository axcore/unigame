---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- utility_startup.lua
--      Startup utility functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.utils._get_startup_biome_msg()

    -- Produces a message, used by init.lua, to show the number of biomes specified by each remix
    --      in their optional biome CSVs
    --
    -- Return values:
    --      The message to display in the chat window (an empty string if no biome tables were
    --          loaded)

    local msg = ""

    for _, remix_name in ipairs(unilib.global.init_remix_list) do

        if unilib.global.remix_biome_count_table[remix_name] ~= nil then

            msg = msg .. " " .. remix_name .. " "
            msg = msg .. "[" .. tostring(unilib.global.remix_biome_count_table[remix_name]) .. "]"

        end

    end

    return msg

end

function unilib.utils._get_startup_deco_msg()

    -- Produces a message, used by init.lua, to show the number of decorations specified by each
    --      remix in their optional decoration CSVs
    --
    -- Return values:
    --      The message to display in the chat window (an empty string if no decoration tables were
    --          loaded)

    local msg = ""

    for _, remix_name in ipairs(unilib.global.init_remix_list) do

        if unilib.global.remix_deco_count_table[remix_name] ~= nil then

            msg = msg .. " " .. remix_name .. " "
            msg = msg .. "[" .. tostring(unilib.global.remix_deco_count_table[remix_name]) .. "]"

        end

    end

    return msg

end

function unilib.utils._get_startup_expansion_msg()

    -- Produces a message, used by init.lua, to show the number of expansion packs detected
    --
    -- Return values:
    --      The message to display in the chat window (an empty string if no expansion packs were
    --          detected)

    local msg = ""

    for _, ext_name in ipairs(unilib.global.ext_pack_list) do
        msg = msg .. " " .. ext_name
    end

    return msg

end

function unilib.utils._get_startup_ore_msg()

    -- Produces a message, used by init.lua, to show the number of ore specified by each remix in
    --      their optional ore CSVs
    --
    -- Return values:
    --      The message to display in the chat window (an empty string if no ore tables were loaded)

    local msg = ""

    for _, remix_name in ipairs(unilib.global.init_remix_list) do

        if unilib.global.remix_ore_count_table[remix_name] ~= nil then

            msg = msg .. " " .. remix_name .. " "
            msg = msg .. "[" .. tostring(unilib.global.remix_ore_count_table[remix_name]) .. "]"

        end

    end

    return msg

end

function unilib.utils._get_startup_pkg_msg()

    -- Produces a message, used by init.lua, to show the number of packages specified by each remix
    --
    -- Return values:
    --      The message to display in the chat window (an empty string if no remixes found)

    local msg = ""

    for _, remix_name in ipairs(unilib.global.init_remix_list) do

        msg = msg .. " " .. remix_name .. " "
        msg = msg .. "[" .. tostring(unilib.global.remix_pkg_count_table[remix_name]) .. "]"

    end

    return msg

end
