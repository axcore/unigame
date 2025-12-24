---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- kitz_maths.lua
--      Shared API functions from the petz/kitz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local ceil = math.ceil
local floor = math.floor

---------------------------------------------------------------------------------------------------
-- Shared API functions (general) (from petz/kitz/api/api_math.lua)
---------------------------------------------------------------------------------------------------

function unimobs.kitz_api.delimit_number(number, range_table)

    -- Was kitz.delimit_number()
    -- Returns "number" adjusted to lie within the minimum/maximum values specified by "range_table"
    -- The format of "range_table" is
    --      {min = 1, max = 99}

    if not tonumber(number) then
        return nil
    end

    if number < range_table.min then
        number = range_table.min
    elseif number > range_table.max then
        number = range_table.max
    end

    return number

end

function unimobs.kitz_api.round_number(x)

    -- Was kitz.round()
    -- Return the specified value, rounded down (for positive numbers), or rounded up (for negative
    --      numbers)

    return x >= 0 and floor(x + 0.5) or ceil(x - 0.5)

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (trigonometric) (from petz/kitz/api/api_math.lua)
---------------------------------------------------------------------------------------------------

function unimobs.kitz_api.convert_degrees_to_radians(degrees)

    -- Was kitz.degrees_to_radians()
    -- Converts degrees to radians

    return(degrees / 180.0 * math.pi)

end

function unimobs.kitz_api.convert_radians_to_degrees(radians)

    -- Was kitz.radians_to_degrees()
    -- Converts radians to degrees

    return(radians * 180.0 / math.pi)

end

function unimobs.kitz_api.convert_yaw_to_degrees(yaw)

    -- Was kitz.degrees(), kitz.yaw_to_degrees()
    -- Converts yaw to degrees

    return(yaw * 180.0 / math.pi)

end

function unimobs.kitz_api.round_degrees(degree)

    -- Was kitz.degree_round()
    -- Returns "degree" rounded up to an integer

    return(degree + 0.5 - (degree + 0.5) % 1)

end
