---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- utils_numeric_string.lua
--      Numeric/string utility functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.utils._contract_long_lines(arg, max_length)

    -- arg is a long string, possible including newline characters
    -- This function reduces the length of each "line" in the string, replacing the missing text
    --      with an ellipsis

    if max_length == nil or max_length < 4 then
        max_length = 40
    end

    local line_list = {}

    for line in string.gmatch(arg, "([^\n]+)") do

        if string.len(line) <= max_length then
            table.insert(line_list, line)
        else
            table.insert(line_list, string.sub(line, 1, (max_length - 3)) .. "...")
        end

    end

    return table.concat(line_list, "\n")

end

function unilib.utils._first_to_upper(arg)

    return (arg:gsub("^%l", string.upper))

end

function unilib.utils._get_first_line(arg)

    local result = string.match(arg, "^[^\n]+")
    if result then
        return result
    else
        return arg
    end

end

function unilib.utils._reduce_lines(arg, line_count, ellipsis_flag)

    -- Sanity check
    if line_count < 0 then
        return arg
    end

    -- Remove lines beyond the specified line_count; also remove empty lines
    local line_list = {}
    for line in string.gmatch(arg, "[^\r\n]+") do

        table.insert(line_list, line)
        if #line_list >= line_count then

            if ellipsis_flag then
                table.insert(line_list, "...")
            end

            break

        end

    end

    return table.concat(line_list, "\n")

end

function unilib.utils._round_up(num, dp)

    -- Adapted from
    --      https://stackoverflow.com/questions/57950030/wow-rounding-to-two-decimal-places-in-lua
    -- Rounds up a number
    --
    -- Args:
    --      num (float): The number to round up
    --      dp (int): Can be negative, e.g. -1 rounds the number to the nearest 10

    local mult = 10 ^ (dp or 0)
    return math.floor((num * mult) + 0.5) / mult

end

function unilib.utils._split_string_by_underline(arg, no_duplicate_flag)

    -- Modified version of unilib.utils.split_string_by_whitespace(), splitting a string by
    --      underlines (underscores)
    --
    -- Args:
    --      arg (str): The string to split
    --      no_duplicate_flag (bool): If true, duplicate words are eliminated
    --
    -- Return values:
    --      The list of words (which may be empty)

    local list = {}
    local check_table = {}

    -- Sanity check
    if arg == nil or arg == "" then
        return list
    end

    -- Strip leading/trailing whitespace...
    arg = unilib.utils.strip_whitespace(arg)
    -- ... then split the string by intermediate whitespace
    for word in string.gmatch(arg, "[^_]+") do

        if not no_duplicate_flag or check_table[word] == nil then

            table.insert(list, word)
            check_table[word] = ""

        end

    end

    return list

end

function unilib.utils._split_string_by_whitespace(arg, no_duplicate_flag)

    -- Splits a string into a list. Each item in the return list is a single word
    -- Text like "stone_ordinary" counts as a single word, but "stone ordinary" counts as two
    -- If the string is nil or an empty string, returns an empty list
    --
    -- Args:
    --      arg (str): The string to split
    --      no_duplicate_flag (bool): If true, duplicate words are eliminated
    --
    -- Return values:
    --      The list of words (which may be empty)

    local list = {}
    local check_table = {}

    -- Sanity check
    if arg == nil or arg == "" then
        return list
    elseif type(arg) ~= "string" then
        return arg
    end

    -- Strip leading/trailing whitespace...
    arg = unilib.utils.strip_whitespace(arg)
    -- ... then split the string by intermediate whitespace
    for word in string.gmatch(arg, "%S+") do

        if not no_duplicate_flag or check_table[word] == nil then

            table.insert(list, word)
            check_table[word] = ""

        end

    end

    return list

end

function unilib.utils._strip_whitespace(arg)

    arg = arg:gsub("^%s+", "")
    arg = arg:gsub("%s+$", "")
    return arg

end
