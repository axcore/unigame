---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- utils_description_infotext.lua
--      Description/infotext utility functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.utils._annotate(text, extra, hint)

    -- Code adapted from aotearoa
    -- Call this function to modify some uncolourised text, by adding add a scientific name (in
    --      a standard colour, and on a separate line) and/or by adding a hint (in another standard
    --      colour, on another separate line)
    --
    -- Args:
    --      text (str): The main text to display
    --
    -- Optional args:
    --      extra (str or nil): This string, if specified, should follow the normal rules for
    --          scientific capitalisation, e.g. "Populus tremula"
    --      hint (str or nil): Text to display below the other arguments, if specified

    if extra ~= nil then
        text = text .. "\n" .. core.colorize("#ADABA0", "(" .. extra .. ")")
    end

    if hint ~= nil then
        text = text .. "\n" .. core.colorize("#2222AD", hint)
    end

    return text

end

function unilib.utils._brackets(text, extra)

    -- Original to unilib
    -- Call this function to append some text, in brackets
    -- Stylistic considerations: both "text" and "extra" should be capitalised, e.g.
    --      "Door", "Open"
    -- (Exception: for stairs and carvings, only the first word of "extra" is usually capitalised)
    -- (Exception: a mod or package name need not be capitalised)

    if extra == nil then
        return text
    else
        return text .. " (" .. extra .. ")"
    end

end

function unilib.utils._emphasise(extra)

    -- Original to unilib
    -- Call this function to colourise some text in bright yellow (thus "emphasising" it)

    if extra == nil then
        return extra
    else
        return core.colorize("#FFFF00", extra)
    end

end

function unilib.utils._hint(text, extra)

    -- Original to unilib
    -- Call this function to modify some uncolourised text, by adding add a hint (in a standard
    --      colour, and on a new line)
    -- Stylistic considerations: "text" should be capitalised, but "extra" should be in mostly
    --      lower-case

    if extra == nil then
        return text
    else
        return text .. "\n" .. core.colorize("#006633", "(" .. extra .. ")")
    end

end
