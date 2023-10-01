---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- tools.lua
--      Set up shared functions for tools
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- (From sickles/api.lua)
local max_item_wear = 65535
local default_sickle_uses = 120
local default_basic_scythe_uses = 150
local default_advanced_scythe_uses = 30

-- (From toolranks/init.lua)
local colour_table = {
    grey = minetest.get_color_escape_sequence("#9d9d9d"),
    green = minetest.get_color_escape_sequence("#1eff00"),
    gold = minetest.get_color_escape_sequence("#ffdf00"),
    white = minetest.get_color_escape_sequence("#ffffff"),
}

local level_multiplier = 1 / unilib.toolranks_max_levels

-- Progressive levelling table (when each level is 50% more expensive than the previous one)
local progressive_table = {}
local total = 0
local last = unilib.toolranks_nodes_per_level
for i = 0, (unilib.toolranks_max_levels - 1) do

    total = total + last
    progressive_table[i] = total
    last = math.floor((last * 0.5) + last)

end

-- (Force translation of the tool types typically used in calls to unilib.apply_toolranks() )
local tool_type_list = {
    S("axe"), S("chainsaw"), S("drill"), S("hoe"), S("pickaxe"), S("scythe"), S("shovel"),
    S("sickle"), S("spear"), S("sword"), S("tool"),
}

---------------------------------------------------------------------------------------------------
-- Standard tool wear handling
---------------------------------------------------------------------------------------------------

function unilib.tool_after_use(itemstack, user, node, digparams)

    -- Adapted from toolranks/init.lua

    if not unilib.is_creative(user:get_player_name()) then

        local itemdef = itemstack:get_definition()
        if unilib.toolranks_warn_break_flag and
                digparams.wear > 0 and
                itemstack:get_wear() > 60135 then

            minetest.chat_send_player(user:get_player_name(), S("Your tool is about to break!"))
            minetest.sound_play("unilib_tool_breaks", {to_player = pname, gain = 2.0})

        end

        itemstack:add_wear(digparams.wear)

    end

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- Register craft recipes for standard tools
---------------------------------------------------------------------------------------------------

function unilib.register_craft_axe(data_table)

    -- Adapted from default/tools.lua
    -- Function to create a standard craft recipe for the specified axe
    -- Unlike the original minetest_game code, this function can also produce the mirror image
    --      craft recipe
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    unilib.register_craft({
        output = "unilib:tool_axe_" .. part_name,
        recipe = {
            {ingredient, ingredient},
            {ingredient, "group:stick"},
            {"", "group:stick"}
        },
    })

    if unilib.mtgame_tweak_flag then

        -- (Mirror image craft recipe)
        unilib.register_craft({
            output = "unilib:tool_axe_" .. part_name,
            recipe = {
                {"", ingredient, ingredient},
                {"", "group:stick", ingredient},
                {"", "group:stick", ""},
            },
        })

    end

end

function unilib.register_craft_chainsaw(data_table)

    -- Adapted from xtraores/init.lua
    -- Function to create a standard craft recipe for the specified chainsaw (an overpowered axe)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "tritonium"
    --      ingredient (str): e.g. "unilib:metal_tritonium_ingot"
    --      minor_ingredient (str): e.g. "unilib:metal_steel_ingot"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient
    local minor_ingredient = data_table.minor_ingredient

    unilib.register_craft({
        output = "unilib:tool_chainsaw_" .. part_name,
        recipe = {
            {minor_ingredient, ingredient},
            {minor_ingredient, ingredient},
            {"", ingredient},
        },
   })

   if unilib.mtgame_tweak_flag then

        -- (Mirror image craft recipe)
        unilib.register_craft({
            output = "unilib:tool_chainsaw_" .. part_name,
            recipe = {
                {ingredient, minor_ingredient},
                {ingredient, minor_ingredient},
                {ingredient, ""},
            },
        })

    end

end

function unilib.register_craft_drill(data_table)

    -- Adapted from xtraores/init.lua
    -- Function to create a standard craft recipe for the specified drill (an overpowered pickaxe)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "tritonium"
    --      ingredient (str): e.g. "unilib:metal_tritonium_ingot"
    --      minor_ingredient (str): e.g. "unilib:mineral_diamond_gem"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient
    local minor_ingredient = data_table.minor_ingredient

    unilib.register_craft({
        output = "unilib:tool_chainsaw_" .. part_name,
        recipe = {
            {ingredient, ingredient, ingredient},
            {"", ingredient, ""},
            {"", minor_ingredient, ""},
        },
   })

end

function unilib.register_craft_pick(data_table)

    -- Adapted from default/tools.lua
    -- Function to create a standard craft recipe for the specified pickaxe
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"


    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    unilib.register_craft({
        output = "unilib:tool_pick_" .. part_name,
        recipe = {
            {ingredient, ingredient, ingredient},
            {"", "group:stick", ""},
            {"", "group:stick", ""},
        },
    })

end

function unilib.register_craft_scythe(data_table)

    -- Adapted from sickles/tools.lua
    -- Function to create a standard craft recipe for the specified scythe
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    unilib.register_craft({
        output = "unilib:tool_scythe_" .. part_name,
        recipe = {
            {"", ingredient, ingredient},
            {ingredient, "", "group:stick"},
            {"", "", "group:stick"},
        },
    })

end

function unilib.register_craft_shovel(data_table)

    -- Adapted from default/tools.lua
    -- Function to create a standard craft recipe for the specified shovel
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    unilib.register_craft({
        output = "unilib:tool_shovel_" .. part_name,
        recipe = {
            {ingredient},
            {"group:stick"},
            {"group:stick"},
        },
    })

end

function unilib.register_craft_sickle(data_table)

    -- Adapted from sickles/tools.lua
    -- Function to create a standard craft recipe for the specified sickle
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    unilib.register_craft({
        output = "unilib:tool_sickle_" .. part_name,
        recipe = {
            {ingredient, ""},
            {"", ingredient},
            {"group:stick", ""},
        },
    })

end

function unilib.register_craft_sword(data_table)

    -- Adapted from default/tools.lua
    -- Function to create a standard craft recipe for the specified sword
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    unilib.register_craft({
        output = "unilib:tool_sword_" .. part_name,
        recipe = {
            {ingredient},
            {ingredient},
            {"group:stick"},
        },
    })

end

function unilib.register_craft_spear(data_table)

    -- Adapted from xtraores/init.lua
    -- Function to create a standard craft recipe for the specified spear
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "bronze"
    --      ingredient (str): e.g. "unilib:metal_bronze_ingot"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    unilib.register_craft({
        output = "unilib:tool_spear_" .. part_name,
        recipe = {
            {"", ingredient, ""},
            {ingredient, "group:stick", ingredient},
            {"", "group:stick", ""}
        },
    })

end

---------------------------------------------------------------------------------------------------
-- Register tool properties
---------------------------------------------------------------------------------------------------

function unilib.register_tool_no_repair(full_name, error_msg)

    -- Original to unilib
    -- Items that should not be repairable (for example, by the anvil provided by the
    --      "machine_anvil_simple" package should call this function
    --
    -- Args:
    --      full_name (str): e.g. "unilib:item_hangglider"
    --      error_msg (msg): e.g. "This hangglider is unsuitable for repair", if not specified, a
    --          generic message is used

    if error_msg == nil then
        unilib.tool_no_repair_table[full_name] = S("This item cannot be repaired")
    else
        unilib.tool_no_repair_table[full_name] = error_msg
    end

end

function unilib.register_tool_no_scythe(full_name)

    -- Original to unilib
    -- Items that should not be affected by scythes (e.g. beanpoles and trellises) should call this
    --      function

    unilib.tool_no_scythe_table[full_name] = true

end

function unilib.register_special_shovel(full_name)

    -- Original to unilib
    -- Items (e.g. the crystallinum shovel) that should be able to dig original nodes from the
    --      "crumbly" group (i.e. dirt with turf, instead of dirt, as with most shovels) should call
    --      this function

    unilib.special_shovel_table[full_name] = true

end

---------------------------------------------------------------------------------------------------
-- Register hoes
---------------------------------------------------------------------------------------------------

local function on_use_hoe(itemstack, user, pointed_thing, uses)

    -- Adapted from farming/api.lua

    local pt = pointed_thing

    -- Check if pointing at a node
    if not pt then
        return
    end
    if pt.type ~= "node" then
        return
    end

    local under = minetest.get_node(pt.under)
    local p = {x = pt.under.x, y = pt.under.y+1, z = pt.under.z}
    local above = minetest.get_node(p)

    -- Return if any of the nodes is not registered
    if not minetest.registered_nodes[under.name] then
        return
    end
    if not minetest.registered_nodes[above.name] then
        return
    end

    -- Check if the node above the pointed thing is air
    if above.name ~= "air" then
        return
    end

    -- Check if pointing at soil
    if minetest.get_item_group(under.name, "soil") ~= 1 then
        return
    end

    -- Check if (wet) soil defined
    local regN = minetest.registered_nodes
    if regN[under.name].soil == nil or regN[under.name].soil.wet == nil or
            regN[under.name].soil.dry == nil then
        return
    end

    local player_name = user and user:get_player_name() or ""

    if minetest.is_protected(pt.under, player_name) then

        minetest.record_protection_violation(pt.under, player_name)
        return

    end
    if minetest.is_protected(pt.above, player_name) then

        minetest.record_protection_violation(pt.above, player_name)
        return

    end

    -- Turn the node into soil and play sound
    minetest.set_node(pt.under, {name = regN[under.name].soil.dry})
    minetest.sound_play(
        "unilib_dig_crumbly",
        {pos = pt.under, gain = 0.5},
        true
    )

    if not unilib.is_creative(player_name) then

        -- Wear tool
        local wdef = itemstack:get_definition()
        itemstack:add_wear(65535 / (uses - 1))
        -- Tool break sound
        if itemstack:get_count() == 0 and wdef.sound and wdef.sound.breaks then
            minetest.sound_play(wdef.sound.breaks, {pos = pt.above, gain = 0.5}, true)
        end
    end

    return itemstack

end

function unilib.register_hoe(data_table)

    -- Adapted from farming/api.lua
    -- Function to register a hoe
    -- Unlike the original minetest_game code, this function can also produce the mirror image
    --      craft recipe
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "diamond"
    --      full_name (str): e.g. "unilib:tool_hoe_diamond"
    --      orig_name (str): e.g. "farming:hoe_diamond"
    --      def_table (table): The partial definition table for the hoe
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local full_name = data_table.full_name
    local orig_name = data_table.orig_name
    local def_table = data_table.def_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode

    local ingredient = def_table.ingredient

    -- Check def_table
    if def_table.description == nil then
        def_table.description = S("Hoe")
    end

    if def_table.inventory_image == nil then
        def_table.inventory_image = "unilib_unknown.png"
    end

    if def_table.max_uses == nil then
        def_table.max_uses = 30
    end

    -- Register the tool
    unilib.register_tool(full_name, orig_name, replace_mode, {
        description = def_table.description,
        inventory_image = def_table.inventory_image,
        groups = def_table.groups,
        sound = {breaks = "unilib_tool_breaks"},

        on_use = function(itemstack, user, pointed_thing)
            return on_use_hoe(itemstack, user, pointed_thing, def_table.max_uses)
        end,
    })

    -- Register its recipe
    if def_table.recipe then

        unilib.register_craft({
            output = full_name,
            recipe = def_table.recipe
        })

    elseif ingredient ~= nil then

        unilib.register_craft({
            output = full_name,
            recipe = {
                {ingredient, ingredient},
                {"", "group:stick"},
                {"", "group:stick"}
            }
        })

        if unilib.mtgame_tweak_flag then

            -- (Mirror image craft recipe)
            unilib.register_craft({
                output = full_name,
                recipe = {
                    {"", ingredient, ingredient},
                    {"", "group:stick", ""},
                    {"", "group:stick", ""}
                }
            })

        end

    end

    return full_name

end

---------------------------------------------------------------------------------------------------
-- Use scythes (works on crops and produce only)
---------------------------------------------------------------------------------------------------

local function get_seed_name(grow_name)

    -- Adapted from sickles/api.lua
    -- Converts a crop/produce node with the growth stage already removed (e.g.
    --      "unilib:crop_wheat_grow") into the full name of the equivalent seed (e.g.
    --      "unilib:crop_wheat_seed") or harvested produce (e.g. "unilib:produce_artichoke_harvest")

    local mod_name, item_name = unilib.split_name(grow_name)
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
    local node = minetest.get_node(pos)

    local data_table = unilib.grow_stage_table[node.name]
    if data_table == nil or
            data_table.stage == 0 or
            data_table.stage < data_table.stage_max or
            data_table.mode == "other" or
            unilib.tool_no_scythe_table[node.name] ~= nil then
        return false
    end

    if minetest.is_protected(pos, playername) then

        minetest.record_protection_violation(pos, playername)
        return false

    end

    minetest.node_dig(pos, node, player)
    minetest.sound_play("unilib_dig_snappy", {pos = pos, gain = 0.5, max_hear_distance = 8}, true)

    minetest.after(0, function()

        local invref = player:get_inventory()
        local seed_name = get_seed_name(data_table.base_name)
        if minetest.get_node(pos).name ~= "air" or
                not invref:contains_item("main", seed_name) then
            return true
        end

        if not unilib.is_creative(playername) then
            invref:remove_item("main", seed_name)
        end

        if data_table.mode == "mtgame" then

            -- Crops created by a call to unilib.register_crop_mtgame()
            minetest.set_node(pos, {name = seed_name, param2 = 1})
            -- N.B. The code in ../lib/shared/crops.lua uses the same tweak as this
--            minetest.get_node_timer(pos):start(math.random(166, 286))
            minetest.get_node_timer(pos):start(
                math.random(
                    unilib.crop_produce_grow_default,
                    (unilib.crop_produce_grow_default * 5 / 3)
                )
            )

        else

            -- Crops created by a call to unilib.register_crop_fredo()
            -- Produce created by a call to unilib.register_produce_fredo()
            local full_name = data_table.base_name .. "_1"
            local crop_def = minetest.registered_nodes[full_name]
            if crop_def == nil then
                return
            end

            minetest.set_node(pos, {name = full_name, param2 = crop_def.place_param2})

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
    if minetest.is_protected(pos, name) then
        return
    end

    local node = minetest.get_node_or_nil(pos)
    if not node then
        return
    end

    local def = minetest.registered_nodes[node.name]
    if not def then
        return
    end

    if not def.drop or not def.groups or not def.groups.plant then
        return
    end

    local drops = minetest.get_node_drops(node.name, "")
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
        if unilib.tool_no_scythe_table[dropped_item] ~= nil then
            dropped_item = nil
        end

        if dropped_item then

            local obj = minetest.add_item(pos, dropped_item)

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
    minetest.sound_play("unilib_grass_footstep", {pos = pos, gain = 1.0})

    local replace = grow_name .. "_1"

    if minetest.registered_nodes[replace] then

        local p2 = minetest.registered_nodes[replace].place_param2 or 1
        minetest.set_node(pos, {name = replace, param2 = p2})

    else

        minetest.set_node(pos, {name = "air"})

    end

    if not unilib.is_creative(name) then

        itemstack:add_wear(max_item_wear / default_basic_scythe_uses)
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
        local now = minetest.get_gametime()
        meta:set_float("last_punch", now)
        pointed_thing.ref:punch(user, now - last_punch, tool_capabilities)

    end

    if pointed_thing.type ~= "node" then

        -- ...in which case, we give up
        return

    end

    local max_uses = unilib.get_group(itemdef, "scythe_uses") or default_advanced_scythe_uses
    local range = (unilib.get_group(itemdef, "scythe") or 1) - 1
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
        local positions = minetest.find_nodes_in_area(pos1, pos2, "group:plant")
        for _, check_pos in ipairs(positions) do

            if pos ~= check_pos then
                harvest_and_replant(check_pos, user)
            end

        end

    end

    itemstack:add_wear(math.ceil(max_item_wear / (max_uses - 1)))
    return itemstack

end

function unilib.use_scythe(itemstack, user, pointed_thing)

    if not unilib.sickles_replant_flag then

        -- From farming_redo mod
        return use_basic_scythe(itemstack, user, pointed_thing)

    else

        -- From sickles mod
        return use_advanced_scythe(itemstack, user, pointed_thing)

    end

end

---------------------------------------------------------------------------------------------------
-- Use sickles (works on compatible items only)
---------------------------------------------------------------------------------------------------

local function get_wielded_item(player)

    -- Adapted from sickles/api.lua, get_wielded_item()

    if not minetest.is_player(player) then
        return
    end

    local itemstack = player:get_wielded_item()
    if itemstack == nil then
        return
    else
        return itemstack
    end

end

function unilib.register_trimmable(full_name, trim_name)

    -- Adapted from sickles/api.lua, sickles.register_trimmable()
    -- Modifies the definition of the "full_name" node, so it can be trimmed with a sickle
    --      (replacing the original node with "trim_name")
    -- In the original mod, this was only used with crops (and not with produce)

    local def = minetest.registered_nodes[full_name]
    if def == nil then
        return
    end

    local handler = def.after_dig_node
    unilib.override_item(full_name, {

        after_dig_node = function(pos, old_node, old_metadata, digger)

            local itemstack = get_wielded_item(digger)
            local itemdef = itemstack:get_definition()
            local level = unilib.get_group(itemdef, "sickle")
            if level == 0 then

                if handler ~= nil then
                    return handler(pos, old_node, old_metadata, digger)
                else
                    return
                end

            end

            local param2 = minetest.registered_nodes[trim_name].place_param2
            minetest.set_node(pos, { name = trim_name, param2 = param2 })

        end

    })

end

function unilib.register_cuttable(full_name, cut_name, drop_name)

    -- Adapted from sickles/api.lua, sickles.register_cuttable()
    -- Modifies the definition of the "full_name" node, so it can be cut with a sickle
    --      (replacing the original node with "cut_name"), and dropping the node "drop_name"
    -- In the original mod, this was used with a range of items from different mods, such as
    --      dirts with turf, mossy cobbles, etc

    local def = minetest.registered_nodes[full_name]
    if def == nil then
        return
    end

    local default_handler = def.on_punch or minetest.node_punch
    unilib.override_item(full_name, {

        on_punch = function(pos, node, puncher, pointed_thing)

            local itemstack = get_wielded_item(puncher)
            local itemdef = itemstack:get_definition()
            local level = unilib.get_group(itemdef, "sickle")
            if level == 0 then
                return default_handler(pos, node, puncher, pointed_thing)
            end

            local pname = puncher:get_player_name()
            if minetest.is_protected(pos, pname) then

                minetest.record_protection_violation(pos, pname)
                return

            end

            minetest.handle_node_drops(pos, {drop_name}, puncher)
            minetest.after(0, function()
                minetest.swap_node(pos, {name = cut_name, param2 = node.param2})
            end)

            if not unilib.is_creative(pname) then

                local max_uses = unilib.get_group(itemdef, "sickle_uses") or default_sickle_uses
                itemstack:add_wear(math.ceil(max_item_wear / (max_uses - 1)))
                if itemstack:get_count() == 0 and itemdef.sound and itemdef.sound.breaks then
                    minetest.sound_play(itemdef.sound.breaks, {pos = pos, gain = 0.5})
                end

                puncher:set_wielded_item(itemstack)

            end

        end

    })

end

---------------------------------------------------------------------------------------------------
-- Handle special shovels
---------------------------------------------------------------------------------------------------

-- Adapted from aotearoa/green_shovel.lua
local old_handle_node_drops = minetest.handle_node_drops

function minetest.handle_node_drops(pos, drops, digger)

    if not digger or unilib.special_shovel_table[digger:get_wielded_item():get_name()] == nil then
        return old_handle_node_drops(pos, drops, digger)
    end

    local nn = minetest.get_node(pos).name

    if minetest.get_item_group(nn, "crumbly") == 0 then
        return old_handle_node_drops(pos, drops, digger)
    end

    return old_handle_node_drops(pos, {ItemStack(nn)}, digger)

end

---------------------------------------------------------------------------------------------------
-- Apply toolranks
---------------------------------------------------------------------------------------------------

local function get_level(uses)

    -- Adapted from toolranks/init.lua

    if type(uses) == "number" and uses > 0 then

        if not unilib.toolranks_progressive_flag then

            -- Simple levelling: all levels are equal
            local this_level = math.floor(uses / unilib.toolranks_nodes_per_level)
            if this_level >= unilib.toolranks_max_levels then
                return unilib.toolranks_max_levels, 0
            else
                return this_level, ((this_level + 1) * unilib.toolranks_nodes_per_level) - uses
            end

        else

            -- Progressive level: each level is 50% harder than the previous one
            for i = 0, (unilib.toolranks_max_levels - 1) do

                if uses < progressive_table[i] then
                    return i, progressive_table[i] - uses
                end

            end

            -- Tool is fully levelled-up
            return unilib.toolranks_max_levels, 0

        end

    else

        return 0, 0

    end

end

local function create_description(old_description, tool_type, uses)

    -- Adapted from toolranks/init.lua
    -- Modified to prevent colours bleeding into the subsequent lines (which is a problem, if any
    --      part of the code wants to use fewer lines)

    local level, to_go = get_level(uses)

    if not unilib.toolranks_countdown_flag or to_go == 0 then

        return S(
            "@1@2@3\n",
            colour_table.green,
            old_description,
            colour_table.white
        ) .. S(
            "@1Level @2 @3@4\n",
            colour_table.gold,
            level,
            S(tool_type),
            colour_table.white
        ) .. S(
            "@1@Nodes dug: @2@3",
            colour_table.grey,
            (type(uses) == "number" and uses or 0),
            colour_table.white
        )

    else

        return S(
            "@1@2@3\n",
            colour_table.green,
            old_description,
            colour_table.white
        ) .. S(
            "@1Level @2 @3@4\n",
            colour_table.gold,
            level,
            S(tool_type),
            colour_table.white
        ) .. S(
            "@1@Nodes dug: @2@3\n",
            colour_table.grey,
            (type(uses) == "number" and uses or 0),
            colour_table.white
        ) .. S(
            "@1(@2 for next level)@3",
            colour_table.grey,
            to_go,
            colour_table.white
        )

    end

end

local function toolranks_after_use(itemstack, user, node, digparams)

    local pname = user:get_player_name()
    if not pname or unilib.is_creative(pname) then
        return itemstack
    end

    local itemmeta = itemstack:get_meta()
    local itemdef = itemstack:get_definition()
    local itemdesc = itemdef.original_description or ""
    local dugnodes = tonumber(itemmeta:get_string("dug")) or 0
    local lastlevel = tonumber(itemmeta:get_string("lastlevel")) or 0
--    local most_digs = mod_storage:get_int("most_digs") or 0
--    local most_digs_user = mod_storage:get_string("most_digs_user") or 0
    local most_digs_count = tonumber(unilib.get_mod_attribute("tools_most_digs_count")) or 0
    local most_digs_player = unilib.get_mod_attribute("tools_most_digs_player") or 0

    -- Only nodes that wear out the tool count towards levelling up
    if digparams.wear > 0 then

        dugnodes = dugnodes + 1
        itemmeta:set_string("dug", dugnodes)

    end

    if dugnodes > most_digs_count then

        if unilib.toolranks_announce_flag and most_digs_player ~= pname then

            minetest.chat_send_all(S(
                "Most advanced tool is now a @1@2@3 owned by @4 with @5 uses.",
                colour_table.green,
                itemdesc,
                colour_table.white,
                pname,
                dugnodes
            ))

        end

        unilib.set_mod_attribute("tools_most_digs_count", dugnodes)
        unilib.set_mod_attribute("tools_most_digs_player", pname)

    end

    if itemstack:get_wear() > 60135 then

        -- (This code replaces the code in the generic unilib.tool_after_use() function above)
        minetest.chat_send_player(
            user:get_player_name(),
            S("Your @1 is about to break!", itemdef.tool_type)
        )

        minetest.sound_play("unilib_tool_breaks", {to_player = pname, gain = 2.0})

    end

    local level, to_go = get_level(dugnodes)
    if lastlevel < level then

        if level >= unilib.toolranks_max_levels then

            minetest.chat_send_player(
                user:get_player_name(),
                S(
                    "Your @1@2@3 just reached its maximum level!",
                    colour_table.green,
                    itemdef.tool_type,
                    colour_table.white
                )
            )

        else

            minetest.chat_send_player(
                user:get_player_name(),
                S(
                    "Your @1@2@3 just levelled up!",
                    colour_table.green,
                    itemdef.tool_type,
                    colour_table.white
                )
            )

        end

        minetest.sound_play("unilib_tool_level_up", {to_player = pname, gain = 2.0})

        -- Make tool better by modifying tool_capabilities (if defined)
        if itemdef.tool_capabilities then

            local speed_multiplier =
                1 + (level * level_multiplier * (unilib.toolranks_speed_multiplier - 1))
            local use_multiplier =
                1 + (level * level_multiplier * (unilib.toolranks_use_multiplier - 1))
            local caps = table.copy(itemdef.tool_capabilities)

            caps.full_punch_interval =
                caps.full_punch_interval and (caps.full_punch_interval / speed_multiplier)
            caps.punch_attack_uses =
                caps.punch_attack_uses and (caps.punch_attack_uses * use_multiplier)

            for _,c in pairs(caps.groupcaps) do

                c.uses = c.uses * use_multiplier
                for i,t in ipairs(c.times) do
                    c.times[i] = t / speed_multiplier
                end

            end

            itemmeta:set_tool_capabilities(caps)

        end

    end

    itemmeta:set_string("lastlevel", level)
    itemmeta:set_string("description", create_description(itemdesc, itemdef.tool_type, dugnodes))
    itemstack:add_wear(digparams.wear)

    return itemstack

end

function unilib.apply_toolranks(full_name, tool_type)

    -- Adapted from toolranks/init.lua
    -- Applies toolranks to the specified tool (if toolranks are enabled in general)
    --
    -- Args:
    --      full_name (str): e.g. "unilib:tool_pick_stone"
    --      tool_type (str): a short, translatable description of the tool type; a string in lower-
    --          case and in English, e.g. "axe", "shovel", "pickaxe"

    if unilib.toolranks_enable_flag then

        local old_description = ItemStack(full_name):get_definition().description
        if tool_type == nil or tool_type == "" then
            tool_type = "tool"
        end

        unilib.override_item(full_name, {
            description = create_description(old_description, tool_type),

            original_description = old_description,
            tool_type = tool_type,

            after_use = toolranks_after_use,
        })

    end

end
