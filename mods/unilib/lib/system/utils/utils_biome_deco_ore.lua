---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- utils_biome_deco_ore.lua
--      Biome/decoration/ore utility functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.utils._check_heights(y_max, y_min)

    -- Unique to unilib
    -- Call by biome/decoration/ore registration code to check that two values for a maximum/
    --      minimum height are valid
    -- Either or both of the arguments may be nil; this is considered a valid value
    -- Returns true for valid (or nil) values; false for any invalid value

    if (y_max ~= nil and y_max > unilib.constant.y_max) or
            (y_min ~= nil and y_min < unilib.constant.y_min) or
            (y_max ~= nil and y_min ~= nil and y_max < y_min) then
        return false
    else
        return true
    end

end

function unilib.utils._get_height_constants()

    -- Called by ..lib/system/read/read_csv_remix.lua, or by any other code which wants to read a
    --      "constant.csv" file in ../csv/remixes

    return {
        X_MAX = unilib.constant.x_max,
        X_MIN = unilib.constant.x_min,
        Y_MAX = unilib.constant.y_max,
        Y_MIN = unilib.constant.y_min,
        Z_MAX = unilib.constant.z_max,
        Z_MIN = unilib.constant.z_min,
    }

end

function unilib.utils._get_unique_deco_name(deco_name)

    -- Avoid duplicate decoration names, otherwise this decoration will overwrite a previously-
    --      defined decoration
    -- In schematic decorations, also replaces the opening "unilib_" with "unilib:", for consistency
    --      with simple decorations
    --
    -- Optional args:
    --      deco_name (str or nil): The decoration's proposed name. If not specified, a generic
    --          name is used
    --
    -- Return values:
    --      Returns "deco_name" unmodified if it's available, otherwise returns a name in the form
    --          deco_name_alt_N

    if deco_name == nil or deco_name == "" then
        deco_name = "nameless"
    end

    -- "simple" decorations tend to be in the form "unilib:xxx", whereas schematics tend to be in
    --      the form "unilib_xxx". Switch out the underline for consistency
    deco_name = string.gsub(deco_name, "^unilib_", "unilib:")

    if core.registered_decorations[deco_name] == nil and
            unilib.global.deco_name_check_table[deco_name] == nil then
        return deco_name
    end

    local count = 1
    while(true) do

        count = count + 1
        local alt_name = deco_name .. "_alt_" .. tostring(count)
        if core.registered_decorations[alt_name] == nil and
                unilib.global.deco_name_check_table[alt_name] == nil then
            return alt_name
        end

    end

end
