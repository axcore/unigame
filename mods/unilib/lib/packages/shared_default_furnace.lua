---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_default_furnace = {}

local S = unilib.intllib
local FS = function(...) return core.formspec_escape(S(...)) end
local mode = unilib.global.imported_mod_table.default.add_mode

-- Table containing lists of sound handles for each active furnace
local furnace_fire_sound_table = {}

-- Pipeworks compatibility
local pipeworks_flag = false
if core.get_modpath("pipeworks") then
    pipeworks_flag = true
end

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_pipeworks_switch(pos)

    if not pipeworks_flag then

        return ""

    else

        local formspec = pipeworks.fs_helpers.cycling_button(
            core.get_meta(pos),
            "image_button[0,3.5;1,0.6",
            "split_material_stacks",
            {pipeworks.button_off, pipeworks.button_on}
        )

        formspec = formspec .. "label[0.9,3.51;" ..
                FS("Allow splitting incoming stacks (not fuel) from tubes") .. "]"

        return formspec

    end

end

local function get_furnace_active_formspec(fuel_percent, item_percent, pos)

    return "size[8,8.5]" ..
        "list[context;src;2.75,0.5;1,1;]" ..
        "list[context;fuel;2.75,2.5;1,1;]" ..
        "image[2.75,1.5;1,1;unilib_machine_furnace_ordinary_fire_bg.png^[lowpart:" ..
        fuel_percent .. ":unilib_machine_furnace_ordinary_fire_fg.png]" ..
        "image[3.75,1.5;1,1;unilib_gui_furnace_arrow_bg.png^[lowpart:" ..
        item_percent .. ":unilib_gui_furnace_arrow_fg.png^[transformR270]" ..
        "list[context;dst;4.75,0.96;2,2;]" ..
        "list[current_player;main;0,4.25;8,1;]" ..
        "list[current_player;main;0,5.5;8,3;8]" ..
        "listring[context;dst]" ..
        "listring[current_player;main]" ..
        "listring[context;src]" ..
        "listring[current_player;main]" ..
        "listring[context;fuel]" ..
        "listring[current_player;main]" ..
        unilib.misc.get_hotbar_bg(0, 4.25) ..
        get_pipeworks_switch(pos)

end

local function get_furnace_inactive_formspec(pos)

    return "size[8,8.5]" ..
        "list[context;src;2.75,0.5;1,1;]" ..
        "list[context;fuel;2.75,2.5;1,1;]" ..
        "image[2.75,1.5;1,1;unilib_machine_furnace_ordinary_fire_bg.png]" ..
        "image[3.75,1.5;1,1;unilib_gui_furnace_arrow_bg.png^[transformR270]" ..
        "list[context;dst;4.75,0.96;2,2;]" ..
        "list[current_player;main;0,4.25;8,1;]" ..
        "list[current_player;main;0,5.5;8,3;8]" ..
        "listring[context;dst]" ..
        "listring[current_player;main]" ..
        "listring[context;src]" ..
        "listring[current_player;main]" ..
        "listring[context;fuel]" ..
        "listring[current_player;main]" ..
        unilib.misc.get_hotbar_bg(0, 4.25) ..
        get_pipeworks_switch(pos)

end

local function swap_node(pos, name)

    local node = core.get_node(pos)
    if node.name == name then
        return
    end

    node.name = name
    core.swap_node(pos, node)

end

---------------------------------------------------------------------------------------------------
-- Shared functions (pipeworks compatibility)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_default_furnace.active_on_receive_fields(pos, formname, fields, sender)

    if not pipeworks.may_configure(pos, sender) then
        return
    end

    pipeworks.fs_helpers.on_receive_fields(pos, fields)
    local meta = core.get_meta(pos)
    local formspec = get_furnace_active_formspec(0, 0, pos)
    meta:set_string("formspec", formspec)

end

function unilib.pkg.shared_default_furnace.get_tube_table()

    return {
        connect_sides = {left = 1, right = 1, back = 1, front = 1, bottom = 1, top = 1},
        input_inventory = "dst",

        can_insert = function(pos, node, stack, direction)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            if direction.y == 1 then

                return inv:room_for_item("fuel", stack)

            else

                if meta:get_int("split_material_stacks") == 1 then
                    stack = stack:peek_item(1)
                end

                return inv:room_for_item("src", stack)

            end

        end,

        insert_object = function(pos, node, stack, direction)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            local timer = core.get_node_timer(pos)
            if not timer:is_started() then
                timer:start(1.0)
            end

            if direction.y == 1 then
                return inv:add_item("fuel", stack)
            else
                return inv:add_item("src", stack)
            end

        end,
    }

end

function unilib.pkg.shared_default_furnace.inactive_on_receive_fields(pos, formname, fields, sender)

    if not pipeworks.may_configure(pos, sender) then
        return
    end

    pipeworks.fs_helpers.on_receive_fields(pos, fields)
    local meta = core.get_meta(pos)
    local formspec = get_furnace_inactive_formspec(pos)
    meta:set_string("formspec", formspec)

end

---------------------------------------------------------------------------------------------------
-- Shared functions (other)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_default_furnace.allow_metadata_inventory_put(
    pos, listname, index, stack, player
)
    if core.is_protected(pos, player:get_player_name()) then
        return 0
    end

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    if listname == "fuel" then

        if core.get_craft_result({method = "fuel", width = 1, items = {stack}}).time ~= 0 then

            if inv:is_empty("src") then
                meta:set_string("infotext", S("Furnace is empty"))
            end

            return stack:get_count()

        else

            return 0

        end

    elseif listname == "src" then

        return stack:get_count()

    elseif listname == "dst" then

        return 0

    end

end

function unilib.pkg.shared_default_furnace.allow_metadata_inventory_move(
    pos, from_list, from_index, to_list, to_index, count, player
)
    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    local stack = inv:get_stack(from_list, from_index)
    return unilib.pkg.shared_default_furnace.allow_metadata_inventory_put(
        pos, to_list, to_index, stack, player
    )

end

function unilib.pkg.shared_default_furnace.allow_metadata_inventory_take(
    pos, listname, index, stack, player
)
    if core.is_protected(pos, player:get_player_name()) then
        return 0
    end

    return stack:get_count()

end

function unilib.pkg.shared_default_furnace.can_dig(pos, player)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    return inv:is_empty("fuel") and inv:is_empty("dst") and inv:is_empty("src")

end

function unilib.pkg.shared_default_furnace.furnace_node_timer(
    pos, elapsed, inactive_name, active_name
)
    -- Initialise metadata

    local meta = core.get_meta(pos)
    local fuel_time = meta:get_float("fuel_time") or 0
    local src_time = meta:get_float("src_time") or 0
    local fuel_totaltime = meta:get_float("fuel_totaltime") or 0

    local inv = meta:get_inventory()
    local srclist, fuellist
    local dst_full = false

    local timer_elapsed = meta:get_int("timer_elapsed") or 0
    meta:set_int("timer_elapsed", timer_elapsed + 1)

    local cookable, cooked, fuel
    local update = true
    local items_smelt = 0

    while elapsed > 0 and update do

        update = false

        srclist = inv:get_list("src")
        fuellist = inv:get_list("fuel")

        -- Cooking

        -- Check if we have cookable content
        local aftercooked
        cooked, aftercooked = core.get_craft_result(
            {method = "cooking", width = 1, items = srclist}
        )

        cookable = cooked.time ~= 0

        local el = math.min(elapsed, fuel_totaltime - fuel_time)
        if cookable then

            -- Fuel lasts long enough, adjust el to cooking duration
            el = math.min(el, cooked.time - src_time)

        end

        -- Check if we have enough fuel to burn
        if fuel_time < fuel_totaltime then

            -- The furnace is currently active and has enough fuel
            fuel_time = fuel_time + el

            -- If there is a cookable item then check if it is ready yet
            if cookable then

                src_time = src_time + el
                if src_time >= cooked.time then

                    -- Place result in dst list if possible
                    if inv:room_for_item("dst", cooked.item) then

                        inv:add_item("dst", cooked.item)
                        inv:set_stack("src", 1, aftercooked.items[1])
                        src_time = src_time - cooked.time
                        update = true

                    else

                        dst_full = true

                    end

                    items_smelt = items_smelt + 1

                else

                    -- Item could not be cooked: probably missing fuel
                    update = true

                end

            end

        else

            -- Furnace ran out of fuel
            if cookable then

                -- We need to get new fuel
                local afterfuel
                fuel, afterfuel = core.get_craft_result(
                    {method = "fuel", width = 1, items = fuellist}
                )

                if fuel.time == 0 then

                    -- No valid fuel in fuel list
                    fuel_totaltime = 0
                    src_time = 0

                else

                    -- Prevent blocking of fuel inventory (for automatization mods)
                    local is_fuel = core.get_craft_result(
                        {method = "fuel", width = 1, items = {afterfuel.items[1]:to_string()}}
                    )

                    if is_fuel.time == 0 then

                        table.insert(fuel.replacements, afterfuel.items[1])
                        inv:set_stack("fuel", 1, "")

                    else

                        -- Take fuel from fuel list
                        inv:set_stack("fuel", 1, afterfuel.items[1])

                    end

                    -- Put replacements in dst list or drop them on the furnace
                    local replacements = fuel.replacements
                    if replacements[1] then

                        local leftover = inv:add_item("dst", replacements[1])
                        if not leftover:is_empty() then

                            local above = vector.new(pos.x, pos.y + 1, pos.z)
                            local drop_pos = core.find_node_near(above, 1, {"air"}) or above
                            core.item_drop(replacements[1], nil, drop_pos)

                        end

                    end

                    update = true
                    fuel_totaltime = fuel.time + (fuel_totaltime - fuel_time)

                end

            else

                -- We don't need to get new fuel since there is no cookable item
                fuel_totaltime = 0
                src_time = 0

            end

            fuel_time = 0

        end

        elapsed = elapsed - el

    end

    if items_smelt > 0 then

        -- Play cooling sound
        core.sound_play(
            "unilib_cool_lava",
            {pos = pos, max_hear_distance = 16, gain = 0.07 * math.min(items_smelt, 7)},
            true
        )

    end

    if fuel and fuel_totaltime > fuel.time then
        fuel_totaltime = fuel.time
    end

    if srclist and srclist[1]:is_empty() then
        src_time = 0
    end

    -- Update formspec, infotext and node
    local formspec
    local item_state
    local item_percent = 0

    if cookable then

        item_percent = math.floor(src_time / cooked.time * 100)
        if dst_full then
            item_state = S("100% (output full)")
        else
            item_state = S("@1%", item_percent)
        end

    else

        if srclist and not srclist[1]:is_empty() then
            item_state = S("Not cookable")
        else
            item_state = S("Empty")
        end

    end

    local fuel_state = S("Empty")
    local active = false
    local result = false

    if fuel_totaltime ~= 0 then

        active = true
        local fuel_percent = 100 - math.floor(fuel_time / fuel_totaltime * 100)
        fuel_state = S("@1%", fuel_percent)
        formspec = get_furnace_active_formspec(fuel_percent, item_percent, pos)
        swap_node(pos, active_name)
        -- Make sure timer restarts automatically
        result = true

        -- Play sound every 5 seconds while the furnace is active
        if timer_elapsed == 0 or (timer_elapsed + 1) % 5 == 0 then

            local sound_id = core.sound_play(
                "unilib_furnace_active",
                {pos = pos, max_hear_distance = 16, gain = 0.25}
            )

            local hash = core.hash_node_position(pos)
            furnace_fire_sound_table[hash] = furnace_fire_sound_table[hash] or {}
            table.insert(furnace_fire_sound_table[hash], sound_id)

            -- Only remember the 3 last sound handles
            if #furnace_fire_sound_table[hash] > 3 then
                table.remove(furnace_fire_sound_table[hash], 1)
            end

            -- Remove the sound ID automatically from table after 11 seconds
            core.after(11, function()

                if not furnace_fire_sound_table[hash] then
                    return
                end

                for f = #furnace_fire_sound_table[hash], 1, -1 do

                    if furnace_fire_sound_table[hash][f] == sound_id then
                        table.remove(furnace_fire_sound_table[hash], f)
                    end

                end

                if #furnace_fire_sound_table[hash] == 0 then
                    furnace_fire_sound_table[hash] = nil
                end

            end)

        end

    else

        if fuellist and not fuellist[1]:is_empty() then
            fuel_state = S("@1%", 0)
        end

        formspec = get_furnace_inactive_formspec(pos)
        swap_node(pos, inactive_name)
        -- Stop timer on the inactive furnace
        core.get_node_timer(pos):stop()
        meta:set_int("timer_elapsed", 0)

        unilib.pkg.shared_default_furnace.stop_furnace_sound(pos)

    end

    local infotext
    if active then
        infotext = S("Furnace active")
    else
        infotext = S("Furnace inactive")
    end

    infotext = infotext .. "\n" .. S("(Item: @1; Fuel: @2)", item_state, fuel_state)

    -- Set meta values
    meta:set_float("fuel_totaltime", fuel_totaltime)
    meta:set_float("fuel_time", fuel_time)
    meta:set_float("src_time", src_time)
    meta:set_string("formspec", formspec)
    meta:set_string("infotext", infotext)

    return result

end

function unilib.pkg.shared_default_furnace.stop_furnace_sound(pos, fadeout_step)

    local hash = core.hash_node_position(pos)
    local sound_ids = furnace_fire_sound_table[hash]
    if sound_ids then

        for _, sound_id in ipairs(sound_ids) do
            core.sound_fade(sound_id, -1, 0)
        end

        furnace_fire_sound_table[hash] = nil

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_default_furnace.init()

    return {
        description = "Shared functions for furnaces (from minetest_game/default)",
        mod_optional = "pipeworks",
    }

end
