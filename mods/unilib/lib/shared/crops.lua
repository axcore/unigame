---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- crops.lua
--      Set up shared functions for items in the "crop" and "produce" categories
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Variables for code imported from farming_redo
--
-- Table of data for each growth stage of a crop/produce item, initially compiled in a call from
--      ../lib/system/import_pkg.lua to unilib.register_crop_and_produce_growth()
-- Keys in the table are every growth stage created in calls unilib.register_crop_fredo() and
--      unilib.register_produce_fredo(). The corresponding value is a table of data to handle growth
--      from the current stage to the subsequent ones
--
-- For example:
--      fredo_grow_table["unilib:produce_artichoke_grow_1"] = {
--          full_name = "unilib:produce_artichoke_grow_1",
--          grow_name = "unilib:produce_artichoke_grow",
--          stage = 1,
--          remaining_list = {
--              [1] = "unilib:produce_artichoke_grow_2",
--              [2] = "unilib:produce_artichoke_grow_3",
--              [3] = "unilib:produce_artichoke_grow_4",
--              [4] = "unilib:produce_artichoke_grow_5",
--          },
--      }
--
-- ...and everything up to:
--      fredo_grow_table["unilib:produce_artichoke_grow_5"] = {
--          full_name = "unilib:produce_artichoke_grow_5",
--          grow_name = "unilib:produce_artichoke_grow",
--          stage = 5,
--          remaining_list = {},
--      }
local fredo_grow_table = {}
-- List of items to be added to that table, matching the grow_name field, e.g.
--      { "unilib:crop_rye_grow", "unilib:produce_artichoke_grow" }
-- Compiled in calls to unilib.register_crop_fredo() and unilib.register_produce_fredo()
local fredo_grow_list = {}
-- Values used to set a semi-random time period for each growth stage in .update_growth_timer()
local stage_length_avg = tonumber(unilib.crop_produce_grow_default) or 160
local stage_length_dev = stage_length_avg / 6
-- Default values for the minimum and maximum light required to grow crops/produce, in case the
--      crop/produce itself doesn't specify those values
-- Note that the maximum value here is MORE than unilib.light_max (default value: 14)
local farming_max_light = 15
local farming_min_light = unilib.light_min_grow_crop
-- Values used by .get_time_of_day_or_night()
local time_speed = tonumber(minetest.settings:get("time_speed")) or 72
local secs_per_cycle = (time_speed > 0 and (24 * 60 * 60) / time_speed) or 0

---------------------------------------------------------------------------------------------------
-- Notes
---------------------------------------------------------------------------------------------------

-- Packages providing crops can be divided into two categories - "crop" and "produce" (see
--      STANDARDS.md for a complete list of categories)
-- "crop" items have three forms: a plantable seed, which turns into a growing plant when placed
--      (with several growth stages), and a craftitem generated when the plant is "harvested"
-- "produce" items have a harvested craftitem which also acts as a seed (turns into a growing plant
--      when placed)
--
-- This file contains code from minetest_game/farming and farming_redo. "crop"/"produce" packages
--      can use one or the other, for example by calling unilib.register_crop_mtgame(),
--      unilib.register_crop_fredo() or unilib.register_produce_fredo()
-- Note that packages can define everything themselves, avoiding any calls to
--      unilib.register_crop_mtgame() etc, when that's convenient (see the "produce-cocoa" package
--      for a working example)
--
-- The code imported from farming_redo is somewhat complex, this is a brief summary of how it works:
--
-- 1. The initial call to unilib.register_crop_fredo() or unilib.register_produce_fredo()
--      populates a basic list of growable plants, "fredo_grow_list"
--      - Items in this list are in the form "unilib:crop_rye_grow", "unilib:produce_artichoke_grow"
--      - The plant nodes actually created have a numeric component, e.g. the first growth stage
--          would be "unilib:produce_artichoke_grow_1" and the final growth stage might be
--          "unilib:produce_artichoke_grow_5"
-- 2. ../lib/system/import_pkg.lua, during its finalisation stage, calls
--      unilib.register_crop_and_produce_growth() to convert "fredo_grow_list" into a table,
--      "fredo_grow_table"
--          - The table includes entries for every growth stage, for example five entries for
--              artichokes
--          - (The original farming_redo code checked every registered node for suitability to be
--              entered into the equivalent table, but unilib doesn't do that)
-- 3. unilib.register_crop_and_produce_growth() calls .register_growth_stages(), which then calls
--      itself recursively, in order to fully populate the table
-- 4. The call to .register_growth_stages() also overrides the Minetest node definition for every
--      growth stage to set up a timer
--          - It provides a new .on_construct(), which calls .prepare_growth_callback()
--              - This calls .update_growth_timer() to start the timer, if there are any more growth
--                  stages left
--          - It provides a new .on_timer(), which calls .do_growth_callback()
--              - This swaps the Minetest node for the next growth stage, if conditions are right
--                  (e.g. there is enough light)
--      -   - It provides a new .on_destruct(), which stops the timer
-- 5. Note that some functions have an argument "arg", which can be either a node name or a
--      standard Minetest position table. This is a consequence of how the old farming_redo code
--      used to work
-- 6. There is an ABM in ../lib/system/abms.lua that calls unilib.prepare_growth_callback() every
--      five minutes, in case any growth stages have been missed

---------------------------------------------------------------------------------------------------
-- Local functions (for crops using minetest_game/farming code)
---------------------------------------------------------------------------------------------------

local function tick(pos)

    -- Adapted from farming/api.lua

    -- How often node timers for crops will tick, +/- some random value
    if not unilib.mtgame_tweak_flag then

--      minetest.get_node_timer(pos):start(math.random(166, 286))
        minetest.get_node_timer(pos):start(
            math.random(stage_length_avg, (stage_length_avg * 5 / 3))
        )

    else

        -- Use the same algorithm used in farming_redo (reproduced below in update_growth_timer() )
        local stage_length = unilib.statistics_normal(stage_length_avg, stage_length_dev)
        stage_length = unilib.clamp_to_min_max(
            stage_length, 0.5 * stage_length_avg,
            3.0 * stage_length_avg
        )
        minetest.get_node_timer(pos):start(stage_length, -0.5 * math.random() * stage_length_avg)

    end

end

local function tick_again(pos)

    -- Adapted from farming/api.lua

    -- How often a growth failure tick is retried (e.g. while too dark)
    minetest.get_node_timer(pos):start(math.random(40, 80))

end

local function grow_crop(pos, elapsed)

    -- Adapted from farming/api.lua

    local node = minetest.get_node(pos)
    local full_name = node.name
    local def_table = minetest.registered_nodes[full_name]

    if not def_table.next_plant then

        -- Disable timer for fully grown crop
        return

    end

    -- Grow seed
    if minetest.get_item_group(node.name, "seed") and def_table.fertility then

        local soil_node = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})

        if not soil_node then

            tick_again(pos)
            return

        end

        -- A check for light is omitted, we assume seeds can germinate in the dark
        for _, v in pairs(def_table.fertility) do

            if minetest.get_item_group(soil_node.name, v) ~= 0 then

                local placenode = {name = def_table.next_plant}
                if def_table.place_param2 then
                    placenode.param2 = def_table.place_param2
                end

                minetest.swap_node(pos, placenode)

                if minetest.registered_nodes[def_table.next_plant].next_plant then

                    tick(pos)
                    return

                end

            end

        end

        return

    end

    -- Check if on wet soil
    local below = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})
    if minetest.get_item_group(below.name, "soil") < 3 then

        tick_again(pos)
        return

    end

    -- Check light
    local light = minetest.get_node_light(pos)
    if not light or light < def_table.minlight or light > def_table.maxlight then

        tick_again(pos)
        return

    end

    -- Grow the crop
    local placenode = {name = def_table.next_plant}
    if def_table.place_param2 then
        placenode.param2 = def_table.place_param2
    end

    minetest.swap_node(pos, placenode)

    -- New timer needed?
    if minetest.registered_nodes[def_table.next_plant].next_plant then
        tick(pos)
    end

    return

end

---------------------------------------------------------------------------------------------------
-- Local functions (for crops/produce using farming_redo code)
---------------------------------------------------------------------------------------------------

local function get_time_of_day_or_night(dt, count_day)

    -- Adapted from farming_redo/init.lua, was .day_or_night_time()
    -- Return the amount of day or night that has elapsed
    -- dt is time elapsed, count_day if true counts day, otherwise night

    local t_day = minetest.get_timeofday()
    local t1_day = t_day - dt / secs_per_cycle
    -- t1_c < t2_c and t2_c always in [0, 1)
    local t1_c, t2_c

    if count_day then

        if t_day < 0.25 then

            t1_c = t1_day + 0.75    -- Relative to sunup, yesterday
            t2_c = t_day + 0.75

        else

            t1_c = t1_day - 0.25    -- Relative to sunup, today
            t2_c = t_day - 0.25

        end

    else

        if t_day < 0.75 then

            t1_c = t1_day + 0.25    -- Relative to sundown, yesterday
            t2_c = t_day + 0.25

        else

            t1_c = t1_day - 0.75    -- Relative to sundown, today
            t2_c = t_day - 0.75

        end

    end

    -- This cycle
    local dt_c = unilib.clamp_to_min_max(t2_c, 0, 0.5) - unilib.clamp_to_min_max(t1_c, 0, 0.5)

    if t1_c < -0.5 then

        local nc = math.floor(-t1_c)
        t1_c = t1_c + nc
        dt_c = dt_c + 0.5 * nc + unilib.clamp_to_min_max(-t1_c - 0.5, 0, 0.5)

    end

    return dt_c * secs_per_cycle

end

local function get_grow_name_and_stage(arg)

    -- Adapted from farming_redo/init.lua, was .plant_name_stage()
    -- "arg" is either the full_name of a node (e.g. "unilib:produce_artichoke_grow_1"), or the
    --      position coordinates where such a node can be found
    -- Extracts the "grow_name" (e.g. "unilib:produce_artichoke_grow") and numerical (e.g. "1")
    --      components, and returns them

    local name

    if type(arg) == "table" then

        if arg.name then

            name = arg.name

        elseif arg.x and arg.y and arg.z then

            arg = minetest.get_node_or_nil(arg)
            name = arg and arg.name

        end

    else

        name = tostring(arg)

    end

    if not name or name == "ignore" then
        return nil
    end

    local sep_pos = name:find("_[^_]+$")
    if sep_pos and sep_pos > 1 then

        local stage = tonumber(name:sub(sep_pos + 1))

        if stage and stage >= 0 then

            -- Found a node full_name in the form "unilib:produce_artichoke_grow_1"
            return name:sub(1, sep_pos - 1), stage

        end

    else

        -- Did not find a node full_name in the form "unilib:produce_artichoke_grow_1"
        return name, 0

    end

end

local function register_growth_stages(grow_name, stage, force_last_flag)

    -- Adapted from farming_redo/init.lua, was .reg_plant_stages()
    -- Initially called by unilib.register_crop_and_produce_growth(), and then by
    --      .register_crop_or_produce() and this function recursively, in order to populate
    --      "fredo_grow_table"
    --
    -- Args:
    --      grow_name (str): e.g. "unilib:produce_artichoke_grow"
    --      stage (int): e.g. 1
    --      force_last_flag (bool): If true, "stage" is the last growth stage for this crop/produce

    local full_name = grow_name and grow_name .. "_" .. stage
    local def_table = full_name and minetest.registered_nodes[full_name]
    if not def_table then

        -- No such node
        return nil

    end

    local mini_table = fredo_grow_table[full_name]
    if mini_table then

        -- Node already processed by a call to this function
        return mini_table

    end

    if minetest.get_item_group(full_name, "growing") > 0 then

        -- Call this function recursively for each subsequent growth stage
        local next_stage_table = register_growth_stages(grow_name, stage + 1, true)
        local remaining_list = (
            next_stage_table and
                    {next_stage_table.full_name, unpack(next_stage_table.remaining_list)}
            ) or {}

        mini_table = {
            full_name = full_name,
            grow_name = grow_name,
            remaining_list = remaining_list,
            stage = stage,
        }

        if #remaining_list > 0 then

            local old_construct = def_table.on_construct
            local old_destruct = def_table.on_destruct

            unilib.override_item(full_name, {
                on_construct = function(pos)

                    if old_construct then
                        old_construct(pos)
                    end

                    unilib.prepare_growth_callback(pos)

                end,

                on_destruct = function(pos)

                    minetest.get_node_timer(pos):stop()

                    if old_destruct then
                        old_destruct(pos)
                    end

                end,

                on_timer = function(pos, elapsed)
                    return unilib.do_growth_callback(pos, elapsed, full_name)
                end,
            })

        end

    elseif force_last_flag then

        mini_table = {
            full_name = full_name,
            grow_name = grow_name,
            remaining_list = {},
            stage = stage,
        }

    else

        return nil

    end

    fredo_grow_table[full_name] = mini_table

    return mini_table

end

local function register_crop_or_produce(arg)

    -- Adapted from farming_redo/init.lua, was .register_plant_node()
    -- Called by unilib.handle_growth()
    -- "arg" is either the full_name of a node (e.g. "unilib:produce_artichoke_grow_1"), or the
    --      position coordinates where such a node can be found
    -- Calls .register_growth_stages(), which adds all growth stages for that node to
    --      "fredo_grow_table"
    -- Then returns two values. Firstly, if "arg" is something like
    --      "unilib:produce_cabbage_normal_grow_1", it has been entered as a key in
    --      "fredo_grow_table"; returns the mini_table that is the corresponding value. Secondly,
    --      returns the number of growth stages remaining for that item (cabbages have 6 growth
    --      stages, so for the first cabbage growth stage, returns 5)

    local grow_name, stage = get_grow_name_and_stage(arg)
    if grow_name then

        local mini_table = register_growth_stages(grow_name, stage, false)
        return mini_table and #mini_table.remaining_list

    else

        return nil

    end

end

local function update_growth_timer(pos, remaining_list)

    -- Adapted from farming_redo/init.lua, was farming.set_growing()
    -- Called by unilib.prepare_growth_callback()
    -- Starts/stops a Minetest timer to convert the node at position "pos" to its next growth stage,
    --      specified by the first item in "remaining_list"

    if not remaining_list then
        return
    end

    local timer = minetest.get_node_timer(pos)

    if remaining_list > 0 then

        if not timer:is_started() then

            local stage_length = unilib.statistics_normal(stage_length_avg, stage_length_dev)
            stage_length = unilib.clamp_to_min_max(
                stage_length,
                0.5 * stage_length_avg,
                3.0 * stage_length_avg
            )
            timer:set(stage_length, -0.5 * math.random() * stage_length_avg)

        end

    elseif timer:is_started() then

        timer:stop()

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (for everything)
---------------------------------------------------------------------------------------------------

function unilib.insert_into_grow_list(data_table)

    -- Original to unilib, and called by any package that doesn't want to call
    --      unilib.register_crop_mtgame(), unilib.register_crop_fredo() or
    --      unilib.register_produce_fredo() (for example the "produce_cocoa_jungle" package)
    -- Updates the table of basic crop/produce items, so that the later call to
    --      unilib.register_crop_and_produce_growth() can use it
    --
    -- data_table compulsory fields:
    --      grow_name (str): e.g. "unilib:produce_cocoa_jungle_grow"
    --      harvest_full_name (str): e.g. "unilib:produce_cocoa_jungle_harvest"
    --      steps (int): The number of growth stages (minimum 1)
    --
    -- data_table optional fields:
    --      fertility_list (list): If specified, stored as the .fertility field in each growth stage

    local grow_name = data_table.grow_name
    local harvest_full_name = data_table.harvest_full_name
    local steps = data_table.steps

    local fertility_list = data_table.fertility_list or nil

    for i = 1, steps do

        local group_table = minetest.registered_nodes[grow_name .. "_" .. i].groups

        if fertility_list ~= nil then

            for k, v in pairs(fertility_list) do
                group_table[v] = 1
            end

        end

        local next_plant = nil
        if i < steps then
            next_plant = grow_name .. "_" .. (i + 1)
        end

        unilib.override_item(grow_name .. "_" .. i, {
            fertility = fertility_list,
            groups = group_table,
            next_plant = next_plant,
        })

    end


    table.insert(fredo_grow_list, grow_name)

end

function unilib.refill_seed(player, placed_full_name, index)

    -- Adapted from farming_redo/init.lua, was farming.refill_plant()
    -- Called from unilib.place_item_as_seed()
    -- If possible, move additional seeds into the player's current inventory slot from somewhere
    --      else in their inventory

    local inv = player:get_inventory()
    local old_stack = inv:get_stack("main", index)

    if old_stack:get_name() ~= "" then
        return
    end

    for i, stack in ipairs(inv:get_list("main")) do

        if stack:get_name() == placed_full_name and i ~= index then

            inv:set_stack("main", index, stack)
            stack:clear()
            inv:set_stack("main", i, stack)

            return

        end

    end

end

function unilib.place_item_as_seed(itemstack, placer, pointed_thing, placed_full_name, farming_mode)

    -- Adapted from farming/api.lua and farming_redo/init.lua (was farming.place_seed() in both)
    -- Called from .on_place() in the node definition created by unilib.register_crop_mtgame(),
    --      unilib.register_produce_fredo(), etc
    -- Currently, the value of "farming_mode" is either "mtgame" or "fredo"
    -- farming_redo's version of this function returned nil, rather than an ItemStack; I think it
    --      makes no difference, though

    local pt = pointed_thing
    -- Check if pointing at a node
    if not pt or pt.type ~= "node" then
        return itemstack
    end

    -- Is the player clicking on something with its own custom .on_place()?
    local under = minetest.get_node(pt.under)
    local def_table = minetest.registered_nodes[under.name]
    if placer and itemstack and def_table and def_table.on_rightclick then
        return def_table.on_rightclick(pt.under, under, placer, itemstack, pt)
    end

    -- Check if pointing at the top of the node
    local above = minetest.get_node(pt.above)
    if pt.above.y ~= pt.under.y + 1 then
        return itemstack
    end

    -- Check that the nodes are registered
    if not minetest.registered_nodes[under.name] or
            not minetest.registered_nodes[above.name] then
        return itemstack
    end

    -- Check if the above node can be replaced, that the player is pointing at soil, and avoid the
    --      multiple seed placement bug
    if not minetest.registered_nodes[above.name].buildable_to or
            minetest.get_item_group(under.name, "soil") < 2 or
            minetest.get_item_group(above.name, "plant") ~= 0 then
        return itemstack
    end

    -- Check protection. farming_redo has no check for pt.under
    local player_name = placer and placer:get_player_name() or ""
    if farming_mode == "mtgame" and minetest.is_protected(pt.under, player_name) then

        minetest.record_protection_violation(pt.under, player_name)
        return

    elseif minetest.is_protected(pt.above, player_name) then

        minetest.record_protection_violation(pt.above, player_name)
        return

    end

    -- Not protected, so add the node and remove one item from the itemstack
    if farming_mode == "mtgame" then

        -- Original code from minetest_game/farming, using the .tick() function above to grow the
        --      crop
        unilib.log(
            "action",
            player_name .. " places node " .. placed_full_name .. " at " ..
                    minetest.pos_to_string(pt.above)
        )

        minetest.add_node(pt.above, {name = placed_full_name, param2 = 1})
        tick(pt.above)

    elseif farming_mode == "fredo" then

        -- Code from farming_redo, using unilib.do_growth_callback() to grow the crop/produce
        unilib.log(
            "action",
            player_name .. " places node " .. placed_full_name .. " at " ..
                    minetest.pos_to_string(pt.above)
        )

        local p2 = minetest.registered_nodes[placed_full_name].place_param2 or 1
        minetest.set_node(pt.above, {name = placed_full_name, param2 = p2})

        minetest.sound_play("unilib_place_node", {pos = pt.above, gain = 1.0})

    else

        unilib.show_error("unilib.place_item_as_seed(): Invalid farming mode", farming_mode)
        return itemstack

    end

    if placer and itemstack and not unilib.is_creative(placer:get_player_name()) then

        local name = itemstack:get_name()
        itemstack:take_item()

        -- If possible, move additional seeds into the player's current inventory slot
        if itemstack:get_count() == 0 then

            minetest.after(
                0.10,
                unilib.refill_seed,
                placer,
                name,
                placer:get_wield_index()
            )

        end

        return itemstack

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (for crops/produce using farming_redo code)
---------------------------------------------------------------------------------------------------

function unilib.do_growth_callback(pos, elapsed, full_name)

    -- Adapted from farming_redo/init.lua, was farming.plant_growth_timer()
    -- Called by the timer callback in .register_growth_stages()
    -- Timer function that grows crops/produce under the right conditions
    -- "pos" is the position table of the node "full_name", e.g. "unilib:produce_artichoke_grow_1".
    --      "elapsed" is the time in seconds since the timer last ticked over
    -- Returns true to continue the timer, or false to disable it

    local mini_table = fredo_grow_table[full_name]
    if mini_table == nil then
        return false
    end

    local max_growth = #mini_table.remaining_list
    if max_growth <= 0 then
        return false
    end

    -- If crops have the {growing = 1} group then a custom function can be used to check for growth
    local check_func = minetest.registered_nodes[full_name].growth_check
    if check_func and check_func(pos, full_name) then
        return true
    end

    -- Not in original farming_redo code (and based on code in minetest_game/farming): check that
    --      the crop's fertility groups match those of the soil on which it's growing
    -- If the .fertility field does not exist, we assume that the crop/produce has been placed on
    --      some other kind of surface (e.g. a jungle tree for the cocoa pod)
    local under = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})
    local match_flag = false
    local fertility_list = minetest.registered_nodes[full_name].fertility
    if fertility_list ~= nil then

        for _, v in ipairs(fertility_list) do

            if minetest.get_item_group(under.name, v) ~= 0 then

                match_flag = true
                break

            end

        end

        if not match_flag then
            return true
        end

        -- Otherwise, check for wet soil beneath the crop/produce
        if minetest.get_item_group(under.name, "soil") < 3 then
            return true
        end

    end

    -- Can the crop/produce advance to the next growth stage?
    local growth
    local light_pos = {x = pos.x, y = pos.y, z = pos.z}
    local lambda = elapsed / stage_length_avg

    if lambda < 0.1 then
        return true
    end

    local min_light = minetest.registered_nodes[full_name].minlight or farming_min_light
    local max_light = minetest.registered_nodes[full_name].maxlight or farming_max_light

    if max_growth == 1 or lambda < 2.0 then

        local light = minetest.get_node_light(light_pos) or 0

        if light < min_light or light > max_light then
            return true
        end

        growth = 1

    else

        local night_light = minetest.get_node_light(light_pos, 0) or 0
        local day_light = minetest.get_node_light(light_pos, 0.5) or 0
        local night_growth = night_light >= min_light and night_light <= max_light
        local day_growth = day_light >= min_light and day_light <= max_light

        if not night_growth then

            if not day_growth then
                return true
            end

            lambda = get_time_of_day_or_night(elapsed, true) / stage_length_avg

        elseif not day_growth then

            lambda = get_time_of_day_or_night(elapsed, false) / stage_length_avg

        end

        growth = unilib.statistics_poisson(lambda, max_growth)

        if growth < 1 then
            return true
        end

    end

    if minetest.registered_nodes[mini_table.remaining_list[growth]] then

        local p2 = minetest.registered_nodes[mini_table.remaining_list[growth]].place_param2 or 1
        minetest.swap_node(pos, {name = mini_table.remaining_list[growth], param2 = p2})

    else

        return true

    end

    return growth ~= max_growth

end

function unilib.prepare_growth_callback(pos, node)

    -- Adapted from farming_redo/init.lua, was farming.handle_growth()
    -- Called by the callback in .register_growth_stages()
    -- Detects crops/produce at the specified position, starting or stopping growth timer as
    --      required
    -- "pos" is always specified; "node" is specified when called by the crop growth ABM in
    --      ../lib/system/abms.lua

    if not pos then
        return
    end

    local remaining_list = register_crop_or_produce(node or pos)
    if remaining_list then
        update_growth_timer(pos, remaining_list)
    end

end

function unilib.register_crop_and_produce_growth()

    -- Original to unilib
    -- Called from ../lib/system/import_pkg.lua during the finalisation stage
    -- Uses "fredo_grow_list" to populate "fredo_grow_table"

    for _, grow_name in ipairs(fredo_grow_list) do
        register_growth_stages(grow_name, 1, false)
    end

end

---------------------------------------------------------------------------------------------------
-- Register crops
---------------------------------------------------------------------------------------------------

function unilib.register_crop_mtgame(data_table)

    -- Adapted from farming/api.lua
    -- Creates related crop items: a seed, various growth stage items, and the harvested item
    -- Uses the growing code from minetest_game/farming
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "cotton" (used by the harvested item and growth stage items)
    --      grow_orig_name (or list): e.g. { "farming:cotton_1", "farming:cotton_2", ... }. The size
    --          of this list should match the "steps" field
    --      harvest_orig_name (str): e.g. "farming:cotton"
    --      seed_orig_name (str): e.g. "farming:seed_cotton"
    --      steps (int): e.g. 8
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      eat (int): e.g. 4 (used in the minetest.item_eat() call). If not specified, the
    --          harvested item is not eatable
    --      fertility_list (list): List of node groups for compatible soils. If not specified, the
    --          crop can grow on any soil
    --      grow_group_table (table): e.g. {attached_node = 1, flammable = 2,
    --          not_in_creative_inventory = 1, plant = 1, snappy = 3}
    --      harvest_description (str): e.g. "Cotton"
    --      harvest_group_table (table): e.g. {flammable = 2}
    --      harvest_override (str): If specified, this function does not create a harvested
    --          craftitem; instead, it uses the specified item (which must be created by the calling
    --          code)
    --      max_light (int): Maximum light required for growth. If not specified, 14 is used
    --      min_light (int): Minimum light required for growth. If not specified, 1 is used
    --      paramtype2 (str): e.g. "meshoptions". If specified, used for the seed only
    --      place_param2 (int): e.g. 3. If specified, used for the seed and growth stages
    --      seed_description (str): e.g. "Cotton Seed"
    --      seed_group_table (table): e.g. {attached_node = 1, flammable = 2, seed = 1, snappy = 3}

    local part_name = data_table.part_name
    local grow_orig_name = data_table.grow_orig_name
    local harvest_orig_name = data_table.harvest_orig_name
    local seed_orig_name = data_table.seed_orig_name
    local steps = data_table.steps

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local eat = data_table.eat or nil
    local fertility_list = data_table.fertility_list or {}
    local grow_group_table = data_table.grow_group_table or
            {attached_node = 1, flammable = 2, not_in_creative_inventory = 1, plant = 1, snappy = 3}
    local harvest_description = data_table.harvest_description or
            part_name:gsub("^%l", string.upper)
    local harvest_group_table = data_table.harvest_group_table or {flammable = 2}
    local harvest_override = data_table.harvest_override or nil
    local max_light = data_table.max_light or 14
    local min_light = data_table.min_light or 11
    local paramtype2 = data_table.paramtype2 or nil
    local place_param2 = data_table.place_param2 or nil
    local seed_description = data_table.seed_description or S("Seed")
    local seed_group_table = data_table.seed_group_table or
            {attached_node = 1, flammable = 2, seed = 1, snappy = 3}

    local grow_name = "unilib:crop_" .. part_name .. "_grow"
    local harvest_full_name = "unilib:crop_" .. part_name .. "_harvest"
    local seed_full_name = "unilib:crop_" .. part_name .. "_seed"
    local seed_img = "unilib_crop_" .. part_name .. "_seed.png"

    -- Basic checks
    if not steps then
        return
    end

    -- Register seed
    for k, v in pairs(fertility_list) do
        seed_group_table[v] = 1
    end

    unilib.register_node(seed_full_name, seed_orig_name, replace_mode, {
        description = seed_description,
        tiles = {seed_img},
        groups = seed_group_table,
        sounds = unilib.node_sound_dirt_defaults({
            dig = {name = "", gain = 0},
            dug = {name = "unilib_grass_footstep", gain = 0.2},
            place = {name = "unilib_place_node", gain = 0.25},
        }),

        drawtype = "signlike",
        fertility = fertility_list,
        inventory_image = seed_img,
        maxlight = max_light,
        minlight = min_light,
        next_plant = grow_name .. "_1",
        paramtype = "light",
        paramtype2 = "wallmounted",
        place_param2 = place_param2,   -- This isn't actually used for placement
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = seed_img,

        on_place = function(itemstack, placer, pointed_thing)

            local under = pointed_thing.under
            local node = minetest.get_node(under)
            local udef = minetest.registered_nodes[node.name]
            if udef and udef.on_rightclick and not (
                placer and
                placer:is_player() and
                placer:get_player_control().sneak
            ) then

                return udef.on_rightclick(under, node, placer, itemstack, pointed_thing) or
                        itemstack

            else

                return unilib.place_item_as_seed(
                    itemstack, placer, pointed_thing, seed_full_name, "mtgame"
                )

            end

        end,

        on_timer = grow_crop,
    })

    if harvest_override == nil then

        -- Register the harvested crop as a craftitem
        local harvest_def_table = {
            description = harvest_description,
            inventory_image = "unilib_crop_" .. part_name .. "_harvest.png",
            groups = harvest_group_table,
        }

        if eat ~= nil then
            harvest_def_table.on_use = unilib.cuisine_eat_on_use(harvest_full_name, eat)
        end

        unilib.register_craftitem(
            harvest_full_name, harvest_orig_name, replace_mode, harvest_def_table
        )

    else

        -- Use the specified harvested item
        harvest_full_name = harvest_override

    end

    -- Each crop has a group named after itself
    grow_group_table[part_name] = 1
    -- Register growth stages
    for i = 1, steps do

        local base_rarity = 1
        if steps ~= 1 then
            base_rarity = 8 - (i - 1) * 7 / (steps - 1)
        end

        -- When harvested, drop a random quantity of harvested items/seeds
        local drop_table = {
            items = {
                {items = {harvest_full_name}, rarity = base_rarity},
                {items = {harvest_full_name}, rarity = base_rarity * 2},
                {items = {seed_full_name}, rarity = base_rarity},
                {items = {seed_full_name}, rarity = base_rarity * 2},
            }
        }

        local next_plant = nil

        if i < steps then
            next_plant = grow_name .. "_" .. (i + 1)
        end

        -- Register each growth stage for the crop
        unilib.register_node(grow_name .. "_" .. i, grow_orig_name[i], replace_mode, {
            description = unilib.brackets(S("Crop"), S("Growing")),
            tiles = {"unilib_crop_" .. part_name .. "_grow_" .. i .. ".png"},
            groups = grow_group_table,
            sounds = unilib.sound_table.leaves,

            buildable_to = true,
            drawtype = "plantlike",
            drop = drop_table,
            maxlight = max_light,
            minlight = min_light,
            next_plant = next_plant,
            paramtype = "light",
            paramtype2 = paramtype2 or nil,
            place_param2 = place_param2 or nil,
            selection_box = {
                type = "fixed",
                fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
            },
            walkable = false,
            waving = 1,

            on_timer = grow_crop,
        })

    end

    -- Update global variables
    unilib.register_growing({
        base_name = grow_name,
        mode = "mtgame",
        stage_max = steps,
    })

    -- All crops are trimmable with a sickle
    unilib.register_trimmable(grow_name .. "_" .. steps, grow_name .. "_2")

end

function unilib.register_crop_fredo(data_table)

    -- Adapted from farming_redo/init.lua
    -- Creates related crop items: a seed, various growth stage items, and the harvested item
    -- Uses the growing code from farming_redo
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "rye" (used by the harvested item and growth stage items)
    --      grow_orig_name (list): e.g. { "farming:rye_1", "farming:rye_2", ... }. The size of this
    --          list should match the "steps" field
    --      harvest_orig_name (str): e.g. "farming:rye"
    --      seed_orig_name (str): e.g. "farming:seed_rye"
    --      steps (int): e.g. 8
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      eat (int): e.g. 4 (used in the minetest.item_eat() call). If not specified, the
    --          harvested item is not eatable
    --      fertility_list (list): List of node groups for compatible soils. If not specified, the
    --          crop can grow on any soil
    --      grow_group_table (table): e.g. {attached_node = 1, flammable = 2,
    --          not_in_creative_inventory = 1, plant = 1, snappy = 3}
    --      grow_list (table): List containing a sequence of mini-tables, one for each growth stage.
    --          Each mini-table can be empty, or can contain extra key-value pairs for that growth
    --          stage. The extra key-value pairs, if any, are added to the unilib.register_node()
    --          call. Note that there is no "complete_flag" field for replacing the complete node
    --          definition for the growth stage
    --      harvest_description (str): e.g. "Cotton"
    --      harvest_group_table (table): e.g. {flammable = 2}
    --      harvest_override (str): If specified, this function does not create a harvested
    --          craftitem; instead, it uses the specified item (which must be created by the calling
    --          code)
    --      max_light (int): Maximum light required for growth. If not specified, 15 is used
    --      min_light (int): Minimum light required for growth. If not specified, 12 is used
    --      no_early_drop_flag (bool): Ignored if "grow_list" is specified. Otherwise, the standard
    --          algorithm for determining growth stage drops is being used; if the flag is true,
    --          no drops are permitted at growth stages 1-3
    --      paramtype2 (str): e.g. "meshoptions". If specified, used for the seed only
    --      place_param2 (int): e.g. 3. If specified, used for the seed and growth stages
    --      seed_description (str): e.g. "Cotton Seed"
    --      seed_group_table (table): e.g. {attached_node = 1, flammable = 2, seed = 1, snappy = 3}

    local part_name = data_table.part_name
    local grow_orig_name = data_table.grow_orig_name
    local harvest_orig_name = data_table.harvest_orig_name
    local seed_orig_name = data_table.seed_orig_name
    local steps = data_table.steps

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local eat = data_table.eat or nil
    local fertility_list = data_table.fertility_list or {}
    local grow_group_table = data_table.grow_group_table or
            {attached_node = 1, flammable = 2, not_in_creative_inventory = 1, plant = 1, snappy = 3}
    local grow_list = data_table.grow_list or nil
    local harvest_description = data_table.harvest_description or
            part_name:gsub("^%l", string.upper)
    local harvest_group_table = data_table.harvest_group_table or {flammable = 2}
    local harvest_override = data_table.harvest_override or nil
    local max_light = data_table.max_light or 15
    local min_light = data_table.min_light or 12
    local no_early_drop_flag = data_table.no_early_drop_flag or false
    local paramtype2 = data_table.paramtype2 or nil
    local place_param2 = data_table.place_param2 or nil
    local seed_description = data_table.seed_description or S("Seed")
    local seed_group_table = data_table.seed_group_table or
            {attached_node = 1, flammable = 2, seed = 1, snappy = 3}

    local grow_name = "unilib:crop_" .. part_name .. "_grow"
    local harvest_full_name = "unilib:crop_" .. part_name .. "_harvest"
    local seed_full_name = "unilib:crop_" .. part_name .. "_seed"
    local seed_img = "unilib_crop_" .. part_name .. "_seed.png"

    -- Basic checks
    if not steps then
        return
    end

    -- Register seed
    for k, v in pairs(fertility_list) do
        seed_group_table[v] = 1
    end

    unilib.register_node(seed_full_name, seed_orig_name, replace_mode, {
        description = seed_description,
        tiles = {seed_img},
        groups = seed_group_table,
        -- (.sounds field not in farming_redo code, so use the code from minetest_game/farming)
        sounds = unilib.node_sound_dirt_defaults({
            dig = {name = "", gain = 0},
            dug = {name = "unilib_grass_footstep", gain = 0.2},
            place = {name = "unilib_place_node", gain = 0.25},
        }),

        drawtype = "signlike",
        fertility = fertility_list,
        inventory_image = seed_img,
        next_plant = grow_name .. "_1",
        paramtype = "light",
        paramtype2 = "wallmounted",
        place_param2 = place_param2 or nil,
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = seed_img,

        on_place = function(itemstack, placer, pointed_thing)

            return unilib.place_item_as_seed(
                itemstack, placer, pointed_thing, grow_name .. "_1", "fredo"
            )

        end,
    })

    if harvest_override == nil then

        -- Register the harvested crop as a craftitem
        local harvest_def_table = {
            description = harvest_description,
            inventory_image = "unilib_crop_" .. part_name .. "_harvest.png",
            groups = harvest_group_table,
        }

        if eat ~= nil then
            harvest_def_table.on_use = unilib.cuisine_eat_on_use(harvest_full_name, eat)
        end

        unilib.register_craftitem(
            harvest_full_name, harvest_orig_name, replace_mode, harvest_def_table
        )

    else

        -- Use the specified harvested item
        harvest_full_name = harvest_override

    end

    -- Register growth stages
    local grow_def_table = {
        description = unilib.brackets(S("Crop"), S("Growing")),
        -- (tiles defined below)
        -- (groups defined below)
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        fertility = fertility_list,
        maxlight = max_light,
        minlight = min_light,
        paramtype = "light",
        -- (In both cases, "or nil" is missing in the farming_redo code)
        paramtype2 = paramtype2 or nil,
        place_param2 = place_param2 or nil,
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
    }

    for i = 1, steps do

        local this_def_table = table.copy(grow_def_table)
        this_def_table.tiles = {"unilib_crop_" .. part_name .. "_grow_" .. i .. ".png"}

        -- Standard algorithm for determining growth stage drops
        local base_rarity = 1
        if steps ~= 1 then
            base_rarity = 8 - (i - 1) * 7 / (steps - 1)
        end

        -- When harvested, drop a random quantity of crops/seeds
        local drop_table = {
            items = {
                {items = {harvest_full_name}, rarity = base_rarity},
                {items = {harvest_full_name}, rarity = base_rarity * 2},
                {items = {seed_full_name}, rarity = base_rarity},
                {items = {seed_full_name}, rarity = base_rarity * 2},
            }
        }

        if no_early_drop_flag and i <= 3 then
            drop_table = {}
        end

        this_def_table.drop = drop_table

        -- (Unlike the unilib.register_crop_mtgame() code, crops don't have a growth stage named
        --      after themselves)
        local this_grow_group_table = table.copy(grow_group_table)
        if i == steps then
            this_grow_group_table.growing = 0
        else
            this_grow_group_table.growing = 1
        end

        this_def_table.groups = this_grow_group_table

        local next_plant = nil

        if i < steps then
            next_plant = grow_name .. "_" .. (i + 1)
        end

        this_def_table.next_plant = next_plant

        -- Customise this growth stage, if "grow_list" was specified
        if grow_list ~= nil and grow_list[i] ~= nil then

            if i == #grow_list then
                this_def_table.groups.growing = nil
            end

            for k, v in pairs(grow_list[i]) do
                this_def_table[k] = v
            end

        end

        unilib.register_node(
            grow_name .. "_" .. i, grow_orig_name[i], replace_mode, this_def_table
        )

    end

    -- Update the table of basic crop/produce items, so that the later call to
    --      unilib.register_crop_and_produce_growth() can use it
    table.insert(fredo_grow_list, grow_name)

    -- Update global variables
    unilib.register_growing({
        base_name = grow_name,
        mode = "fredo",
        stage_max = steps,
    })

    -- All crops are trimmable with a sickle
    unilib.register_trimmable(grow_name .. "_" .. steps, grow_name .. "_2")

end

---------------------------------------------------------------------------------------------------
-- Register produce
---------------------------------------------------------------------------------------------------

function unilib.register_produce_fredo(data_table)

    -- Adapted from farming_redo/crops/artichoke.lua
    -- Creates related produce items: various growth stage items, and the harvested produce item
    --      (which can also be placed as a seed)
    -- Uses the growing code from farming_redo
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "artichoke" (used by the harvested item and growth stage items)
    --      grow_orig_name (list): e.g. {"farming:artichoke_1", "farming:artichoke_2", ...}. The
    --          size of this list should the size of .grow_list
    --      harvest_orig_name (str): e.g. "farming:artichoke"
    --      description (str): e.g. "Artichoke"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      eat (int): e.g. 4 (used in the minetest.item_eat() call). If not specified, the
    --          harvested item is not eatable
    --      fertility_list (list): List of node groups for compatible soils. If not specified, the
    --          crop can grow on any soil
    --      grow_list (table): List containing a sequence of mini-tables, one for each growth stage.
    --          Each mini-table can be empty, or can contain extra key-value pairs for that growth
    --          stage. The extra key-value pairs, if any, are added to the unilib.register_node()
    --          call. If the mini-table contains [complete_flag] = true, then that mini-table is
    --          the complete node definition for the growth stage, replacing all other fields
    --      grow_group_table (table): Table used in the .groups field for the growth stage
    --      harvest_group_table (table): Table used in the .groups field for the harvested item
    --      max_light (int): Maximum light required for growth. If not specified,
    --          "farming_max_light" is used (default 15)
    --      min_light (int): Minimum light required for growth. If not specified,
    --          "farming_min_light" is used (default 12)
    --      no_harvest_flag (bool): If true, the harvested item is the last growth stage (e.g.
    --          unilib:produce_pumpkin_yellow_grow_8). The name of what would have been the
    --          harvested item (e.g. unilib:produce_pumpkin_yellow_harvest) is aliased onto the last
    --          growth stage
    --      seed_name (str): The full_name of an item used as the seed (e.g. pumpkins are grown by
    --          planting a pumpkin slice, unilib:produce_pumpkin_yellow_slice). If not specified,
    --          the harvested item is used as the seed (e.g. harvested artichokes can be re-planted
    --          to grow more artichokes)
    --      waving (int): e.g. 1 to make the growth stage wave in the wind

    local part_name = data_table.part_name
    local grow_orig_name = data_table.grow_orig_name
    local harvest_orig_name = data_table.harvest_orig_name
    local description = data_table.description

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local eat = data_table.eat or nil
    local fertility_list = data_table.fertility_list or {}
    local grow_list = data_table.grow_list or {{}}
    local grow_group_table = data_table.grow_group_table or {
        attached_node = 1, flammable = 2, growing = 1, not_in_creative_inventory = 1, plant = 1,
        snappy = 3,
    }
    local harvest_group_table = data_table.harvest_group_table or {flammable = 2, seed = 2}
    local max_light = data_table.max_light or farming_max_light
    local min_light = data_table.min_light or farming_min_light
    local no_harvest_flag = data_table.no_harvest_flag or false
    local seed_name = data_table.seed_name or nil
    local waving = data_table.waving or nil

    local grow_name = "unilib:produce_" .. part_name .. "_grow"
    local harvest_full_name = "unilib:produce_" .. part_name .. "_harvest"

    -- (As for seeds created in calls to unilib.register_crop_mtgame(), everything in fertility_list
    --      is added to the groups field of the growth stages)
    for k, v in pairs(fertility_list) do
        grow_group_table[v] = 1
    end

    -- Register the harvested produce item (which can also be placed as a seed)
    if not no_harvest_flag then

        local harvest_def_table = {
            description = description,
            inventory_image = "unilib_produce_" .. part_name .. "_harvest.png",
            groups = harvest_group_table,
        }

        if seed_name == nil then

            -- The harvested item is the seed
            harvest_def_table.on_place = function(itemstack, placer, pointed_thing)

                return unilib.place_item_as_seed(
                    itemstack, placer, pointed_thing, grow_name .. "_1", "fredo"
                )

            end

        end

        if eat ~= nil then
            harvest_def_table.on_use = unilib.cuisine_eat_on_use(harvest_full_name, eat)

        end

        unilib.register_craftitem(
            harvest_full_name, harvest_orig_name, replace_mode, harvest_def_table
        )

    else

        -- No separate harvested item
        -- If a craftitem has been specified as the seed, make it plantable
        if seed_name and minetest.registered_craftitems[seed_name] ~= nil then

            unilib.override_item(seed_name, {
                on_place = function(itemstack, placer, pointed_thing)

                    return unilib.place_item_as_seed(
                        itemstack, placer, pointed_thing, grow_name .. "_1", "fredo"
                    )

                end
            })

        end

    end

    -- Register growth stages
    local grow_def_table = {
        description = unilib.brackets(description, S("Growing")),
        -- (tiles defined below)
        groups = grow_group_table,
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = "",
        fertility = fertility_list,
        maxlight = max_light,
        minlight = min_light,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
    }

    if waving then
        grow_def_table.waving = waving
    end

    for i = 1, #grow_list do

        local this_def_table = table.copy(grow_def_table)

        if grow_list[i]["complete_flag"] == nil then

            this_def_table.tiles = {"unilib_produce_" .. part_name .. "_grow_" .. i .. ".png"}

            if i == #grow_list then
                this_def_table.groups.growing = nil
            end

            for k, v in pairs(grow_list[i]) do
                this_def_table[k] = v
            end

            unilib.register_node(
                grow_name .. "_" .. i, grow_orig_name[i], replace_mode, this_def_table
            )

        else

            grow_list[i]["complete_flag"] = nil
            unilib.register_node(
                grow_name .. "_" .. i, grow_orig_name[i], replace_mode, grow_list[i]
            )

        end

    end

    -- Update global variables
    unilib.register_growing({
        base_name = grow_name,
        mode = "produce",
        stage_max = #grow_list,
    })

    if no_harvest_flag and
            minetest.registered_nodes[harvest_full_name] == nil and
            minetest.registered_craftitems[harvest_full_name] == nil then

        -- No separate harvested item, so alias what would have been the harvested item's name onto
        --      the last growth stage (unless a separate harvest item has been defined by the
        --      package, e.g. in the garlic/pineapple packages)
        minetest.register_alias(harvest_full_name, grow_name .. "_" .. tostring(#grow_list))

    end

    -- Update the table of basic crop/produce items, so that the later call to
    --      unilib.register_crop_and_produce_growth() can use it
    table.insert(fredo_grow_list, grow_name)

end
