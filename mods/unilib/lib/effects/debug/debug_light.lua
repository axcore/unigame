---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- debug_light.lua
--      Tweak all nodes to emit light
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Tweak all nodes to emit light

core.register_on_mods_loaded(function()

    for full_name, def_table in pairs(core.registered_nodes) do

        if def_table.light_source == nil or
                def_table.light_source < unilib.setting.debug_force_light_source then

            unilib.override_item(
                full_name, {light_source = unilib.setting.debug_force_light_source}
            )

        end

    end

end)
