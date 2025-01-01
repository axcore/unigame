---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- tools_special.lua
--      Register special shovels
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Override the core.handle_node_drops() function only once, and only if at least one special
--      shovel is registered
local override_drops_flag = false

---------------------------------------------------------------------------------------------------
-- Register special shovels
---------------------------------------------------------------------------------------------------

function unilib.tools._register_special_shovel(full_name)

    -- Original to unilib
    -- Special shovels can dig an original node, rather than the item specified in that node's .drop
    --      field. Specifically, they can dig nodes in the "crumbly" and "coral" groups
    --      (e.g. digs dirt with turf, instead of dirt; digs coral, rather than coral skeletons)
    -- All special shovels should register themselves by calling this function

    -- Update global variables
    unilib.global.special_shovel_table[full_name] = true

    -- Override Minetest's handler so that special shovels work as intended (obviously, we only do
    --      it once)
    if not override_drops_flag then

        override_drops_flag = true

        -- Adapted from aotearoa/green_shovel.lua
        local old_handle_node_drops = core.handle_node_drops

        function core.handle_node_drops(pos, drops, digger)

            local wielded_name = digger:get_wielded_item():get_name()
            if not digger or unilib.global.special_shovel_table[wielded_name] == nil then
                return old_handle_node_drops(pos, drops, digger)
            end

            local node_name = core.get_node(pos).name

            if core.get_item_group(node_name, "crumbly") == 0 and
                    core.get_item_group(node_name, "coral") == 0 then
                return old_handle_node_drops(pos, drops, digger)
            end

            return old_handle_node_drops(pos, {ItemStack(node_name)}, digger)

        end

    end

end
