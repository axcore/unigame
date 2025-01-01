---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- farming_base.lua
--      Base API functions for farming
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Variables for code imported from farming_redo
--
-- Table of data for each growth stage of a crop/produce item, initially compiled in a call from
--      code in ../lib/system/load/load_finalisation.lua to unilib.farming.register_growth_stages()
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
-- Compiled as a result of calls to unilib.register_crop_fredo() and unilib.register_produce_fredo()
local fredo_grow_list = {}
-- Values used to set a semi-random time period for each growth stage in .update_growth_timer()
local stage_length_avg = tonumber(unilib.setting.farming_grow_default) or 160
local stage_length_dev = stage_length_avg / 6
-- Default values for the minimum and maximum light required to grow crops/produce, in case the
--      crop/produce itself doesn't specify those values
-- Note that the maximum value here is MORE than unilib.constant.light_max (default value: 14)
local farming_max_light = 15
local farming_min_light = unilib.constant.light_min_grow_crop
-- Values used by .get_time_of_day_or_night()
local time_speed = tonumber(core.settings:get("time_speed")) or 72
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
-- 2. ../lib/system/load/, during its finalisation stage, calls
--      unilib.farming.register_growth_stages() to convert "fredo_grow_list" into a table,
--      "fredo_grow_table"
--          - The table includes entries for every growth stage, for example five entries for
--              artichokes
--          - (The original farming_redo code checked every registered node for suitability to be
--              entered into the equivalent table, but unilib doesn't do that)
-- 3. unilib.farming.register_growth_stages() calls .register_growth_stages(), which then calls
--      itself recursively, in order to fully populate the table
-- 4. The call to .register_growth_stages() also overrides the Minetest node definition for every
--      growth stage to set up a timer
--          - It provides a new .on_construct(), which calls .on_timer_prepare_growth()
--              - This calls .update_growth_timer() to start the timer, if there are any more growth
--                  stages left
--          - It provides a new .on_timer(), which calls .on_timer_do_growth()
--              - This swaps the Minetest node for the next growth stage, if conditions are right
--                  (e.g. there is enough light)
--      -   - It provides a new .on_destruct(), which stops the timer
-- 5. Note that some functions have an argument "arg", which can be either a node name or a
--      standard Minetest position table. This is a consequence of how the old farming_redo code
--      used to work
-- 6. There is an ABM in the "abm_standard_crop_grow" package that calls
--      unilib.farming.on_timer_prepare_growth() every five minutes, in case any growth stages have
--      been missed

---------------------------------------------------------------------------------------------------
-- Local functions (for crops using minetest_game/farming code)
---------------------------------------------------------------------------------------------------

local function tick(pos)

    -- Adapted from farming/api.lua

    -- How often node timers for crops will tick, +/- some random value
    if not unilib.setting.mtgame_tweak_flag then

--      core.get_node_timer(pos):start(math.random(166, 286))
        core.get_node_timer(pos):start(math.random(stage_length_avg, (stage_length_avg * 5 / 3)))

    else

        -- Use the same algorithm used in farming_redo (reproduced below in update_growth_timer() )
        local stage_length =
                unilib.farming.do_standard_normal_distribution(stage_length_avg, stage_length_dev)
        stage_length = unilib.farming.clamp_to_min_max(
            stage_length, 0.5 * stage_length_avg,
            3.0 * stage_length_avg
        )

        core.get_node_timer(pos):start(stage_length, -0.5 * math.random() * stage_length_avg)

    end

end

local function tick_again(pos)

    -- Adapted from farming/api.lua

    -- How often a growth failure tick is retried (e.g. while too dark)
    core.get_node_timer(pos):start(math.random(40, 80))

end

local function crop_can_grow(pos)

    -- Adapted from farming_redo/init.lua, was farming.can_grow()

    -- Check if on wet soil
    local below = core.get_node(pos:offset(0, -1, 0))
    return core.get_item_group(below.name, "soil") >= 3

end

---------------------------------------------------------------------------------------------------
-- Local functions (for crops/produce using farming_redo code)
---------------------------------------------------------------------------------------------------

local function get_time_of_day_or_night(dt, count_day)

    -- Adapted from farming_redo/init.lua, was .day_or_night_time()
    -- Return the amount of day or night that has elapsed
    -- dt is time elapsed, count_day if true counts day, otherwise night

    local t_day = core.get_timeofday()
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
    local dt_c = unilib.farming.clamp_to_min_max(t2_c, 0, 0.5) -
            unilib.farming.clamp_to_min_max(t1_c, 0, 0.5)

    if t1_c < -0.5 then

        local nc = math.floor(-t1_c)
        t1_c = t1_c + nc
        dt_c = dt_c + 0.5 * nc + unilib.farming.clamp_to_min_max(-t1_c - 0.5, 0, 0.5)

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

            arg = core.get_node_or_nil(arg)
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
    -- Initially called by unilib.farming.register_growth_stages(), and then by
    --      .register_crop_or_produce() and this function recursively, in order to populate
    --      "fredo_grow_table"
    --
    -- Args:
    --      grow_name (str): e.g. "unilib:produce_artichoke_grow"
    --      stage (int): e.g. 1
    --      force_last_flag (bool): If true, "stage" is the last growth stage for this crop/produce

    local full_name = grow_name and grow_name .. "_" .. stage
    local def_table = full_name and core.registered_nodes[full_name]
    if not def_table then

        -- No such node
        return nil

    end

    local mini_table = fredo_grow_table[full_name]
    if mini_table then

        -- Node already processed by a call to this function
        return mini_table

    end

    if core.get_item_group(full_name, "growing") > 0 then

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

                    unilib.farming.on_timer_prepare_growth(pos)

                end,

                on_destruct = function(pos)

                    core.get_node_timer(pos):stop()

                    if old_destruct then
                        old_destruct(pos)
                    end

                end,

                on_timer = function(pos, elapsed)
                    return unilib.farming.on_timer_do_growth(pos, elapsed, full_name)
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
    -- Called by unilib.farming.on_timer_prepare_growth()
    -- Starts/stops a Minetest timer to convert the node at position "pos" to its next growth stage,
    --      specified by the first item in "remaining_list"

    if not remaining_list then
        return
    end

    local timer = core.get_node_timer(pos)

    if remaining_list > 0 then

        if not timer:is_started() then

            local stage_length = unilib.farming.do_standard_normal_distribution(
                stage_length_avg, stage_length_dev
            )

            stage_length = unilib.farming.clamp_to_min_max(
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
-- Shared functions (communication between files in /lib/shared/farming)
---------------------------------------------------------------------------------------------------

function unilib.farming._get_max_light()

    -- Original to unilib
    return farming_max_light

end

function unilib.farming._get_min_light()

    -- Original to unilib
    return farming_min_light

end

function unilib.farming._add_to_fredo_grow_list(full_name)

    -- Original to unilib
    table.insert(fredo_grow_list, full_name)

end

---------------------------------------------------------------------------------------------------
-- Shared functions (for everything)
---------------------------------------------------------------------------------------------------

function unilib.farming._insert_into_grow_list(data_table)

    -- Original to unilib, and called by any package that doesn't want to call
    --      unilib.register_crop_mtgame(), unilib.register_crop_fredo() or
    --      unilib.register_produce_fredo() (for example the "produce_cocoa_jungle" package)
    -- Updates the table of basic crop/produce items, so that the later call to
    --      unilib.farming.register_growth_stages() can use it
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

        local group_table = core.registered_nodes[grow_name .. "_" .. i].groups

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

function unilib.farming._refill_seed(player, placed_full_name, index)

    -- Adapted from farming_redo/init.lua, was farming.refill_plant()
    -- Called from unilib.farming.place_item_as_seed()
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

function unilib.farming._place_item_as_seed(
    itemstack, placer, pointed_thing, placed_full_name, farming_mode
)
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
    local under = core.get_node(pt.under)
    local def_table = core.registered_nodes[under.name]
    if placer and itemstack and def_table and def_table.on_rightclick then
        return def_table.on_rightclick(pt.under, under, placer, itemstack, pt)
    end

    -- Check if pointing at the top of the node
    local above = core.get_node(pt.above)
    if pt.above.y ~= pt.under.y + 1 then
        return itemstack
    end

    -- Check that the nodes are registered
    if not core.registered_nodes[under.name] or not core.registered_nodes[above.name] then
        return itemstack
    end

    -- Check if the above node can be replaced, that the player is pointing at soil, and avoid the
    --      multiple seed placement bug
    if not core.registered_nodes[above.name].buildable_to or
            core.get_item_group(under.name, "soil") < 2 or
            core.get_item_group(above.name, "plant") ~= 0 then
        return itemstack
    end

    -- Check protection. farming_redo has no check for pt.under
    local player_name = placer and placer:get_player_name() or ""
    if farming_mode == "mtgame" and core.is_protected(pt.under, player_name) then

        core.record_protection_violation(pt.under, player_name)
        return

    elseif core.is_protected(pt.above, player_name) then

        core.record_protection_violation(pt.above, player_name)
        return

    end

    -- Not protected, so add the node and remove one item from the itemstack
    if farming_mode == "mtgame" then

        -- Original code from minetest_game/farming, using the .tick() function above to grow the
        --      crop
        --[[
        unilib.utils.log(
            "action",
            player_name .. " places node " .. placed_full_name .. " at " ..
                    core.pos_to_string(pt.above)
        )
        ]]--
        if placer then
            unilib.utils.log_player_action(placer, "places node", placed_full_name, "at", pt.above)
        end

        core.add_node(pt.above, {name = placed_full_name, param2 = 1})
        tick(pt.above)

    elseif farming_mode == "fredo" then

        -- Code from farming_redo, using unilib.farming.on_timer_do_growth() to grow the crop/
        --      produce
        --[[
        unilib.utils.log(
            "action",
            player_name .. " places node " .. placed_full_name .. " at " ..
                    core.pos_to_string(pt.above)
        )
        ]]--
        if placer then
            unilib.utils.log_player_action(placer, "places node", placed_full_name, "at", pt.above)
        end

        local p2 = core.registered_nodes[placed_full_name].place_param2 or 1
        core.set_node(pt.above, {name = placed_full_name, param2 = p2})

        core.sound_play("unilib_place_node", {pos = pt.above, gain = 1.0})

    else

        unilib.utils.show_error(
            "unilib.farming.place_item_as_seed(): Invalid farming mode", farming_mode
        )
        return itemstack

    end

    if placer and itemstack and not unilib.utils.is_creative(placer:get_player_name()) then

        local name = itemstack:get_name()
        itemstack:take_item()

        -- If possible, move additional seeds into the player's current inventory slot
        if itemstack:get_count() == 0 then

            core.after(
                0.10,
                unilib.farming.refill_seed,
                placer,
                name,
                placer:get_wield_index()
            )

        end

        return itemstack

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (for crops using minetest_game code)
---------------------------------------------------------------------------------------------------

function unilib.farming._grow_crop(pos, elapsed)

    -- Adapted from farming/api.lua

    local node = core.get_node(pos)
    local full_name = node.name
    local def_table = core.registered_nodes[full_name]

    if not def_table.next_plant then

        -- Disable timer for fully grown crop
        return

    end

    -- Grow seed
    if core.get_item_group(node.name, "seed") ~= 0 and def_table.fertility then

        local soil_node = core.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})

        if not soil_node then

            tick_again(pos)
            return

        end

        -- A check for light is omitted, we assume seeds can germinate in the dark
        for _, v in pairs(def_table.fertility) do

            if core.get_item_group(soil_node.name, v) ~= 0 then

                local placenode = {name = def_table.next_plant}
                if def_table.place_param2 then
                    placenode.param2 = def_table.place_param2
                end

                core.swap_node(pos, placenode)

                if core.registered_nodes[def_table.next_plant].next_plant then

                    tick(pos)
                    return

                end

            end

        end

        return

    end

    -- Check if on wet soil
    if not (def_table.can_grow or crop_can_grow)(pos) then

        tick_again(pos)
        return

    end

    -- Check light
    local light = core.get_node_light(pos)
    if not light or light < def_table.minlight or light > def_table.maxlight then

        tick_again(pos)
        return

    end

    -- Grow the crop
    local placenode = {name = def_table.next_plant}
    if def_table.place_param2 then
        placenode.param2 = def_table.place_param2
    end

    core.swap_node(pos, placenode)

    -- New timer needed?
    if core.registered_nodes[def_table.next_plant].next_plant then
        tick(pos)
    end

    return

end

---------------------------------------------------------------------------------------------------
-- Shared functions (for crops/produce using farming_redo code)
---------------------------------------------------------------------------------------------------

function unilib.farming._on_timer_do_growth(pos, elapsed, full_name)

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
    local check_func = core.registered_nodes[full_name].growth_check
    if check_func and check_func(pos, full_name) then
        return true
    end

    -- Not in original farming_redo code (and based on code in minetest_game/farming): check that
    --      the crop's fertility groups match those of the soil on which it's growing
    -- If the .fertility field does not exist, we assume that the crop/produce has been placed on
    --      some other kind of surface (e.g. a jungle tree for the cocoa pod)
    local under = core.get_node({x = pos.x, y = pos.y - 1, z = pos.z})
    local match_flag = false
    local fertility_list = core.registered_nodes[full_name].fertility
    if fertility_list ~= nil then

        for _, v in ipairs(fertility_list) do

            if core.get_item_group(under.name, v) ~= 0 then

                match_flag = true
                break

            end

        end

        if not match_flag then
            return true
        end

        -- Otherwise, check for wet soil beneath the crop/produce
        if core.get_item_group(under.name, "soil") < 3 then
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

    local min_light = core.registered_nodes[full_name].minlight or farming_min_light
    local max_light = core.registered_nodes[full_name].maxlight or farming_max_light

    if max_growth == 1 or lambda < 2.0 then

        local light = core.get_node_light(light_pos) or 0

        if light < min_light or light > max_light then
            return true
        end

        growth = 1

    else

        local night_light = core.get_node_light(light_pos, 0) or 0
        local day_light = core.get_node_light(light_pos, 0.5) or 0
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

        growth = unilib.farming.do_poisson_distribution(lambda, max_growth)

        if growth < 1 then
            return true
        end

    end

    if core.registered_nodes[mini_table.remaining_list[growth]] then

        local p2 = core.registered_nodes[mini_table.remaining_list[growth]].place_param2 or 1
        core.swap_node(pos, {name = mini_table.remaining_list[growth], param2 = p2})

    else

        return true

    end

    return growth ~= max_growth

end

function unilib.farming._on_timer_prepare_growth(pos, node)

    -- Adapted from farming_redo/init.lua, was farming.handle_growth()
    -- Called by the callback in .register_growth_stages()
    -- Detects crops/produce at the specified position, starting or stopping growth timer as
    --      required
    -- "pos" is always specified; "node" is specified when called by the crop growth ABM in the
    --      "abm_standard_crop_grow" package

    if not pos then
        return
    end

    local remaining_list = register_crop_or_produce(node or pos)
    if remaining_list then
        update_growth_timer(pos, remaining_list)
    end

end

function unilib.farming._register_growth_stages()

    -- Original to unilib
    -- Called from ../lib/system/load/ during its finalisation stage
    -- Uses "fredo_grow_list" to populate "fredo_grow_table"

    for _, grow_name in ipairs(fredo_grow_list) do
        register_growth_stages(grow_name, 1, false)
    end

end
