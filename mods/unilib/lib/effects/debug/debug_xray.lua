---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- debug_xray.lua
--      Make stone nodes transparent, and disable falling nodes. Code adapted from simple_xray mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Make stone nodes (and all registered matrix stones) transparent
local override_list = {}

for _, full_name in pairs(unilib.global.matrix_stone_list) do
    table.insert(override_list, full_name)
end

for part_name, _ in pairs(unilib.global.stone_table) do
    table.insert(override_list, "unilib:stone_" .. part_name)
end

for _, full_name in pairs(override_list) do

    if core.registered_nodes[full_name] ~= nil then

        unilib.override_item(full_name, {
            buildable_to = true,
            drawtype = "airlike",
            paramtype = "light",
            pointable = false,
            post_effect_color = {r = 0, g = 128, b = 0, a = 30},
            sunlight_propagates = true,
            walkable = false,
        })

    end

end

-- Disable falling nodes
for full_name, def_table in pairs(core.registered_nodes) do

    if def_table.groups ~= nil and def_table.groups.falling_node ~= nil then

        local group_table = table.copy(def_table.groups)
        group_table.falling_node = 0
        unilib.override_item(full_name, {groups = group_table})

    end

end
