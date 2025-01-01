---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- flora_papyrus.lua
--      Papyrus growth callbacks
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Papyrus growth callbacks
---------------------------------------------------------------------------------------------------

function unilib.flora._grow_papyrus(pos, node)

    -- Adapted from default/functions.lua
    -- Called from the ABM in the "abm_standard_papyrus_grow" package, and also as the grow function
    --      for calls from any package to unilib.fertiliser.register_special()
    -- Causes a single-node papyrus to grow upwards

    -- e.g. "unilib:plant_papyrus_ordinary"
    local papyrus_name = node.name

    pos.y = pos.y - 1
    if unilib.global.pkg_executed_table["abm_standard_papyrus_grow"] ~= nil then

        local neighbour_name = core.get_node(pos).name
        if unilib.pkg.abm_standard_papyrus_grow.neighbour_table[neighbour_name] == nil then
            return
        end

    end

    if not core.find_node_near(pos, 3, {"group:water"}) then
        return
    end

    pos.y = pos.y + 1
    local height = 0
    while node.name == papyrus_name and height < 4 do

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

    core.set_node(pos, {name = papyrus_name})
    return true

end
