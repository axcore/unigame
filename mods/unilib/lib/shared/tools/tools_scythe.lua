---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- tools_scythe.lua
--      Scythe support functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- (From sickles/api.lua)
local default_basic_scythe_uses = 150
local default_advanced_scythe_uses = 30

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_seed_name(grow_name)

    -- Adapted from sickles/api.lua
    -- Converts a crop/produce node with the growth stage already removed (e.g.
    --      "unilib:crop_wheat_grow") into the full name of the equivalent seed (e.g.
    --      "unilib:crop_wheat_seed") or harvested produce (e.g. "unilib:produce_artichoke_harvest")

    local mod_name, item_name = unilib.utils.split_name(grow_name)
    local adj_item_name = item_name:gsub("(.*)_.*$", "%1")

    if string.find(grow_name, "^unilib:crop_") then

        return mod_name .. ":" .. adj_item_name:gsub("(.*)_grow", "%1") .. "_seed"

    else

        -- For produce, the final growth stage is the seed
        return mod_name .. ":" .. adj_item_name:gsub("(.*)_grow", "%1") .. "_harvest"
    end

end

local function harvest_and_replant(pos, player)

    -- Adapted from sickles/api.lua, harvest_and_replant()
    -- Handles re-planting of crops and produce

    local playername = player:get_player_name()
    local node = core.get_node(pos)

    local data_table = unilib.global.grow_stage_table[node.name]
    if data_table == nil or
            data_table.stage == 0 or
            data_table.stage < data_table.stage_max or
            data_table.mode == "other" or
            unilib.global.tool_no_scythe_table[node.name] ~= nil then
        return false
    end

    if core.is_protected(pos, playername) then

        core.record_protection_violation(pos, playername)
        return false

    end

    core.node_dig(pos, node, player)
    core.sound_play("unilib_dig_snappy", {pos = pos, gain = 0.5, max_hear_distance = 8}, true)

    core.after(0, function()

        local invref = player:get_inventory()
        local seed_name = get_seed_name(data_table.base_name)
        if core.get_node(pos).name ~= "air" or not invref:contains_item("main", seed_name) then
            return true
        end

        if not unilib.utils.is_creative(playername) then
            invref:remove_item("main", seed_name)
        end

        if data_table.mode == "mtgame" then

            -- Crops created by a call to unilib.register_crop_mtgame()
            core.set_node(pos, {name = seed_name, param2 = 1})
            -- N.B. The code in ../lib/shared/farming/farming_base.lua uses the same tweak as this
--          core.get_node_timer(pos):start(math.random(166, 286))
            core.get_node_timer(pos):start(
                math.random(
                    unilib.setting.farming_grow_default,
                    (unilib.setting.farming_grow_default * 5 / 3)
                )
            )

        else

            -- Crops created by a call to unilib.register_crop_fredo()
            -- Produce created by a call to unilib.register_produce_fredo()
            local full_name = data_table.base_name .. "_1"
            local crop_def = core.registered_nodes[full_name]
            if crop_def == nil then
                return
            end

            core.set_node(pos, {name = full_name, param2 = crop_def.place_param2})

        end

    end)

    return true

end

local function use_basic_scythe(itemstack, user, pointed_thing)

    -- Adapted from farming_redo
    -- When used on a crop or produce item, harvests the item, dropping it and any seeds on the
    --      ground

    if pointed_thing.type ~= "node" then
        return
    end

    local pos = pointed_thing.under
    local name = user:get_player_name()
    if core.is_protected(pos, name) then
        return
    end

    local node = core.get_node_or_nil(pos)
    if not node then
        return
    end

    local def = core.registered_nodes[node.name]
    if not def then
        return
    end

    if not def.drop or not def.groups or not def.groups.plant then
        return
    end

    local drops = core.get_node_drops(node.name, "")
    if not drops or #drops == 0 or (#drops == 1 and drops[1] == "") then
        return
    end

    -- Get crop name and growth stage
    -- e.g. "unilib:crop_wheat_grow"
    local grow_name = node.name:gsub("(.*)_.*$", "%1")
    -- e.g. 8
    local stage = tonumber(node.name:gsub(".*_(.*)$", "%1") or 0)

    if not stage then
        return
    end

    -- Add dropped items
    for _, dropped_item in pairs(drops) do

        -- Don't drop items on this list
        if unilib.global.tool_no_scythe_table[dropped_item] ~= nil then
            dropped_item = nil
        end

        if dropped_item then

            local obj = core.add_item(pos, dropped_item)

            if obj then

                obj:set_velocity({
                    x = math.random(-10, 10) / 9,
                    y = 3,
                    z = math.random(-10, 10) / 9,
                })

            end

        end

    end

    -- Run script hook
    for _, callback in pairs(core.registered_on_dignodes) do
        callback(pos, node, user)
    end

    -- Play sound
    core.sound_play("unilib_grass_footstep", {pos = pos, gain = 1.0})

    local replace = grow_name .. "_1"

    if core.registered_nodes[replace] then

        local p2 = core.registered_nodes[replace].place_param2 or 1
        core.set_node(pos, {name = replace, param2 = p2})

    else

        core.set_node(pos, {name = "air"})

    end

    if not unilib.utils.is_creative(name) then

        itemstack:add_wear(unilib.constant.max_tool_wear / default_basic_scythe_uses)
        return itemstack

    end

end

local function use_advanced_scythe(itemstack, user, pointed_thing)

    -- Adapted from sickles/api.lua, sickles.use_scythe()
    -- When used on a crop or produce item, harvests the item, then plants a seed in its place
    -- Repeats for the surrounding nodes, depending on the value of the scythe's "scythe" group

    if pointed_thing == nil then
        return
    end

    -- Code to handle scythe being used on something lying on the ground...
    local itemdef = itemstack:get_definition()
    if pointed_thing.type == "object" then

        local tool_capabilities = itemstack:get_tool_capabilities()
        local meta = itemstack:get_meta()
        local last_punch = meta:get_float("last_punch") or 0
        local now = core.get_gametime()
        meta:set_float("last_punch", now)
        pointed_thing.ref:punch(user, now - last_punch, tool_capabilities)

    end

    if pointed_thing.type ~= "node" then

        -- ...in which case, we give up
        return

    end

    local max_uses = unilib.utils.get_group(itemdef, "scythe_uses") or default_advanced_scythe_uses
    local range = (unilib.utils.get_group(itemdef, "scythe") or 1) - 1
    local pos = pointed_thing.under

    -- Plant at the clicked location
    local harvested_flag = harvest_and_replant(pos, user)
    if not harvested_flag then

        -- Not plantable
        return

    end

    if range > 0 then

        -- Plant in the area surrounding the clicked location
        local pos1 = vector.add(pos, {x = -range, y = 0, z = -range})
        local pos2 = vector.add(pos, {x = range, y = 0, z = range})
        local positions = core.find_nodes_in_area(pos1, pos2, "group:plant")
        for _, check_pos in ipairs(positions) do

            if pos ~= check_pos then
                harvest_and_replant(check_pos, user)
            end

        end

    end

    itemstack:add_wear(math.ceil(unilib.constant.max_tool_wear / (max_uses - 1)))
    return itemstack

end

---------------------------------------------------------------------------------------------------
-- Scythe support functions
---------------------------------------------------------------------------------------------------

function unilib.tools._use_scythe(itemstack, user, pointed_thing)

    if not unilib.setting.sickles_replant_flag then

        -- From farming_redo mod
        return use_basic_scythe(itemstack, user, pointed_thing)

    else

        -- From sickles mod
        return use_advanced_scythe(itemstack, user, pointed_thing)

    end

end
