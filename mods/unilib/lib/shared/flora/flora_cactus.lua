---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- flora_cactus.lua
--      Cactus growth callbacks
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Cactus growth callbacks
---------------------------------------------------------------------------------------------------

function unilib.flora._grow_cactus(pos, node)

    -- Adapted from default/functions.lua
    -- Called from the ABM in the "abm_standard_cactus_grow" package, and also as the grow function
    --      for calls from any package to unilib.fertiliser.register_special()
    -- Causes a single-node cactus to grow upwards

    -- e.g. "unilib:plant_cactus_ordinary"
    local cactus_name = node.name

    if node.param2 >= 4 then
        return
    end

    pos.y = pos.y - 1
    if core.get_item_group(core.get_node(pos).name, "sand") == 0 then
        return
    end

    pos.y = pos.y + 1
    local height = 0
    while node.name == cactus_name and height < 4 do

        height = height + 1
        pos.y = pos.y + 1
        node = core.get_node(pos)

    end

    if height == 4 or node.name ~= "air" then
        return
    end

    if core.get_node_light(pos) < unilib.constant.light_min_grow_sapling then
        return
    end

    core.set_node(pos, {name = cactus_name})
    return true

end
