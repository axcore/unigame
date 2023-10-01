---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- cactus.lua
--      Set up shared functions for cactus plants
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.grow_cactus_callback(pos, node)

    -- Adapted from default/functions.lua
    -- Called from the ABM in ../shared/abms.lua, causing a single-node cactus to grow upwards

    -- Notes from default:
    -- Wrapping the function in ABM action is necessary to make overriding them possible

    -- e.g. "unilib:plant_cactus_ordinary"
    local full_name = node.name

    if node.param2 >= 4 then
        return
    end

    pos.y = pos.y - 1
    if minetest.get_item_group(minetest.get_node(pos).name, "sand") == 0 then
        return
    end

    pos.y = pos.y + 1
    local height = 0
    while node.name == full_name and height < 4 do

        height = height + 1
        pos.y = pos.y + 1
        node = minetest.get_node(pos)

    end

    if height == 4 or node.name ~= "air" then
        return
    end

    if minetest.get_node_light(pos) < unilib.light_min_grow_sapling then
        return
    end

    minetest.set_node(pos, {name = full_name})
    return true

end

