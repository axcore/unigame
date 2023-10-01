---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- debug.lua
--      Set up miscellaneous debug effects (original to unilib)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Make all nodes/craftitems/tools visible in creative inventory
---------------------------------------------------------------------------------------------------

if unilib.debug_all_inventory_flag then

    minetest.register_on_mods_loaded(function()

        for _, def_table in pairs(minetest.registered_nodes) do

            if def_table.groups ~= nil then
                def_table.groups.not_in_creative_inventory = nil
            end

        end

        for _, def_table in pairs(minetest.registered_craftitems) do

            if def_table.groups ~= nil then
                def_table.groups.not_in_creative_inventory = nil
            end

        end

        for _, def_table in pairs(minetest.registered_tools) do

            if def_table.groups ~= nil then
                def_table.groups.not_in_creative_inventory = nil
            end

        end

    end)

end

---------------------------------------------------------------------------------------------------
-- Add node/craftitem/tool's original name to its description, so it's visible in player inventory
---------------------------------------------------------------------------------------------------

if unilib.debug_add_orig_name_flag then

    minetest.register_on_mods_loaded(function()

        local rgb = "#ffbb00"

        for orig_name, full_name in pairs(unilib.node_convert_table) do

            local def_table = minetest.registered_nodes[full_name]
            if orig_name ~= nil and orig_name ~= "" and def_table.description ~= nil then

                def_table.description = minetest.colorize(rgb, orig_name) .. "\n" ..
                        def_table.description

            end

        end

        for orig_name, full_name in pairs(unilib.craftitem_convert_table) do

            local def_table = minetest.registered_craftitems[full_name]
            if orig_name ~= nil and orig_name ~= "" and def_table.description ~= nil then

                def_table.description = minetest.colorize(rgb, orig_name) .. "\n" ..
                        def_table.description

            end

        end

        for orig_name, full_name in pairs(unilib.tool_convert_table) do

            local def_table = minetest.registered_tools[full_name]
            if orig_name ~= nil and orig_name ~= "" and def_table.description ~= nil then

                def_table.description = minetest.colorize(rgb, orig_name) .. "\n" ..
                        def_table.description

            end

        end

    end)

end

---------------------------------------------------------------------------------------------------
-- Add node/craftitem/tool's full_name to its description, so it's visible in the player inventory
---------------------------------------------------------------------------------------------------

if unilib.debug_add_name_flag then

    minetest.register_on_mods_loaded(function()

        local rgb = "#b10000"

        for _, def_table in pairs(minetest.registered_nodes) do

            if def_table.description ~= nil then

                def_table.description = minetest.colorize(rgb, def_table.name) .. "\n" ..
                        def_table.description

            end

        end

        for _, def_table in pairs(minetest.registered_craftitems) do

            if def_table.description ~= nil then

                def_table.description = minetest.colorize(rgb, def_table.name) .. "\n" ..
                        def_table.description

            end

        end

        for _, def_table in pairs(minetest.registered_tools) do

            if def_table.description ~= nil then

                def_table.description = minetest.colorize(rgb, def_table.name) .. "\n" ..
                        def_table.description

            end

        end

    end)

end

---------------------------------------------------------------------------------------------------
-- Tweak all nodes to emit light
---------------------------------------------------------------------------------------------------

if unilib.debug_force_light_source > 0 then

    minetest.register_on_mods_loaded(function()

        for full_name, def_table in pairs(minetest.registered_nodes) do

            if def_table.light_source == nil or
                    def_table.light_source < unilib.debug_force_light_source then
                unilib.override_item(full_name, {light_source = unilib.debug_force_light_source})
            end

        end

    end)

end

---------------------------------------------------------------------------------------------------
-- Make stone nodes transparent, and disable falling nodes
---------------------------------------------------------------------------------------------------

if unilib.debug_xray_flag then

    -- Code adapted from simple_xray mod

    -- Make stone nodes transparent
    for part_name, _ in pairs(unilib.stone_table) do

        local full_name = "unilib:stone_" .. part_name
        if minetest.registered_nodes[full_name] ~= nil then

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
    for full_name, def_table in pairs(minetest.registered_nodes) do

        if def_table.groups ~= nil and def_table.groups.falling_node ~= nil then

            local group_table = table.copy(def_table.groups)
            group_table.falling_node = 0
            unilib.override_item(full_name, {groups = group_table})

        end

    end

end
