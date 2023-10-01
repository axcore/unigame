---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_bbq_grill = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function swap_node(pos, name)

    local node = minetest.get_node(pos)
    if node.name == name then
        return
    end

    node.name = name
    minetest.swap_node(pos, node)

end

---------------------------------------------------------------------------------------------------
-- Shared functions (formspecs)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_bbq_grill.get_active_formspec(fuel_percent, item_percent)

    -- Was default.get_smoker_active_formspec()

    return "size[8,8.5]" ..
        "list[context;src;2.75,0.5;1,1;]" ..
        "list[context;fuel;2.75,2.5;1,1;]" ..
        "image[2.75,1.5;1,1;unilib_machine_grill_fire_bg.png^[lowpart:" ..
        (100 - fuel_percent) .. ":unilib_machine_grill_fire_fg.png]" ..
        "image[3.75,1.5;1,1;unilib_gui_grill_arrow_bg.png^[lowpart:" ..
        item_percent .. ":unilib_gui_grill_arrow_fg.png^[transformR270]" ..
        "list[context;dst;4.8,0.5;3,3;]" ..
        "list[current_player;main;0,4.25;8,1;]" ..
        "list[current_player;main;0,5.5;8,3;8]" ..
        "listring[context;dst]" ..
        "listring[current_player;main]" ..
        "listring[context;src]" ..
        "listring[current_player;main]" ..
        "listring[context;fuel]" ..
        "listring[current_player;main]" ..
        unilib.get_hotbar_bg(0, 4.25)

end

function unilib.pkg.shared_bbq_grill.get_inactive_formspec()

    -- Was default.get_smoker_inactive_formspec()

    return "size[8,8.5]" ..
        "list[context;src;2.75,0.5;1,1;]" ..
        "list[context;fuel;2.75,2.5;1,1;]" ..
        "image[2.75,1.5;1,1;unilib_machine_grill_fire_bg.png]" ..
        "image[3.75,1.5;1,1;unilib_gui_grill_arrow_bg.png^[transformR270]" ..
        "list[context;dst;4.8,0.5;3,3;]" ..
        "list[current_player;main;0,4.25;8,1;]" ..
        "list[current_player;main;0,5.5;8,3;8]" ..
        "listring[context;dst]" ..
        "listring[current_player;main]" ..
        "listring[context;src]" ..
        "listring[current_player;main]" ..
        "listring[context;fuel]" ..
        "listring[current_player;main]" ..
        unilib.get_hotbar_bg(0, 4.25)

end

---------------------------------------------------------------------------------------------------
-- Shared functions (callbacks)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_bbq_grill.allow_metadata_inventory_move(
    pos, from_list, from_index, to_list, to_index, count, player, empty_msg
)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local stack = inv:get_stack(from_list, from_index)
    return unilib.pkg.shared_bbq_grill.allow_metadata_inventory_put(
        pos, to_list, to_index, stack, player, empty_msg
    )

end

function unilib.pkg.shared_bbq_grill.allow_metadata_inventory_put(
    pos, listname, index, stack, player, empty_msg
)
    if minetest.is_protected(pos, player:get_player_name()) then
        return 0
    end

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    if listname == "fuel" then

        if minetest.get_craft_result({method = "fuel", width = 1, items = {stack}}).time ~= 0 then

            if inv:is_empty("src") then
                meta:set_string("infotext", empty_msg)
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

function unilib.pkg.shared_bbq_grill.allow_metadata_inventory_take(
    pos, listname, index, stack, player
)
    if minetest.is_protected(pos, player:get_player_name()) then
        return 0
    end

    return stack:get_count()

end

function unilib.pkg.shared_bbq_grill.can_dig(pos, player)

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    return inv:is_empty("fuel") and inv:is_empty("dst") and inv:is_empty("src")

end

function unilib.pkg.shared_bbq_grill.grill_node_timer(
    pos, elapsed, inactive_name, active_name, inactive_msg, active_msg, inactive_formspec_func,
    active_formspec_func
)
    -- Was smoker_node_timer()

    -- Inizialise metadata
    local meta = minetest.get_meta(pos)
    local fuel_time = meta:get_float("fuel_time") or 0
    local src_time = meta:get_float("src_time") or 0
    local fuel_totaltime = meta:get_float("fuel_totaltime") or 0

    local inv = meta:get_inventory()

    local cookable_flag, fuel_list, src_list, cook_table, fuel_table
    local update_flag = true

    while elapsed > 0 and update_flag do

        update_flag = false

        src_list = inv:get_list("src")
        fuel_list = inv:get_list("fuel")

        -- Check if we have cookable content
        local after_cook_table
        cook_table, after_cook_table = minetest.get_craft_result(
            {method = "cooking", width = 1, items = src_list}
        )

        cookable_flag = cook_table.time ~= 0

        local el = math.min(elapsed, fuel_totaltime - fuel_time)
        -- If fuel lasts long enough, adjust el to cooking duration
        if cookable_flag then
            el = math.min(el, cook_table.time - src_time)
        end

        -- Check if we have enough fuel to burn
        if fuel_time < fuel_totaltime then

            -- The grill is currently active and has enough fuel
            fuel_time = fuel_time + el
            -- If there is a cookable item then check if it is ready yet
            if cookable_flag then

                src_time = src_time + el
                if src_time >= cook_table.time then

                    -- Place result in dst list if possible
                    if inv:room_for_item("dst", cook_table.item) then

                        inv:add_item("dst", cook_table.item)
                        inv:set_stack("src", 1, after_cook_table.items[1])
                        src_time = src_time - cook_table.time
                        update_flag = true

                    end

                else

                    -- Item could not be cooked: probably missing fuel
                    update_flag = true

                end

            end

        else

            -- Grill ran out of fuel
            if cookable_flag then

                -- We need to get new fuel
                local after_fuel_table
                fuel_table, after_fuel_table = minetest.get_craft_result(
                    {method = "fuel", width = 1, items = fuel_list}
                )

                if fuel_table.time == 0 then

                    -- No valid fuel in fuel list
                    fuel_totaltime = 0
                    src_time = 0

                else

                    -- Take fuel from fuel list
                    inv:set_stack("fuel", 1, after_fuel_table.items[1])
                    update_flag = true
                    fuel_totaltime = fuel_table.time + (fuel_totaltime - fuel_time)

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

    if fuel_table and fuel_totaltime > fuel_table.time then
        fuel_totaltime = fuel_table.time
    end

    if src_list[1]:is_empty() then
        src_time = 0
    end

    -- Update formspec, infotext and node
    local formspec, item_state
    local item_percent = 0

    if cookable_flag then

        item_percent = math.floor(src_time / cook_table.time * 100)
        if item_percent > 100 then
            item_state = S("100% (output full)")
        else
            item_state = item_percent .. "%"
        end

    else

        if src_list[1]:is_empty() then
            item_state = S("Empty")
        else
            item_state = S("Not cookable")
        end

    end

    local fuel_state = "Empty"
    local active_flag = false
    local result_flag = false

    if fuel_totaltime ~= 0 then

        active_flag = true
        local fuel_percent = math.floor(fuel_time / fuel_totaltime * 100)
        fuel_state = fuel_percent .. "%"
        formspec = active_formspec_func(fuel_percent, item_percent)
        swap_node(pos, active_name)
        -- Make sure timer restarts automatically
        result_flag = true

    else

        if not fuel_list[1]:is_empty() then
            fuel_state = "0%"
        end

        formspec = inactive_formspec_func()
        swap_node(pos, inactive_name)
        -- Stop timer on the inactive grill
        minetest.get_node_timer(pos):stop()

    end

    local infotext
    if not active_flag then
        infotext = inactive_msg
    else
        infotext = active_msg
    end

    infotext = infotext .. "\n(" .. S("Item: @1", item_state) .. "; " ..
            S("Fuel: @1", fuel_state) .. ")"

    -- Set meta values
    meta:set_float("fuel_totaltime", fuel_totaltime)
    meta:set_float("fuel_time", fuel_time)
    meta:set_float("src_time", src_time)
    meta:set_string("formspec", formspec)
    meta:set_string("infotext", infotext)

    return result_flag

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_bbq_grill.init()

    return {
        description = "Shared functions for BBQ grills (from bbq)",
    }

end
