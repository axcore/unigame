---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- misc_medium.lua
--      Callbacks for nodes placed in a medium
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Callbacks for nodes placed in a medium
---------------------------------------------------------------------------------------------------

function unilib.misc._place_in_medium(itemstack, placer, pointed_thing, data_table)

    -- Adapted from default/nodes.lua
    -- Standard callback for items not placed in air (usually, when placed in a liquid)
    --
    -- "data_table" defines restrictions on where the item can be placed. It is a table whose keys
    --      are all optional in the form:
    --          need_under (str): Full name of the node on which the item must be placed (e.g.
    --              "unilib:sand_ordinary", or a group name (e.g. "group:sand"). If not specified,
    --              the item can be placed on any surface
    --          need_above (str): Full name of the medium in which the item must be placed (e.g.
    --              "unilib:liquid_water_ordinary_source"), or a group name (e.g. "group:water").
    --              If not specified, the item can be placed in any medium in the "water" group
    --              which is a water source (i.e. not flowing water)
    --          displace_flag (bool): If true, the placed item displaces the surface node
    --              .need_under; if false or not specified, it displaces the medium .need_above
    --          height (int): The height in blocks, for items like ordinary kelp that need them. If
    --              not specified, a height of 1 is assumed

    if pointed_thing.type == "node" and
            not (placer and placer:is_player() and placer:get_player_control().sneak) then
        return itemstack
    end

    local pname = placer:get_player_name()

    local pos_under = pointed_thing.under
    local node_under = core.get_node(pos_under)
    local under_def_table = core.registered_nodes[node_under.name]

    local pos_above = pointed_thing.above
    local node_above = core.get_node(pos_above)
    local above_def_table = core.registered_nodes[node_above.name]

    local pos_top, node_top, top_def_table
    if data_table.height ~= nil and data_table.height > 1 then

        pos_top = {x = pos_under.x, y = pos_under.y + data_table.height, z = pos_under.z}
        node_top = core.get_node(pos_top)
        top_def_table = core.registered_nodes[node_top.name]

    end

    if under_def_table and
            under_def_table.on_rightclick and not placer:get_player_control().sneak then

        return under_def_table.on_rightclick(
            pos_under, node_under, placer, itemstack, pointed_thing
        ) or itemstack

    end

    if data_table.need_under ~= nil then

        if string.sub(data_table.need_under, 1, 6) == "group:" then

            if core.get_item_group(node_under.name, string.sub(data_table.need_under, 7)) == 0 then
                return itemstack
            end

        elseif data_table.need_under ~= node_under.name then

            return itemstack

        end

    end

    if data_table.need_above ~= nil then

        if string.sub(data_table.need_above, 1, 6) == "group:" then

            if core.get_item_group(node_above.name, string.sub(data_table.need_above, 7)) == 0 then
                return itemstack
            end

        elseif data_table.need_above ~= node_above.name then

            return itemstack

        end

    elseif not above_def_table or
            above_def_table.liquidtype ~= "source" or
            core.get_item_group(node_above.name, "water") == 0 then

        return itemstack

    end

    if top_def_table ~= nil then

        if data_table.need_above ~= nil then

            if string.sub(data_table.need_above, 1, 6) == "group:" then

                if core.get_item_group(
                    node_top.name, string.sub(data_table.need_above, 7)
                ) == 0 then
                    return itemstack
                end

            elseif data_table.need_above ~= node_top.name then

                return itemstack

            end

        elseif not top_def_table or
                top_def_table.liquidtype ~= "source" or
                core.get_item_group(node_top.name, "water") == 0 then

            return itemstack

        end

    end

    if core.is_protected(pos_under, pname) or core.is_protected(pos_above, pname) then

        --[[
        unilib.utils.log(
            "action",
            pname .. " tried to place " .. itemstack:get_name() ..
                    " at protected position " .. core.pos_to_string(pos_under)
        )
        ]]--
        unilib.utils.log_player_action(
            placer,
            "tried to place",
            itemstack:get_name(),
            "at protected position",
            pos
        )

        core.record_protection_violation(pos_under, pname)
        return itemstack

    elseif top_def_table ~= nil and core.is_protected(pos_top, pname) then

        -- (Don't record a protection violation; it's not the player's fault that they don't know,
        --      in advance, a height that is usually randomised)
        return itemstack

    end

    if top_def_table == nil then

        if data_table.displace_flag then

            node_under.name = itemstack:get_name()
            core.set_node(pos_under, node_under)

        else

            node_above.name = itemstack:get_name()
            core.set_node(pos_above, node_above)

        end

    else

        local pixels = data_table.height * 16
        if data_table.displace_flag then
            core.set_node(pos_under, {name = itemstack:get_name(), param2 = pixels})
        else
            core.set_node(pos_above, {name = itemstack:get_name(), param2 = pixels})
        end

    end

    if not unilib.utils.is_creative(pname) then
        itemstack:take_item()
    end

    return itemstack

end
