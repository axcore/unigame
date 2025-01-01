---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- misc_other.lua
--      Miscellaneous functions inherited from other mods
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Auto-rotate node after placing
---------------------------------------------------------------------------------------------------

function unilib.misc._rotate_and_place(itemstack, placer, pointed_thing, lookup_table)

    -- Adapted from morelights, was morelights.rotate_and_place()
    -- An .on_place() callback, called when a suitable node is placed in the world
    -- Used by ceiling lights to make sure they're orientated the right way up (see the
    --      "light_lamp_ceiling_normal" package for some example calling code)
    -- Can also be used by any other code, for which this function can be called with a customised
    --      "lookup_table"; for a working example, see the "plant_torchberry" package

    local dir = core.dir_to_wallmounted(vector.subtract(pointed_thing.under, pointed_thing.above))

    if lookup_table == nil then

        -- {top, bottom, west, east, south, north}
        lookup_table = {[0] = 20, 0, 16, 12, 8, 4}

    end

    core.item_place(itemstack, placer, pointed_thing, lookup_table[dir] or 0)
    return itemstack

end

---------------------------------------------------------------------------------------------------
-- When right-clicking a node with a wielded item, use the pointed node's code
---------------------------------------------------------------------------------------------------

function unilib.misc._pointed_has_rightclick(itemstack, placer, pointed_thing)

    -- Adapted from xdecor-libre
    -- When the player right-clicks a pointed node with a wielded item, use the .on_rightclick()
    --      function of the pointed node, not the wielded item
    -- This allows, for example, rough rope (unilib:rope_rough / xdecor:rope) to be placed into a
    --      wooden display frame (unilib:misc_frame_wood_display / xdecor:itemframe)
    --
    -- If this function returns true, a call to unilib.misc.pointed_use_rightclick() should be made
    --      (see the "rope_rough" package for a working example)

    if pointed_thing.type ~= "node" then
        return false
    end

    if placer and not placer:get_player_control().sneak then

        local node = core.get_node(pointed_thing.under)
        if core.registered_nodes[node.name] and core.registered_nodes[node.name].on_rightclick then
            return true
        end

    end

    return false

end

function unilib.misc._pointed_use_rightclick(itemstack, placer, pointed_thing)

    -- Adapted from xdecor-libre

    local node = core.get_node(pointed_thing.under)
    return core.registered_nodes[node.name].on_rightclick(
        pointed_thing.under, node, placer, itemstack
    ) or itemstack

end
