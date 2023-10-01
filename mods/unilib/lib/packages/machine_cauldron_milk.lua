---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_cauldron_milk = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cheese.add_mode

local inactive_nodebox = {
    type = "fixed",
    fixed = {
        {-0.3125, -0.3125, -0.3125, 0.3125, 0.4375, 0.3125},
        {-0.4375, -0.5, -0.4375, -0.25, -0.4375, -0.25},
        {-0.375, -0.4375, -0.375, -0.25, -0.25, -0.25},
        {0.25, -0.5, -0.4375, 0.4375, -0.4375, -0.25},
        {0.25, -0.4375, -0.375, 0.375, -0.25, -0.25},
        {0.25, -0.5, 0.25, 0.4375, -0.4375, 0.4375},
        {0.25, -0.4375, 0.25, 0.375, -0.25, 0.375},
        {-0.4375, -0.5, 0.25, -0.25, -0.4375, 0.4375},
        {-0.375, -0.4375, 0.25, -0.25, -0.25, 0.375},
        {-0.375, -0.1875, -0.375, 0.375, 0.3125, 0.375},
        {-0.4375, -0.0625, -0.4375, 0.4375, 0.25, 0.4375},
        {-0.3125, 0.4375, -0.375, 0.3125, 0.5, -0.3125},
        {-0.3125, 0.4375, 0.3125, 0.3125, 0.5, 0.375},
        {-0.375, 0.4375, -0.3125, -0.3125, 0.5, 0.3125},
        {0.3125, 0.4375, -0.3125, 0.375, 0.5, 0.3125},
        {-0.25, -0.5, -0.25, 0.25, -0.375, 0.25},
    },
}

local active_nodebox = {
    type = "fixed",
    fixed = {
        {-0.3125, -0.3125, -0.3125, 0.3125, 0.4375, 0.3125},
        {-0.4375, -0.5, -0.4375, -0.25, -0.4375, -0.25},
        {-0.375, -0.4375, -0.375, -0.25, -0.25, -0.25},
        {0.25, -0.5, -0.4375, 0.4375, -0.4375, -0.25},
        {0.25, -0.4375, -0.375, 0.375, -0.25, -0.25},
        {0.25, -0.5, 0.25, 0.4375, -0.4375, 0.4375},
        {0.25, -0.4375, 0.25, 0.375, -0.25, 0.375},
        {-0.4375, -0.5, 0.25, -0.25, -0.4375, 0.4375},
        {-0.375, -0.4375, 0.25, -0.25, -0.25, 0.375},
        {-0.375, -0.1875, -0.375, 0.375, 0.3125, 0.375},
        {-0.4375, -0.0625, -0.4375, 0.4375, 0.25, 0.4375},
        {-0.3125, 0.4375, -0.375, 0.3125, 0.5, -0.3125},
        {-0.3125, 0.4375, 0.3125, 0.3125, 0.5, 0.375},
        {-0.375, 0.4375, -0.3125, -0.3125, 0.5, 0.3125},
        {0.3125, 0.4375, -0.3125, 0.375, 0.5, 0.3125},
        {-0.25, -0.5, -0.25, 0.25, -0.3125, 0.25},
    },
}

local selection_box = {
    type = "fixed",
    fixed = {
        {-0.4375, -0.5, -0.4375, 0.4375, 0.5, 0.4375},
    },
}

-- This list is populated in the .post() function below
local recipe_list = {}

---------------------------------------------------------------------------------------------------
-- Local functions (utility functions)
---------------------------------------------------------------------------------------------------

local function is_milk_bucket(full_name)

    -- Generalised function for detecting milk buckets

    if minetest.get_item_group(full_name, "food_milk") > 0 and
            minetest.get_item_group(full_name, "food_vegan") == 0 then
        return true
    elseif string.find(full_name, "bucket") and string.find(full_name, "milk") then
        return true
    else
        return false
    end

end

local function get_empty_container(full_name)

    -- Original to unilib
    -- Converts a full bucket (e.g. "unilib:bucket_steel_with_water_ordinary") into an empty bucket
    --      (e.g. "unilib:bucket_steel_empty")
    -- If it's not a unilib bucket (such as one from mobs_animal or petz), just return an empty
    --      steel bucket or an empty bottle, assuming that it was the original ingredient

    if unilib.empty_bucket_table[full_name] ~= nil then
        return unilib.empty_bucket_table[full_name]
    elseif string.find(full_name, "bucket") then
        return "unilib:bucket_steel_empty"
    else
        return "unilib:vessel_bottle_glass_empty"
    end

end

local function get_boiling_results(src_table)

    local output = {
        item = "",
        time = 0,
    }

    local src = ItemStack(src_table.items[1])
    local src_name = src:to_string()
    local s = string.split(src_name, " ")[1]
    if s ~= nil  then
        src_name = s
    end

    for _, mini_list in pairs(recipe_list) do

        if mini_list[1] == src_name then

            output.item = mini_list[2]
            output.second_item = mini_list[3]
            output.replacement = mini_list[4]
            output.time = mini_list[5]
            src:take_item()

        elseif is_milk_bucket(src_name) then

            output.item = "unilib:ingredient_curd"
            output.second_item = "unilib:ingredient_whey"
            output.replacement = get_empty_container(src_name)
            output.time = 8
            src:take_item()

        end

    end

    return output, {items = {src}}

end

local function get_from_src_list(src_slots_list, size)

    -- Cycle through inventory slots, and take the "correct" stack

    local stack
    if src_slots_list ~= nil then

        for i = 1, size do

            if not src_slots_list[i]:is_empty() then
                stack = src_slots_list[i]
            end

        end

    end

    return stack

end

local function get_stack_count(list, size)

    -- Return not how many items there are, just the number of stacks

    local count = 0
    if list ~= nil then

        for i = 1, size do

            if list[i]:is_empty() == false then
                count = count + 1
            end

        end

    end

    return count

end

---------------------------------------------------------------------------------------------------
-- Local functions (adapted from default/furnace.lua and "machine_furnace_ordinary" package)
---------------------------------------------------------------------------------------------------

local function get_cauldron_active_formspec(fuel_percent, item_percent)

    return "formspec_version[5]" ..
    "size[10.5,11]" ..
    "list[context;src_slots;0.5,0.5;3,4]" ..
    "list[context;src;4.7,1.3;1,1]" ..
    "list[context;fuel;4.7,3.5;1,1]" ..
    "image[4.7,2.4;1,1;unilib_machine_furnace_ordinary_fire_bg.png^[lowpart:" ..
    fuel_percent .. ":unilib_machine_furnace_ordinary_fire_bg.png]" ..
    "image[6.2,2.4;1,1;unilib_gui_furnace_arrow_bg.png^[lowpart:" ..
    item_percent .. ":unilib_gui_furnace_arrow_bg.png^[transformR270]" ..
    "list[context;dst;7.7,0.5;2,4]" ..
    "list[current_player;main;0.4,5.75;8,1]" ..
    "list[current_player;main;0.4,7;8,3;8]" ..
    "listring[context;dst]" ..
    "listring[current_player;main]" ..
    "listring[context;src]" ..
    "listring[current_player;main]" ..
    "listring[context;src_slots]" ..
    "listring[current_player;main]" ..
    "listring[context;fuel]" ..
    "listring[current_player;main]" ..
    unilib.get_hotbar_bg(0, 4.25)

end

local function get_cauldron_inactive_formspec()

    return "formspec_version[5]" ..
    "size[10.5,11]" ..
    "list[context;src_slots;0.5,0.5;3,4]" ..
    "list[context;src;4.7,1.3;1,1]" ..
    "list[context;fuel;4.7,3.5;1,1]" ..
    "image[4.7,2.4;1,1;unilib_machine_furnace_ordinary_fire_bg.png]" ..
    "image[6.2,2.4;1,1;unilib_gui_furnace_arrow_bg.png^[transformR270]" ..
    "list[context;dst;7.7,0.5;2,4]" ..
    "list[current_player;main;0.4,5.75;8,1]" ..
    "list[current_player;main;0.4,7;8,3;8]" ..
    "listring[context;dst]" ..
    "listring[current_player;main]" ..
    "listring[context;src]" ..
    "listring[current_player;main]" ..
    "listring[context;src_slots]" ..
    "listring[current_player;main]" ..
    "listring[context;fuel]" ..
    "listring[current_player;main]" ..
    unilib.get_hotbar_bg(0, 4.25)

end

---------------------------------------------------------------------------------------------------
-- Local functions (node callback functions)
---------------------------------------------------------------------------------------------------

local function allow_metadata_inventory_put(pos, listname, index, stack, player)

    if minetest.is_protected(pos, player:get_player_name()) then
        return 0
    end

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    if listname == "fuel" then

        if minetest.get_craft_result({method = "fuel", width = 1, items = {stack}}).time ~= 0 then

            if inv:is_empty("src") then
                meta:set_string("infotext", S("Cauldron is empty"))
            end

            return stack:get_count()

        else

            return 0

        end

    elseif listname == "src" then

        return stack:get_count()

    elseif listname == "src_slots" then

        return stack:get_count()

    elseif listname == "dst" then

        return 0

    end

end

local function allow_metadata_inventory_move(
    pos, from_list, from_index, to_list, to_index, count, player
)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local stack = inv:get_stack(from_list, from_index)
    return allow_metadata_inventory_put(pos, to_list, to_index, stack, player)

end

local function allow_metadata_inventory_take(pos, listname, index, stack, player)

    if minetest.is_protected(pos, player:get_player_name()) then
        return 0
    end

    return stack:get_count()

end

local function can_dig(pos, player)

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    return inv:is_empty("fuel") and
            inv:is_empty("dst") and
            inv:is_empty("src") and
            inv:is_empty("src_slots")

end

local function swap_node(pos, name)

    local node = minetest.get_node(pos)
    if node.name == name or node.name == "ignore" then
        return
    end

    node.name = name
    minetest.swap_node(pos, node)

end

---------------------------------------------------------------------------------------------------
-- Local functions (node callback functions - cauldron timer)
---------------------------------------------------------------------------------------------------

local function cauldron_node_timer(pos, elapsed)

    -- Initialise metadata
    local meta = minetest.get_meta(pos)
    local fuel_time = meta:get_float("fuel_time") or 0
    local src_time = meta:get_float("src_time") or 0
    local fuel_totaltime = meta:get_float("fuel_totaltime") or 0

    local inv = meta:get_inventory()
    local src_list, fuel_list, dst_list, dst_size
    local src_slots_list, src_slot_size
    local dst_full_flag = false

    local timer_elapsed = meta:get_int("timer_elapsed") or 0
    meta:set_int("timer_elapsed", timer_elapsed + 1)

    local cookable, cooked, fuel
    local update_flag = true

    while elapsed > 0 and update_flag do

        update_flag = false

        src_list = inv:get_list("src")
        fuel_list = inv:get_list("fuel")
        src_slots_list = inv:get_list("src_slots")
        src_slot_size = inv:get_size("src_slots")

        dst_list = inv:get_list("dst")
        dst_size = inv:get_size("dst")
        if get_stack_count(dst_list, dst_size) == dst_size then
            dst_full_flag = true
        end

        -- "dst_full_flag" checks the number of stacks, this flag works even when "dst" is full, yet
        --      there is indeed room for just the cooked item (its stack isn't full)
        -- Otherwise, the cauldron gets stuck with 1 "src" item and uses all its fuel
        -- If "dst" gets full due to normal boiling, it stops. it should be like this.
        local still_room_for_cooked_item_flag = false

        -- Do cooking

        -- Check if we have cookable content
        -- "cooked" is the output table with item, second_item, time, replacement
        -- "aftercooked" is the scrlist with itemstack[1].take_item()
        local aftercooked
        cooked, aftercooked = get_boiling_results({items = src_list})
        cookable = cooked.time ~= 0

        local el = math.min(elapsed, fuel_totaltime - fuel_time)
        -- If fuel lasts long enough, adjust el to cooking duration
        if cookable then

            el = math.min(el, cooked.time - src_time)
            still_room_for_cooked_item_flag = inv:room_for_item("dst", cooked.item)

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
                    if still_room_for_cooked_item_flag then

                        local leftover = inv:add_item("dst", cooked.item)
                        local above = vector.new(pos.x, pos.y + 1, pos.z)
                        local drop_pos = minetest.find_node_near(above, 1, {"air"}) or above

                        if not leftover:is_empty() then

                          minetest.item_drop(cooked.item, nil, drop_pos)
                          still_room_for_cooked_item_flag = false

                        end

                        -- If there is a second item and there is room for it
                        if cooked.second_item ~= nil and
                                inv:room_for_item("dst", cooked.second_item) then

                            leftover = inv:add_item("dst", cooked.second_item)
                            -- If leftover of second item is not empty...
                            if not leftover:is_empty() then

                                dst_full_flag = true
                                still_room_for_cooked_item_flag = false
                                minetest.item_drop(cooked.second_item, nil, drop_pos)

                            end

                        end

                        -- If there is a replacement and there is room for it
                        if cooked.replacement ~= nil and
                                inv:room_for_item("dst", cooked.replacement) then

                            leftover = inv:add_item("dst", cooked.replacement)
                            -- If leftover of replacement is not empty...
                            if not leftover:is_empty() then

                                dst_full_flag = true
                                still_room_for_cooked_item_flag = false
                                minetest.item_drop(cooked.replacement, nil, drop_pos)

                            end

                        end

                        inv:set_stack("src", 1, aftercooked.items[1])
                        src_time = src_time - cooked.time

                        -- If src is now empty, try to take another item from src_slots
                        if inv:is_empty("src") and inv:is_empty("src_slots") == false then

                            if src_slots_list ~= nil then

                                local new_src = get_from_src_list(src_slots_list, src_slot_size)
                                if new_src ~= nil then

                                    inv:remove_item("src_slots", new_src)
                                    inv:set_stack("src", 1, new_src)

                                end

                            end

                        end

                        update_flag = true

                    else

                        dst_full_flag = true

                    end

                    -- Play cooling sound
                    minetest.sound_play(
                        "unilib_cool_lava",
                        {pos = pos, max_hear_distance = 16, gain = 0.1},
                        true
                    )

                else

                    -- Item could not be cooked: probably missing fuel
                    update_flag = true

                end

            end

        else

            -- Furnace ran out of fuel
            if cookable and still_room_for_cooked_item_flag then

                -- We need to get new fuel
                local afterfuel
                fuel, afterfuel = minetest.get_craft_result(
                    {method = "fuel", width = 1, items = fuel_list}
                )

                if fuel.time == 0 then

                    -- No valid fuel in fuel list
                    fuel_totaltime = 0
                    src_time = 0

                else

                    -- Take fuel from fuel list
                    inv:set_stack("fuel", 1, afterfuel.items[1])
                    -- Put replacements in dst list or drop them on the furnace
                    local replacements = fuel.replacements
                    if replacements[1] then

                        local leftover = inv:add_item("dst", replacements[1])
                        if not leftover:is_empty() then

                            local above = vector.new(pos.x, pos.y + 1, pos.z)
                            local drop_pos = minetest.find_node_near(above, 1, {"air"}) or above
                            minetest.item_drop(replacements[1], nil, drop_pos)

                        end

                    end

                    update_flag = true
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

    if fuel and fuel_totaltime > fuel.time then
        fuel_totaltime = fuel.time
    end

    if src_list and src_list[1]:is_empty() then
        src_time = 0
    end

    -- Update formspec, infotext and node
    local formspec
    local item_state
    local item_percent = 0
    if cookable then

        item_percent = math.floor(src_time / cooked.time * 100)
        if dst_full_flag or still_room_for_cooked_item_flag == false then
            item_state = S("100% (output full)")
        else
            item_state = S("@1%", item_percent)
        end

    else

        if src_list and not src_list[1]:is_empty() then
            item_state = S("Cannot be boiled")
        else
            item_state = S("Empty")
        end

    end

    local remaining_inputs = get_stack_count(src_slots_list, src_slot_size)
    local slot_state
    if src_slots_list and remaining_inputs > 0 then
        slot_state = remaining_inputs .. S("Stacks in Input Slots")
    else
        slot_state = S("Input Slot Empty")
    end

    local fuel_state = S("No Fuel")
    local active = false
    local result = false

    if fuel_totaltime ~= 0 and dst_full_flag == false then

        active = true
        local fuel_percent = 100 - math.floor(fuel_time / fuel_totaltime * 100)
        fuel_state = S("@1%", fuel_percent)
        formspec = get_cauldron_active_formspec(fuel_percent, item_percent)
        swap_node(pos, "unilib:machine_cauldron_milk_active")
        -- Make sure the timer restarts automatically
        result = true

        -- Play sound every 9 seconds while the furnace is active
        if timer_elapsed == 0 or (timer_elapsed + 1) % 9 == 0 then

            minetest.sound_play(
                "unilib_cauldron_active",
                {pos = pos, max_hear_distance = 16, gain = 0.5},
                true
            )

        end

    else

        if fuel_list and not fuel_list[1]:is_empty() then
            fuel_state = S("@1%", 0)
        end

        formspec = get_cauldron_inactive_formspec()
        swap_node(pos, "unilib:machine_cauldron_milk")
        -- Stop timer on the inactive furnace
        minetest.get_node_timer(pos):stop()
        meta:set_int("timer_elapsed", 0)

    end

    local infotext
    if active then
        infotext = S("Cauldron boiling")
    else
        infotext = S("Cauldron inactive")
    end

    infotext = infotext .. "\n" .. S("(Item: @1; Fuel: @2)", item_state, fuel_state)
             .. "\n(" .. slot_state .. ")"

    -- Set meta values
    meta:set_float("fuel_totaltime", fuel_totaltime)
    meta:set_float("fuel_time", fuel_time)
    meta:set_float("src_time", src_time)
    meta:set_int("remaining_inputs", remaining_inputs)
    meta:set_string("formspec", formspec)
    meta:set_string("infotext", infotext)

    return result

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_cauldron_milk.init()

    return {
        description = "Milk cauldron",
        notes = "A special type of furnace, used to cook particular ingredients (e.g. cook milk" ..
                " to get curd and whey; cook ordinary water to get salt). In the formspec, the" ..
                " ingredient and fuel is added in the middle; more ingredients can be added on" ..
                " the left. The original code required an external mod to provide milk, but" ..
                " unilib provides several packages with milk substitutes which can be used in " ..
                " milk cauldrons (if the Minetest setting has been enabled",
        depends = {
            "bucket_steel",
            "food_cheese_ricotta",
            "ingredient_curd",
            "ingredient_salt_normal",
            "ingredient_whey",
            "metal_copper",
            "vessel_bottle_glass_empty",
        },
        optional = {
            "bucket_steel_with_bones",
            "bucket_steel_with_seaweed",
            "bucket_wood",
            "ingredient_agar_powder",
            "ingredient_gelatin_powder",
            -- Provide a milk substitute, if an external mod provides no milk
            "food_milk_coconut",
            "food_milk_soy",
            "food_milk_soy_red",
        },
    }

end

function unilib.pkg.machine_cauldron_milk.exec()

    unilib.register_node("unilib:machine_cauldron_milk", "cheese:milk_cauldron", mode, {
        -- From cheese:milk_cauldron
        description = S("Milk Cauldron"),
        tiles = {
            "unilib_machine_cauldron_milk_top.png",
            "unilib_machine_cauldron_milk_top.png",
            "unilib_machine_cauldron_milk_side.png",
            "unilib_machine_cauldron_milk_side.png",
            "unilib_machine_cauldron_milk_side.png",
            "unilib_machine_cauldron_milk_side.png",
        },
        groups = {cracky = 2},
        sounds = unilib.sound_table_metal,

        collision_box = selection_box,
        drawtype = "nodebox",
        is_ground_content = false,
        node_box = inactive_nodebox,
        paramtype = "light",
        selection_box = selection_box,
        use_texture_alpha = "clip",

        allow_metadata_inventory_move = allow_metadata_inventory_move,

        allow_metadata_inventory_put = allow_metadata_inventory_put,

        allow_metadata_inventory_take = allow_metadata_inventory_take,

        can_dig = can_dig,

        on_blast = function(pos)

            local drops = {}
            unilib.get_inventory_drops(pos, "src_slots", drops)
            unilib.get_inventory_drops(pos, "src", drops)
            unilib.get_inventory_drops(pos, "fuel", drops)
            unilib.get_inventory_drops(pos, "dst", drops)

            drops[#drops + 1] = "unilib:machine_cauldron_milk"
            minetest.remove_node(pos)
            return drops

        end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            inv:set_size('src', 1)
            inv:set_size('src_slots', 12)
            inv:set_size('fuel', 1)
            inv:set_size('dst', 8)
            cauldron_node_timer(pos, 0)

        end,

        on_metadata_inventory_move = function(pos)

            minetest.get_node_timer(pos):start(1.0)
        end,

        on_metadata_inventory_put = function(pos)

            -- Decide whether the furnace can burn or not
            minetest.get_node_timer(pos):start(1.0)

        end,

        on_metadata_inventory_take = function(pos)

            -- Check whether the furnace is empty or not
            minetest.get_node_timer(pos):start(1.0)

        end,

        on_timer = cauldron_node_timer,
    })
    unilib.register_craft({
        -- From cheese:milk_cauldron
        output = "unilib:machine_cauldron_milk",
        recipe = {
            {"unilib:metal_copper_ingot", "", "unilib:metal_copper_ingot"},
            {"unilib:metal_copper_ingot", "", "unilib:metal_copper_ingot"},
            {"unilib:metal_copper_ingot", "unilib:metal_copper_ingot", "unilib:metal_copper_ingot"},
        },
    })

    unilib.register_node(
        -- From cheese:milk_cauldron_active
        "unilib:machine_cauldron_milk_active",
        "cheese:milk_cauldron_active",
        mode,
        {
            description = S("Milk Cauldron"),
            tiles = {
                {
                    image = "unilib_machine_cauldron_milk_active_top.png",
                    backface_culling = false,
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 32,
                        aspect_h = 32,
                        length = 2.5,
                    },
                },
                "unilib_machine_cauldron_milk_top.png",
                "unilib_machine_cauldron_milk_active_side.png",
                "unilib_machine_cauldron_milk_active_side.png",
                "unilib_machine_cauldron_milk_active_side.png",
                "unilib_machine_cauldron_milk_active_side.png",
            },
            groups = {cracky = 2, not_in_creative_inventory = 1},
            sounds = unilib.sound_table_metal,

            collision_box = selection_box,
            drawtype = "nodebox",
            drop = "unilib:machine_cauldron_milk",
            is_ground_content = false,
            light_source = 8,
            node_box = active_nodebox,
            paramtype = "light",
            selection_box = selection_box,
            use_texture_alpha = "clip",

            allow_metadata_inventory_move = allow_metadata_inventory_move,

            allow_metadata_inventory_put = allow_metadata_inventory_put,

            allow_metadata_inventory_take = allow_metadata_inventory_take,

            can_dig = can_dig,

            on_timer = cauldron_node_timer,
        }
    )

end

function unilib.pkg.machine_cauldron_milk.post()

    recipe_list = {
        -- input item, output item, second item, replacement, boiling time
        {"unilib:ingredient_whey", "unilib:food_cheese_ricotta", nil, nil, 15},
    }

    if minetest.get_modpath("animalia") then

        table.insert(recipe_list, {
            "animalia:bucket_milk",
            "unilib:ingredient_curd",
            "unilib:ingredient_whey",
            "unilib:bucket_steel_empty",
            8,
        })

    end

    if minetest.get_modpath("mobs_animal") then

        table.insert(recipe_list, {
            "mobs:bucket_milk",
            "unilib:ingredient_curd",
            "unilib:ingredient_whey",
            "unilib:bucket_steel_empty",
            8,
        })

        if unilib.pkg_executed_table["bucket_wood"] ~= nil then

            table.insert(recipe_list, {
                "mobs:wooden_bucket_milk",
                "unilib:ingredient_curd",
                "unilib:ingredient_whey",
                "unilib:bucket_wood_empty",
                8,
            })

        end

    end

    if minetest.get_modpath("petz") then

        table.insert(recipe_list, {
            "petz:bucket_milk",
            "unilib:ingredient_curd",
            "unilib:ingredient_whey",
            "unilib:bucket_steel_empty",
            8,
        })

    end

    -- Allow imitation cheeses only if the Minetest setting is enabled (as the original mod doesn't
    --      permit that)
    if unilib.cheese_allow_imitation_flag then

        if unilib.pkg_executed_table["food_milk_coconut"] ~= nil then

            table.insert(recipe_list, {
                "unilib:food_milk_coconut",
                "unilib:ingredient_curd",
                "unilib:ingredient_whey",
                "unilib:vessel_glass_empty",
                8,
            })

        end

        if unilib.pkg_executed_table["food_milk_soy"] ~= nil then

            table.insert(recipe_list, {
                "unilib:food_milk_soy",
                "unilib:ingredient_curd",
                "unilib:ingredient_whey",
                "unilib:vessel_glass_empty",
                8,
            })

        end

        if unilib.pkg_executed_table["food_milk_soy_red"] ~= nil then

            table.insert(recipe_list, {
                "unilib:food_milk_soy_red",
                "unilib:ingredient_curd",
                "unilib:ingredient_whey",
                "unilib:vessel_glass_empty",
                8,
            })

        end

    end

    for bucket_type, _ in pairs(unilib.generic_bucket_table) do

        local c_water_bucket = "unilib:" .. bucket_type .. "_with_water_ordinary"
        local c_empty_bucket = "unilib:" .. bucket_type .. "_empty"

        table.insert(recipe_list, {
            c_water_bucket,
            "unilib:ingredient_salt_normal",
            nil,
            c_empty_bucket,
            8,
        })

    end

    -- (These items only available in steel buckets)
    if unilib.pkg_executed_table["bucket_steel_with_seaweed"] ~= nil and
            unilib.pkg_executed_table["ingredient_agar_powder"] ~= nil then

        table.insert(recipe_list, {
            "unilib:bucket_steel_with_seaweed",
            "unilib:ingredient_agar_powder 2",
            nil,
            "unilib:bucket_steel_empty",
            8,
        })

    end

    if unilib.pkg_executed_table["bucket_steel_with_bones"] ~= nil and
            unilib.pkg_executed_table["ingredient_gelatin_powder"] ~= nil then

        table.insert(recipe_list, {
            "unilib:bucket_steel_with_bones",
            "unilib:ingredient_gelatin_powder 2",
            nil,
            "unilib:bucket_steel_empty",
            8,
        })

    end

    -- Recipes complete, now update unified_inventory/I3 (if loaded) with custom craft types
    if minetest.get_modpath("unified_inventory") ~= nil then

        unified_inventory.register_craft_type("cauldron_boiling", {
            description = S("Boiling"),
            icon = "unilib_machine_cauldron_milk_active_side.png",
            width = 1,
            height = 1,
            uses_crafting_grid = false
        })

    elseif minetest.get_modpath("i3") ~= nil then

        i3.register_craft_type("cauldron_boiling", {
            description = S("Boiling"),
            icon = "unilib_machine_cauldron_milk_active_side.png",
        })

    end

    for _, mini_list in pairs(recipe_list) do

        if minetest.get_modpath("unified_inventory") ~= nil then

            unified_inventory.register_craft({
                type = "cauldron_boiling",
                items = {mini_list[1]},
                output = mini_list[2],
            })

            if mini_list[3] ~= nil then

                unified_inventory.register_craft({
                    type = "cauldron_boiling",
                    items = {mini_list[1]},
                    output = mini_list[3],
                })

            end

        elseif minetest.get_modpath("i3") ~= nil then

            i3.register_craft({
                type = "cauldron_boiling",
                items = {mini_list[1]},
                result = mini_list[2],
            })

            if mini_list[3] ~= nil then

                i3.register_craft({
                    type = "cauldron_boiling",
                    items = {mini_list[1]},
                    result = mini_list[3],
                })

            end

        end

    end

end
