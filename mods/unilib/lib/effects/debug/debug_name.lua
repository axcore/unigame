---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- debug_name.lua
--      Add node/craftitem/tool's full_name to its description, so it's visible in the player
--          inventory
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Add node/craftitem/tool's full_name to its description, so it's visible in the player inventory

core.register_on_mods_loaded(function()

    local rgb = "#b10000"

    for _, def_table in pairs(core.registered_nodes) do

        if def_table.description ~= nil then

            def_table.description =
                    core.colorize(rgb, def_table.name) .. "\n" .. def_table.description

        end

    end

    for _, def_table in pairs(core.registered_craftitems) do

        if def_table.description ~= nil then

            def_table.description =
                    core.colorize(rgb, def_table.name) .. "\n" .. def_table.description

        end

    end

    for _, def_table in pairs(core.registered_tools) do

        if def_table.description ~= nil then

            def_table.description =
                    core.colorize(rgb, def_table.name) .. "\n" .. def_table.description

        end

    end

end)
