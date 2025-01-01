---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- flora_sapling.lua
--      Handle saplings
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function explain_no_grow(pos, full_name, msg)

    if unilib.setting.debug_sapling_failure_flag then

        unilib.utils.show_error(
            S(
                "Sapling @1 did not grow at x=@2 y=@3 z=@4: @5",
                full_name,
                pos.x,
                pos.y,
                pos.z,
                msg
            )
        )

    end

    return false

end

---------------------------------------------------------------------------------------------------
-- Sapling placement
---------------------------------------------------------------------------------------------------

function unilib.flora._sapling_on_place(
    itemstack, placer, pointed_thing, sapling_name, minp_relative, maxp_relative, interval
)
    -- Adapted from from default/trees.lua
    -- Sapling "on_place" function to check protection of node and resulting tree volume
    -- (Also used by the cactus in the "plant_cactus_ordinary" package)
    --
    -- Args:
    --      itemstack (obj): Minetest itemstack, e.g. ItemStack("unilib:tree_aspen_sapling 10")
    --      placer (obj): Minetest userdata, e.g. "userdata: 0x40e309d8"
    --      pointed_thing (table): Minetest pointed_thing table
    --      sapling_name (str): e.g. "unilib:tree_aspen_sapling"
    --      minp_relative (table): Minetest pos table, e.g. {x = -1, y = 0, z = -1}
    --      maxp_relative (table): Minetest pos table, e.g. {x = -1, y = 0, z = -1}
    --      interval (int): e.g. 2
    --
    -- Return values:
    --      Minetest itemstack, e.g. ItemStack("unilib:tree_aspen_sapling 10")

    -- Position of sapling
    local pos = pointed_thing.under
    local node = core.get_node_or_nil(pos)
    local pdef = node and core.registered_nodes[node.name]

    if pdef and pdef.on_rightclick and not (
        placer and
        placer:is_player() and
        placer:get_player_control().sneak
    ) then
        return pdef.on_rightclick(pos, node, placer, itemstack, pointed_thing)
    end

    if not pdef or not pdef.buildable_to then

        pos = pointed_thing.above
        node = core.get_node_or_nil(pos)
        pdef = node and core.registered_nodes[node.name]
        if not pdef or not pdef.buildable_to then
            return itemstack
        end

    end

    local player_name = placer and placer:get_player_name() or ""

    -- Check sapling position for protection
    if core.is_protected(pos, player_name) then

        core.record_protection_violation(pos, player_name)
        return itemstack

    end

    -- Check tree volume for protection
    if core.is_area_protected(
        vector.add(pos, minp_relative),
        vector.add(pos, maxp_relative),
        player_name,
        interval
    ) then
        core.record_protection_violation(pos, player_name)
        -- Print extra information to explain
        core.chat_send_player(player_name,
            S(
                "@1 will intersect protection on growth.",
                itemstack:get_definition().description
            )
        )

        return itemstack

    end

    --[[
    unilib.utils.log(
        "action",
        player_name .. " places node " .. sapling_name .. " at " .. core.pos_to_string(pos)
    )
    ]]--
    if placer then
        unilib.utils.log_player_action(placer, "places node", sapling_name, "at", pos)
    end

    local take_item = not unilib.utils.is_creative(player_name)
    local newnode = {name = sapling_name}
    local ndef = core.registered_nodes[sapling_name]
    core.set_node(pos, newnode)

    -- Run callback
    if ndef and ndef.after_place_node then

        -- Deepcopy place_to and pointed_thing because callback can modify it
        if ndef.after_place_node(table.copy(pos), placer,
                itemstack, table.copy(pointed_thing)) then
            take_item = false
        end

    end

    -- Run script hook
    for _, callback in ipairs(core.registered_on_placenodes) do

        -- Deepcopy pos, node and pointed_thing because callback can modify them
        if callback(
            table.copy(pos),
            table.copy(newnode),
            placer,
            table.copy(node or {}),
            itemstack,
            table.copy(pointed_thing)
        ) then
            take_item = false
        end

    end

    if take_item then
        itemstack:take_item()
    end

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- Grow trees/bushes from saplings
---------------------------------------------------------------------------------------------------

function unilib.flora._can_grow_sapling(pos, full_name)

    -- Adapted from default/trees.lua
    -- Can be called by anything. Called periodically from the on_timer() function of each tree/bush
    --      sapling
    --
    -- Args:
    --      pos (table): Location of the sapling, e.g. {x = 1, y = 1, z = 1}
    --      full_name (str): e.g. "unilib:tree_aspen_sapling"
    --
    -- Return values:
    --      true if the sapling should be grown, false if not

    -- Retrieve data for this sapling
    local data_table = unilib.global.sapling_table[full_name]
    if data_table == nil then
        return explain_no_grow(pos, full_name, S("unrecognised sapling"))
    end

    -- Check the sapling is "planted" on something
    local node_under = core.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
    if not node_under then
        return explain_no_grow(pos, full_name, S("sapling not planted on surface"))
    end

    -- Check the node underneath
    if data_table.under_list == nil or unilib.setting.sapling_everywhere_flag then

        -- Check the sapling is "planted" on some node in the "soil" group, which includes most
        --      dirts
        if core.get_item_group(node_under.name, "soil") == 0 then
            return explain_no_grow(pos, full_name, S("sapling not planted on dirt"))
        end

    else

        -- Check the sapling is "planted" on the right kind of node
        local match_flag = false
        for _, this_node in ipairs(data_table.under_list) do

            if this_node == node_under.name then

                match_flag = true
                break

            end

        end

        if not match_flag then
            return explain_no_grow(pos, full_name, S("sapling requires different dirt"))
        end

    end

    -- Check that there are no obstructions immediately above the sapling (if a height was
    --      specified)
    -- Note that protection violations are checked in unilib.flora.sapling_on_place()
    if data_table.min_height ~= nil then

        local nod = core.line_of_sight(
            {x = pos.x, y = pos.y + 1, z = pos.z},
            {x = pos.x, y = pos.y + data_table.min_height, z = pos.z}
        )
        if not nod then
            return explain_no_grow(pos, full_name, S("sapling is obstructed"))
        end

    end

    -- Check the sapling is receiving sufficient light
    local light_level = core.get_node_light(pos)
    if not light_level or
            (data_table.min_light ~= nil and light_level < data_table.min_light) or
            (
                data_table.min_light == nil and
                light_level < unilib.constant.light_min_grow_sapling
            ) then
        return explain_no_grow(pos, full_name, S("insufficient light"))
    end

    return true

end

function unilib.flora._is_snow_nearby(pos)

    -- Adapted from default/trees.lua
    -- Tests whether the coordinates have a neighbouring snow node (e.g. used by the "tree_pine"
    --      package to select a schematic with or without snow)
    --
    -- Args:
    --      pos (table): Location of the position to test, e.g. {x = 1, y = 1, z = 1}
    --
    -- Return values:
    --      pos of the snow node, or nil if no snow found

    return core.find_node_near(pos, 1, {"group:snowy"})

end

function unilib.flora._get_sapling_hint(under_list)

    -- Called by unilib.register_tree_sapling() (but not by unilib.register_tree_sapling_custom() )
    -- Prepares some text to be used in the sapling's description, displaying a list of surface
    --      nodes on which this sapling can grow exclusively (if applicable)
    --
    -- Args:
    --      under_list (table or nil): If specified, the list of exclusive surface nodes
    --
    -- Return values:
    --      A string to display in the sapling's description, or nil if exclusive surface nodes
    --          don't apply to this sapling

    local hint = nil

    if under_list ~= nil and #under_list > 0 and not unilib.setting.sapling_everywhere_flag then

        local hint_list = {}
        for _, under_name in ipairs(under_list) do

            if core.registered_nodes[under_name] ~= nil then
                table.insert(hint_list, core.registered_nodes[under_name]["description"])
            elseif not unilib.setting.sapling_grow_hint_omit_flag then
                table.insert(hint_list, "(" .. under_name .. ")")
            end

        end

        hint = table.concat(hint_list, "\n")

    end

    return hint

end
