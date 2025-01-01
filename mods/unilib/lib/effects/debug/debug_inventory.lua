---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- debug_inventory.lua
--      Make all nodes/craftitems/tools visible in creative inventory
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Make all nodes/craftitems/tools visible in creative inventory
core.register_on_mods_loaded(function()

    for _, def_table in pairs(core.registered_nodes) do

        if def_table.groups ~= nil then
            def_table.groups.not_in_creative_inventory = nil
        end

    end

    for _, def_table in pairs(core.registered_craftitems) do

        if def_table.groups ~= nil then
            def_table.groups.not_in_creative_inventory = nil
        end

    end

    for _, def_table in pairs(core.registered_tools) do

        if def_table.groups ~= nil then
            def_table.groups.not_in_creative_inventory = nil
        end

    end

end)
