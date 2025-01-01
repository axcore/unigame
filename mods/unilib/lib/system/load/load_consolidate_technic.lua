---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- load_consolidate.lua
--      Execute consolidation code before package .post() functions are called
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Call technic to create any requested grinder recipes (adapted from gravelcraft/init.lua)
for part_name, data_table in pairs(unilib.global.stone_table) do

    if data_table.grinder_flag == true then

        local smooth_name = "unilib:stone_" .. part_name
        local cobble_name = "unilib:stone_" .. part_name .. "_cobble"
        local compressed_name = "unilib:stone_" .. part_name .. "_cobble_compressed"

        if core.registered_nodes[smooth_name] ~= nil then

            if data_table.grinder_powder ~= nil and
                    core.registered_nodes[data_table.grinder_powder] ~= nil then

                technic.register_grinder_recipe({
                    output = data_table.grinder_powder .. " " ..
                            tostring(unilib.setting.technic_grind_stone_ratio),
                    input = {smooth_name},
                })

            elseif core.registered_nodes["unilib:stone_ordinary_powder"] ~= nil then

                technic.register_grinder_recipe({
                    output = "unilib:stone_ordinary_powder " ..
                            tostring(unilib.setting.technic_grind_stone_ratio),
                    input = {smooth_name},
                })

            end

        end

        if core.registered_nodes[cobble_name] ~= nil then

            if data_table.grinder_gravel ~= nil and
                    core.registered_nodes[data_table.grinder_gravel] ~= nil then

                technic.register_grinder_recipe({
                    output = data_table.grinder_gravel,
                    input = {cobble_name},
                })

            elseif core.registered_nodes["unilib:gravel_ordinary"] ~= nil then

                technic.register_grinder_recipe({
                    output = "unilib:gravel_ordinary",
                    input = {cobble_name},
                })

            end

        end

        if core.registered_nodes[compressed_name] ~= nil then

            if data_table.grinder_gravel ~= nil and
                    core.registered_nodes[data_table.grinder_gravel] ~= nil then

                technic.register_grinder_recipe({
                    output = data_table.grinder_gravel .. " 9",
                    input = {compressed_name},
                })

            elseif core.registered_nodes["unilib:gravel_ordinary"] ~= nil then

                technic.register_grinder_recipe({
                    output = "unilib:gravel_ordinary 9",
                    input = {compressed_name},
                })

            end

        end

    end

end
