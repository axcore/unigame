---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- fertiliser_base.lua
--      Base API functions for fertilisers
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table used in calls to check_soil(), so that calculations for each node only need to be
--      performed once
local fertilise_table = {}
-- Categories of node, on which fertilisers can be used (a table for quick lookup)
local category_table = {
    crop = true,
    flower = true,
    grass = true,
    plant = true,
    produce = true,
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_particle_effect(pos, part_name)

    -- Adapted from bonemeal/init.lua
    -- Shows particles when fertiliser is applied to something suitable (whether growth occurs on
    --      not)

    core.add_particlespawner({
        amount = 4,
        time = 0.15,
        texture = "unilib_particle_item_fertiliser_" .. part_name .. ".png",

        maxacc = {x = 1, y = 1, z = 1},
        minacc = {x = -1, y = -1, z = -1},
        maxexptime = 1,
        minexptime = 1,
        maxpos = pos,
        minpos = pos,
        maxsize = 3,
        minsize = 1,
        maxvel = {x = 1, y = 4, z = 1},
        minvel = {x = -1, y = 2, z = -1},
    })

end

local function can_place_on(full_name, val)

    -- Original to unilib, to replace faulty code in check_soil()
    -- The original code assumed that a decoration's .place_on field was either nil or a full_name,
    --      but could not handle a list or a string like "group:sand"
    -- This function corrects that problem. "val" is the value of the decoration's .place_on field;
    --      "full_name" is the node that has been punched (while wielding some kind of fertiliser)
    -- If "val" is nil, or matches "full_name", then the decoration can be placed here (returning
    --      true), otherwise it can't (returning false)

    if val == nil or val == full_name then
        return true
    end

    for _, this_name in ipairs(unilib.utils.convert_to_list(val)) do

        if this_name == full_name or (
             string.sub(this_name, 1, 6) == "group:" and
             core.get_item_group(full_name, string.sub(this_name, 7)) > 0
        ) then
            return true
        end

    end

    return false

end

local function is_decoration_compatible(val)

    -- Original to unilib
    -- "val" is the .decoration field of a "simple" decoration, which may be a string or a list
    -- Return true if any the items specified by "val" are compatible with fertilisers (e.g.
    --      plants, grasses, crops etc)

    for _, this_name in ipairs(unilib.utils.convert_to_list(val)) do

        local category = unilib.utils.get_first_component(this_name)
        if category_table[category] then
            return true
        end

    end

    return false

end

local function check_soil(pos, full_name, part_name, strength)

    -- Adapted from bonemeal/init.lua
    -- When fertiliser is used directly on dirt/soil/sand, grow grass/flowers/plants/crops/produce
    --      in appropriate quantities

    -- Set the bounds of the area, according to fertiliser strength
    local side = strength - 1
    local tall = math.max(strength - 2, 0)

    -- Within that area, only place decorations on the same type of surface (any kind of soil, any
    --      kind of sand, or the exact same node)
    local group_table = (
        core.registered_items[full_name] and
        core.registered_items[full_name].groups
    ) or {}

    local ground_list
    if group_table.soil then
        ground_list = {"group:soil"}
    elseif group_table.sand then
        ground_list = {"group:sand"}
    else
        ground_list = {full_name}
    end

    -- A list of nodes on which a decoration can be placed. Each item on the list is a table in
    --      the form {x, y, z}
    local dirt_list = core.find_nodes_in_area_under_air(
        {x = pos.x - side, y = pos.y - tall, z = pos.z - side},
        {x = pos.x + side, y = pos.y + tall, z = pos.z + side},
        ground_list
    )

    -- Search decorations, looking for decorations which are allowed to grow on "full_name" (unlike
    --      the original mod, there is not a fixed list of suitable decorations)
    -- Split the decorations into three lists: common, uncommon and rare
    local common_list = {}
    local uncommon_list = {}
    local rare_list = {}

    if fertilise_table[full_name] == nil then

        -- Performing this calculation for the first time with "full_name"
        local biome_table = core.get_biome_data(pos)
        local biome_name = core.get_biome_name(biome_table.biome)
        for _, def_table in pairs(core.registered_decorations) do

            if def_table.deco_type == "simple" and
            is_decoration_compatible(def_table.decoration) and
            can_place_on(full_name, def_table.place_on) and
            def_table.spawn_by == nil and (
                def_table.biomes == nil or
                unilib.utils.is_value_scalar_or_in_list(biome_name, def_table.biomes)
            ) and (
                def_table.y_min == nil
                or def_table.y_min <= pos.y
            ) and (
                def_table.y_max == nil
                or def_table.y_max >= pos.y
            ) then

                for _, this_name in ipairs(unilib.utils.convert_to_list(def_table.decoration)) do

                    local category = unilib.utils.get_first_component(this_name)
                    if category == "grass" then
                        table.insert(common_list, this_name)
                    elseif category == "flower" or category == "plant" then
                        table.insert(uncommon_list, this_name)
                    elseif category == "crop" or category == "produce" then
                        table.insert(rare_list, this_name)
                    end

                end

            end

        end

        -- Store the results, so this calculation only has to be done once
        fertilise_table[full_name] = {
            common_list = common_list,
            uncommon_list = uncommon_list,
            rare_list = rare_list,
        }

    else

        -- We have already perfomed this calculation with "full_name"
        mini_table = fertilise_table[full_name]
        common_list = mini_table.common_list
        uncommon_list = mini_table.uncommon_list
        rare_list = mini_table.rare_list

    end

    -- Walk dirt_list, randomly placing decorations in available positions
    -- (The original code used math.random(5) and no "uncommon_list")
    for _, this_pos in pairs(dirt_list) do

        local placeable = ""
        local rand = math.random(10)

        if rand == 1 then

            if #rare_list > 0 then

                local drare = #rare_list or 1
                placeable = rare_list[math.random(drare)] or ""

            end

        elseif rand <= 3 then

            if #uncommon_list > 0 then

                local drare = #uncommon_list or 1
                placeable = uncommon_list[math.random(drare)] or ""

            end

        elseif rand <= 6 then

            if #common_list > 0 then

                local dcommon = #common_list or 1
                placeable = common_list[math.random(dcommon)] or ""

            end

        end

        -- (The decoration is placed on the soil, not inside it)
        local above_pos = this_pos
        above_pos.y = above_pos.y + 1

        if placeable ~= "" then

            -- get crop param2 value
            local this_def_table = core.registered_nodes[placeable]
            this_def_table = this_def_table and this_def_table.place_param2

            -- if param2 not preset then get from existing node
            if not this_def_table then

                local node = core.get_node_or_nil(above_pos)
                this_def_table = node and node.param2 or 0

            end

            core.set_node(above_pos, {name = placeable, param2 = this_def_table})

        end

        do_particle_effect(above_pos, part_name)

    end

end

local function check_sapling(pos, full_name, part_name, strength)

    -- Adapted from bonemeal/init.lua
    -- Check for tree/bush growth when pointing at saplings
    -- This code has been tested with both schematic-based trees and L-system trees

    -- At the moment, only tree and bush saplings are supported
    category = unilib.utils.get_first_component(full_name)
    if (category == "tree" or category == "bush") and 
            unilib.flora.can_grow_sapling(pos, full_name) then

        if math.random(5 - strength) == 1 then

            if category == "tree" then

                do_particle_effect(pos, part_name)
                unilib.trees.grow_sapling(pos, full_name)
                return true

            elseif category == "bush" then

                do_particle_effect(pos, part_name)
                unilib.bushes.grow_sapling(pos, full_name)
                return true

            end

        else

            -- Try again next time
            do_particle_effect(pos, part_name)
            return

        end

    end

end

local function check_crops(pos, full_name, part_name, strength)

    -- Adapted from bonemeal/init.lua
    -- Check for crop/produce growth when pointing at them

    local data_table = unilib.global.grow_stage_table[full_name]
    if data_table == nil or data_table.stage_max == nil or (
        -- N.B. Crops have the .mode "mtgame" or "fredo", not "crop"
        data_table.mode ~= "mtgame" and
        data_table.mode ~= "fredo" and
        data_table.mode ~= "produce"
    ) then
        return
    end

    -- Increase the growth stage of the crop/produce by "strength"
    local new_name = data_table.base_name .. "_" ..
            math.min(data_table.stage + strength, data_table.stage_max)

    -- Check for the place_param setting
    local def_table = core.registered_nodes[new_name]
    local place_param2 = def_table and def_table.place_param2 or 0
    core.set_node(pos, {name = new_name, param2 = place_param2})
    do_particle_effect(pos, part_name)

    return true

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.fertiliser._register_special(full_name, func)

    -- Original to unilib
    -- Any items (cactus, papyrus etc) that require special code when a fertiliser (bonemeal, etc)
    --      is used on them should call this function
    --
    -- Args:
    --      full_name (str): e.g. "unilib:plant_cactus_ordinary"
    --      func (function): The function to call

    unilib.global.special_fertiliser_table[full_name] = func

end

function unilib.fertiliser._callback_on_use(pos, part_name, strength, node)

    -- Adapted from bonemeal/init.lua, bonemeal:on_use()

    -- Get node at which we're pointing
    local node = node or core.get_node(pos)
    if node.name == "ignore" then
        return
    end

    -- Make sure strength is between 1 and 4
    -- N.B. No code adapted from the bonemeal mod (or from any other mod) uses strength 4
    strength = strength or 1
    strength = math.max(strength, 1)
    strength = math.min(strength, 4)

    -- Items for which special functions exist (cactus, papyrus, etc)
    if unilib.global.special_fertiliser_table[node.name] ~= nil then

        unilib.global.special_fertiliser_table[node.name](pos, node)
        do_particle_effect(pos, part_name)
        return true

    end

    -- When fertiliser is used directly on dirt/soil/sand, grow grass/flowers/plants/crops/produce
    --      in appropriate quantities
    if core.get_item_group(node.name, "soil") > 0
    or core.get_item_group(node.name, "sand") > 0
    or core.get_item_group(node.name, "can_bonemeal") > 0 then

        check_soil(pos, node.name, part_name, strength)
        return true

    end

    -- Check for tree/bush growth when pointing at saplings
    if core.get_item_group(node.name, "sapling") > 0 then
        return check_sapling(pos, node.name, part_name, strength)
    end

    -- Light check depending on strength (strength of 4 = no light needed)
    if (core.get_node_light(pos) or 0) < (12 - (strength * 3)) then
        return
    end

    -- Check for crop/produce growth when pointing at them
    if check_crops(pos, node.name, part_name, strength) then
        return true
    end

end
