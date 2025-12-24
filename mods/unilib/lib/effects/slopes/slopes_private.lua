---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- slopes_private.lua
--      Set up natural slopes. Code adapted from the "naturalslopeslib" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Private functions (from naturalslopeslib/init.lua)
---------------------------------------------------------------------------------------------------

function unilib.slopes.get_straight_slope_name(item_name)

    -- Was naturalslopeslib.get_straight_slope_name()
    -- Get the name of a slope node from the corresponding base (block) node's item name. For
    --      example, "unilib:dirt_ordinary" will be converted to "unilib:slope_dirt_ordinary" (and
    --      "default:dirt" from minetest_game would be converted to "unilib:slope_dirt"
    -- See unilib.slopes.get_all_shapes() to get a list of slope names for a single (block) node

    return core.get_current_modname() .. ":slope_" .. item_name

end

function unilib.slopes.get_inner_corner_slope_name(item_name)

    -- Was naturalslopeslib.get_inner_corner_slope_name()

    return core.get_current_modname() .. ":slope_inner_" .. item_name

end

function unilib.slopes.get_outer_corner_slope_name(item_name)

    -- Was naturalslopeslib.get_outer_corner_slope_name()

    return core.get_current_modname() .. ":slope_outer_" .. item_name

end

function unilib.slopes.get_pike_slope_name(item_name)

    -- Was naturalslopeslib.get_pike_slope_name()

    return core.get_current_modname() .. ":slope_pike_" .. item_name

end
