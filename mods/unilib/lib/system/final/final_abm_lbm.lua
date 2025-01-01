---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- final_abm_lbm.lua
--      Disable obsolete minetest_game ABMs/LBMs
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Disable obsolete minetest_game ABMs/LBMs
---------------------------------------------------------------------------------------------------

core.after(0, function()

    for _, data_table in pairs(unilib.global.obsolete_abm_list) do

        -- (No point checking the entire ABM list, if the original mod isn't even loaded)
        if core.get_modpath(data_table.mod_origin) then

            for _, def_table in pairs(core.registered_abms) do

                if data_table.mod_origin == def_table.mod_origin and (
                    (data_table.name ~= nil and data_table.name == def_table.name) or
                    (data_table.label ~= nil and data_table.label == def_table.label)
                ) then

                    def_table.action = function(...) end
                    break

                end

            end

        end

    end

    for _, data_table in pairs(unilib.global.obsolete_lbm_list) do

        -- (No point checking the entire ABM list, if the original mod isn't even loaded)
        if core.get_modpath(data_table.mod_origin) then

            for _, def_table in pairs(core.registered_lbms) do

                if data_table.mod_origin == def_table.mod_origin and (
                    (data_table.name ~= nil and data_table.name == def_table.name) or
                    (data_table.label ~= nil and data_table.label == def_table.label)
                ) then

                    def_table.action = function(...) end
                    break

                end

            end

        end

    end

end)
