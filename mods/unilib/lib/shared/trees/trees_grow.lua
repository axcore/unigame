---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- trees_grow.lua
--      Grow tree saplings
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Grow tree saplings
---------------------------------------------------------------------------------------------------

function unilib.trees._grow_sapling(pos, full_name)

    -- Adapted from default/trees.lua
    -- Can be called by anything. Called periodically from the on_timer() function of each tree
    --      sapling
    -- Converts a sapling into a tree

    -- Retrieve data for this sapling
    local data_table = unilib.global.sapling_table[full_name]
    if data_table == nil then
        return false
    end

    if data_table.grow_func ~= nil then

        -- Some trees provide special handling for growing the sapling
        -- (It's the responsibility of the called function to remove the sapling)
        data_table.grow_func(pos, full_name)

    elseif data_table.ltree_model ~= nil then

        -- Grow an L-system tree, first removing the sapling
        core.remove_node(pos)
        core.spawn_tree(pos, data_table.ltree_model)

    else

        -- Grow the tree using a schematic

        -- (Compulsory)
        local part_name = data_table.part_name
        -- (Optional)
        local offset_list = data_table.offset_list or {3, 1, 3}
        local schem_list = data_table.schem_list

        unilib.utils.log(
            "action",
            "The " .. part_name .. " tree sapling grows into a tree at " .. core.pos_to_string(pos)
        )

        local replace_table
        if data_table.replace_func ~= nil then
            replace_table = data_table.replace_func(pos)
        end

        if schem_list == nil then

            -- Use a schematic whose name is in a standard format
            local mts_path = unilib.core.path_mod .. "/mts/unilib_tree_" .. part_name ..
                    "_from_sapling.mts"
            if not unilib.utils.is_file(mts_path) then
                mts_path = unilib.core.path_mod .. "/mts/unilib_tree_" .. part_name .. ".mts"
            end

            -- unilib v0.16.275, Minetest 5.9.0 and earlier; replacement table won't be applied
            --      unless the schematic is loaded with a .read_schematic() call
            if replace_table ~= nil then
                mts_path = core.read_schematic(mts_path, {})
            end

            core.remove_node(pos)
            core.place_schematic(
                {
                    x = pos.x - offset_list[1],
                    y = pos.y - offset_list[2],
                    z = pos.z - offset_list[3],
                },
                mts_path,
                "0",
                replace_table,
                false
            )

        else

            -- Use one of the specified schematics at random
            local mini_list = schem_list[math.random(#schem_list)]

            -- unilib v0.16.275, Minetest 5.9.0 and earlier; replacement table won't be applied
            --      unless the schematic is loaded with a .read_schematic() call
            local mts_path = unilib.core.path_mod .. "/mts/" .. mini_list[1] .. ".mts"
            if replace_table ~= nil then
                mts_path = core.read_schematic(mts_path, {})
            end

            core.remove_node(pos)
            core.place_schematic(
                {x = pos.x - mini_list[2], y = pos.y - mini_list[3], z = pos.z - mini_list[4]},
                mts_path,
                "0",
                replace_table,
                false
            )

        end

    end

end
