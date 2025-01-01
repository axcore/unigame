---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- flooding.lua
--      Set up flooding and flushing effects. Code adapted from "farming_flood" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Flora is floodable (destroyed by a flowing liquid) or flushable (uprooted by a flowing liquid)
core.register_on_mods_loaded(function()

    for full_name, def_table in pairs(core.registered_nodes) do

        -- N.B. The "flora" and "mushroom" groups were not checked in the original code
        if core.get_item_group(full_name, "plant") >= 1 or
                core.get_item_group(full_name, "flora") >= 1 or
                core.get_item_group(full_name, "flower") >= 1 or
                core.get_item_group(full_name, "mushroom") >= 1 or
                core.get_item_group(full_name, "grass") >= 1 or
                core.get_item_group(full_name, "dry_grass") >= 1 or
                core.get_item_group(full_name, "sapling") >= 1 then

            -- If both floodable and flushable flora are enabled, then flushable fauna takes
            --      precedence
            if not unilib.setting.flushable_flora_flag then

                unilib.override_item(full_name, {
                    floodable = true,
                })

            elseif not def_table.on_flood then

                unilib.override_item(full_name, {
                    floodable = true,
                    on_flood = function(pos, oldnode, newnode)
                        core.dig_node(pos)
                    end,
                })

            end

        end

    end

end)
