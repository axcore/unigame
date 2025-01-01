---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stairs_extract.lua
--      Stair name extraction functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Stair name extraction functions
---------------------------------------------------------------------------------------------------

function unilib.stairs._extract_stair_type(adj_full_name)

    -- Original to unilib
    -- Returns the stair type (a key in unilib.global.stair_cost_table)
    --
    -- Args:
    --      adj_full_name (str): A stair node created by this file, e.g.
    --          "unilib:stone_ordinary_stair_simple"
    --
    -- Return values:
    --      The stair type, e.g. "_stair_simple", or an empty string if it's not a stair node

    -- Get the node from which the stair was constructed. e.g. "unilib:stone_ordinary"
    local full_name = unilib.global.stair_deconvert_table[adj_full_name]

    -- Extract the stair type
    if full_name == nil then
        return ""
    else
        return string.sub(adj_full_name, (#full_name + 1), -1)
    end

end

function unilib.stairs._extract_category(adj_full_name)

    -- Original to unilib
    -- Returns the stair category (the second component of the stair type, i.e. one of the strings
    --      "simple", "corner", "inner", "outer", "slab", "tile", "panel", "micro", "box", "slope"
    --      or "steps"
    --
    -- Args:
    --      adj_full_name (str): A stair node created by this file, e.g.
    --          "unilib:stone_ordinary_stair_simple"
    --
    -- Return values:
    --      The stair category, or an empty string if it's not a stair node

    -- Get the node from which the stair was constructed. e.g. "unilib:stone_ordinary"
    local full_name = unilib.global.stair_deconvert_table[adj_full_name]

    -- Extract the stair category
    if full_name == nil then

        return ""

    else

        -- The stair type is in the form "_stair_CATEGORY_component_component..."
        local stair_category = string.sub(adj_full_name, (#full_name + 8), -1)
        local pos = stair_category:find("_") or 0
        if pos == 0 then

            -- e.g. stair type is "_stair_simple", so after "_stair_" there are no underlines to
            --      find
            return stair_category

        else

            -- e.g. stair type is "_micro_bottom_cut_eighth"
            return string.sub(stair_category, 1, pos - 1)
        end

    end

end
