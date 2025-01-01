---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- utils_csv_input_output.lua
--      CSV input/output utility functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.utils._get_remix_dir(remix_name)

    -- Original to unilib
    -- This function should be called before any call to unilib.utils.read_csv() or
    --      unilib.utils.write_csv(), when the CSV file is in a remix directory
    -- It returns the actual directory for the remix (as specified by unilib.global.remix_dir_table)
    --      or, if none is specified, the default location for that directory (i.e. in unilib's
    --      ../csv/remixes folder)
    -- It's up to the calling code to check that the path to the CSV file actually exists, before
    --      trying to read it
    --
    -- Args:
    --      remix_name (str): e.g. "chat"
    --
    -- Return values:
    --      A folder path (real or hypothetical)

    if unilib.global.remix_dir_table[remix_name] ~= nil then
        return unilib.global.remix_dir_table[remix_name]
    else
        return unilib.core.path_mod .. "/csv/remixes/" .. remix_name
    end

end

function unilib.utils._read_csv(path, separator)

    -- Adapted from code in various mods, written by Gael-de-Sailly
    -- Reads an arbitrary CSV file, returning its contents as a table
    --
    -- Args:
    --      path (str): The file path to read
    --
    -- Optional args:
    --      separator (str or nil): Any separator may be specified, but unilib uses the | character
    --          as standard. If not specified, then the standard separator is used
    --
    -- Return values
    --      line_table (table): The file's data arranged in a table, one line per item

    if separator == nil then
        separator = unilib.constant.separator
    end

    local file = io.open(path, "r")
    local line_table = {}
    local check_table = {}

    for line in file:lines() do

        -- Strip trailing newline/whitespace characters
        local adj_line = line:gsub("[ \t\r\n]+$", "")

        -- So that error messages can display the correct line number, any ignorable line is
        --      represented by an empty table
        if adj_line:sub(1, 1) ~= "#" and adj_line:find("[^%" .. separator .. "% ]") then

            table.insert(line_table, adj_line:split(separator, true))
            if unilib.setting.debug_warn_duplicate_line_flag then

                if check_table[adj_line] ~= nil then

                    unilib.utils.show_warning(
                        "unilib.utils.read_csv(): Duplicate line in CSV",
                        path,
                        check_table[adj_line],
                        #line_table
                    )

                else

                    check_table[adj_line] = #line_table

                end

            end

        else

            table.insert(line_table, {})

        end

    end

    return line_table

end

function unilib.utils._write_csv(path, separator, line_list)

    -- Original to unilib
    -- Writes a CSV file, automatically inserting a newline character after each line
    -- N.B. This function does not check the file was written correctly
    --
    -- Args:
    --      path (str): The file path to write
    --
    -- Optional args:
    --      separator (str or nil): Any separator may be specified, but unilib uses the | character
    --          as standard. If not specified, then the standard separator is used

    if separator == nil then
        separator = unilib.constant.separator
    end

    local file = io.open(path, "w")

    for _, line in ipairs(line_list) do
        file:write(line .. "\n")
    end

    file:close(file)

end
