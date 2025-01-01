---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- flora_support.lua
--      Flora support functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Set up 3d-rendered leaves (when in inventory or wielded)
---------------------------------------------------------------------------------------------------

function unilib.flora._filter_leaves_img(img)

    if not unilib.setting.rendered_leaves_flag then
        return img
    else
        return nil
    end

end

---------------------------------------------------------------------------------------------------
-- Update sapling growth requirements
---------------------------------------------------------------------------------------------------

function unilib.flora._update_sapling_growth_requirements()

    -- Called by ../lib/system/load/ during its finalisation phase
    -- Some saplings require specific node(s) on which to grow. If the Minetest setting is enabled,
    --      update these requirements to remove any nodes which have not been loaded
    -- N.B. The related Minetest setting, unilib.setting.sapling_everywhere_flag, is handled
    --      elsewhere

    for full_name, data_table in pairs(unilib.global.sapling_table) do

        -- When a package specifies an empty list, the sapling cannot grow on anything. If
        --      .under_list is nil, it can grow on anything in the "soil" group (including most
        --      dirts). In both cases, we don't interfer
        if data_table.under_list ~= nil and #data_table.under_list > 0 then

            local adj_list = {}

            for _, dirt_name in pairs(data_table.under_list) do

                if core.registered_nodes[dirt_name] ~= nil then
                    table.insert(adj_list, dirt_name)
                end

            end

            -- If exclusive nodes have been eliminated, return to the default sapling behaviour,
            --      which is that the sapling can grow on most dirts
            if #data_table.under_list > 0 then
                data_table.under_list = adj_list
            else
                data_table.under_list = nil
            end

        end

    end

end
