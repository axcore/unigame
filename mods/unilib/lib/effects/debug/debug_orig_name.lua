---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- debug_orig_name.lua
--      Add node/craftitem/tool's original name to its description, so it's visible in player
--          inventory
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Add node/craftitem/tool's original name to its description, so it's visible in player inventory

core.register_on_mods_loaded(function()

    local rgb = "#ffbb00"

    for orig_name, full_name in pairs(unilib.global.node_convert_table) do

        local def_table = core.registered_nodes[full_name]
        if def_table ~= nil and
                orig_name ~= nil and
                orig_name ~= "" and
                def_table.description ~= nil then
            def_table.description = core.colorize(rgb, orig_name) .. "\n" .. def_table.description
        end

    end

    for orig_name, full_name in pairs(unilib.global.craftitem_convert_table) do

        local def_table = core.registered_craftitems[full_name]
        if def_table ~= nil and
                orig_name ~= nil and
                orig_name ~= "" and
                def_table.description ~= nil then
            def_table.description = core.colorize(rgb, orig_name) .. "\n" .. def_table.description
        end

    end

    for orig_name, full_name in pairs(unilib.global.tool_convert_table) do

        local def_table = core.registered_tools[full_name]
        if def_table ~= nil and
                orig_name ~= nil and
                orig_name ~= "" and
                def_table.description ~= nil then
            def_table.description = core.colorize(rgb, orig_name) .. "\n" .. def_table.description
        end

    end

end)
