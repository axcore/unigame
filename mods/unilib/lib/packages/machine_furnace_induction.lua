---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_furnace_induction = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Fuels are consumed at four times the rate of an ordinary furnace
local fuel_factor = 4
-- The time taken, in seconds, to produce one molten item. Should be a multiple of 5 seconds to
--      make the sound effect start and stop at the right times
local output_total_time = 60

---------------------------------------------------------------------------------------------------
-- Local functions (general)
---------------------------------------------------------------------------------------------------

local function get_formspec(description)

    return "size[8,7.5]" ..
            "label[0,0;" .. description .. "]" ..
            "image[1,1;1,1;unilib_metal_steel_ingot.png]" ..
            "list[current_name;metal;2,1;1,1;]" ..
            "image[3,1;1,1;unilib_bucket_steel_empty.png]" ..
            "list[current_name;bucket;4,1;1,1;]" ..
            "image[5,1;1,1;unilib_mineral_coal_lump.png]" ..
            "list[current_name;fuel;6,1;1,1;]" ..
            "image[3,2;1,1;unilib_bucket_steel_empty.png^unilib_bucket_molten_steel_overlay.png]" ..
            "list[current_name;output;4,2;1,1;]" ..
            "list[current_player;main;0,3.5;8,4;]" ..
            "listring[current_player;main]" ..
            "listring[current_name;metal]" ..
            "listring[current_player;main]" ..
            "listring[current_name;bucket]" ..
            "listring[current_player;main]" ..
            "listring[current_name;fuel]" ..
            "listring[current_player;main]" ..
            "listring[current_name;output]" ..
            "listring[current_player;main]"

end

local function consume_fuel(pos)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    local fuel_stack = inv:get_stack("fuel", 1)
    local fuel_count = fuel_stack:get_count()
    if fuel_count < fuel_factor then
        return 0
    end

    output_table, decremented_input = core.get_craft_result({
        method = "fuel",
        width = 1,
        items = inv:get_list("fuel"),
    })

    local output_time = output_table.time
    if output_time > 0 then

        fuel_stack:set_count(fuel_count - fuel_factor)
        inv:set_stack("fuel", 1, fuel_stack)

        return math.ceil(output_time / fuel_factor)

    else

        return 0

    end

end

local function switch_to_active_furnace(pos, fuel_total_time)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    local metal_stack = inv:get_stack("metal", 1)
    local bucket_stack = inv:get_stack("bucket", 1)
    local fuel_stack = inv:get_stack("fuel", 1)
    local old_node = core.get_node(pos)

    core.swap_node(
        pos, {name = "unilib:machine_furnace_induction_active", param2 = old_node.param2}
    )

    local new_meta = core.get_meta(pos)
    new_meta:set_string("metal_type", meta:get_string("metal_type"))
    new_meta:set_string("bucket_type", meta:get_string("bucket_type"))
    new_meta:set_int("fuel_total_time", fuel_total_time)
    new_meta:set_int("output_total_time", output_total_time)

    local new_inv = new_meta:get_inventory()
    new_inv:set_stack("metal", 1, metal_stack)
    new_inv:set_stack("bucket", 1, bucket_stack)
    new_inv:set_stack("fuel", 1, fuel_stack)

end

local function switch_to_inactive_furnace(pos)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    local metal_stack = inv:get_stack("metal", 1)
    local bucket_stack = inv:get_stack("bucket", 1)
    local fuel_stack = inv:get_stack("fuel", 1)
    local old_node = core.get_node(pos)

    core.swap_node(pos, {name = "unilib:machine_furnace_induction", param2 = old_node.param2})

    local new_meta = core.get_meta(pos)
    new_meta:set_string("metal_type", meta:get_string("metal_type"))
    new_meta:set_string("bucket_type", meta:get_string("bucket_type"))
    new_meta:set_int("fuel_elapsed_time", 0)
    new_meta:set_int("fuel_total_time", 0)
    new_meta:set_int("output_elapsed_time", 0)
    new_meta:set_int("output_total_time", output_total_time)

    local new_inv = new_meta:get_inventory()
    new_inv:set_stack("metal", 1, metal_stack)
    new_inv:set_stack("bucket", 1, bucket_stack)
    new_inv:set_stack("fuel", 1, fuel_stack)

end

---------------------------------------------------------------------------------------------------
-- Local functions (callbacks)
---------------------------------------------------------------------------------------------------

local function allow_metadata_inventory_put(pos, listname, index, stack, player)

    if listname == "metal" then

        -- Accept metal blocks/ingots that have a corresponding molten item
        -- Also accept any mineral blocks that have a molten form; at the time of writing, that is
        --      only mese
        local stack_name = stack:get_name()
        local metal_type
        for _, regex in ipairs({
            "^unilib:metal_(.*)_block",
            "^unilib:metal_(.*)_ingot",
            "^unilib:mineral_(.*)_block",
        }) do

            metal_type = string.match(stack_name, regex)
            if metal_type ~= nil then
                break
            end

        end

        if metal_type == nil then
            return 0
        end

        local source_name = "unilib:liquid_molten_" .. metal_type .. "_source"
        if core.registered_items[source_name] == nil then

            return 0

        else

            local meta = core.get_meta(pos)
            meta:set_string("metal_type", metal_type)
            return stack:get_count()

        end

    elseif listname == "bucket" then

        -- Accept non-flammable buckets
        local stack_name = stack:get_name()
        local bucket_type = unilib.global.empty_bucket_table[stack_name]
        if bucket_type == nil then
            return 0
        end

        local data_table = unilib.global.generic_bucket_table[bucket_type]
        if data_table.burntime ~= 0 then

            return 0

        else

            local meta = core.get_meta(pos)
            meta:set_string("bucket_type", bucket_type)
            return stack:get_count()

        end

    elseif listname == "fuel" then

        return stack:get_count()

    else

        return 0

    end

end

local function can_dig(pos)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    if inv:is_empty("metal") and
            inv:is_empty("bucket") and
            inv:is_empty("fuel") and
            inv:is_empty("output") then
        return true
    else
        return false
    end

end

local function on_metadata_inventory_take(pos, listname, index, stack, player)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    if listname == "metal" and inv:is_empty("metal") then
        meta:set_string("metal_type", "")
    elseif listname == "bucket" and inv:is_empty("bucket") then
        meta:set_string("bucket_type", "")
    end

    -- Check whether the furnace is empty or not
    core.get_node_timer(pos):start(1.0)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_furnace_induction.init()

    return {
        description = "Induction furnace",
        notes = "Melts compatible metal blocks and ingots. Suitable mineral blocks (such as" ..
                " mese can also be converted into a molten form. Requires much more fuel than an" ..
                " ordinary furnace, and takes a minute to produce a single bucket of molten" ..
                " material",
        depends = {"brick_ordinary", "metal_steel"},
    }

end

function unilib.pkg.machine_furnace_induction.exec()

    local c_brick = "unilib:brick_ordinary"
    local c_ingot = "unilib:metal_steel_ingot"
    local description = S("Induction Furnace")

    unilib.register_node("unilib:machine_furnace_induction", nil, mode, {
        -- Original to unilib
        description = description,
        tiles = {
            "unilib_machine_furnace_induction_top.png",
            "unilib_machine_furnace_induction_bottom.png",
            "unilib_machine_furnace_induction_side.png",
            "unilib_machine_furnace_induction_side.png",
            "unilib_machine_furnace_induction_side.png",
            "unilib_machine_furnace_induction_front.png",
        },
        groups = {cracky = 1},
        -- (no sounds)

        is_ground_content = false,
        paramtype2 = "facedir",

        allow_metadata_inventory_put = allow_metadata_inventory_put,

        can_dig = can_dig,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()

            meta:set_string("formspec", get_formspec(description))
            meta:set_string("infotext", description)
            -- (Only extract the types once, when items are placed in the inventories)
            meta:set_string("metal_type", "")
            meta:set_string("bucket_type", "")

            inv:set_size("metal", 1)
            inv:set_size("bucket", 1)
            inv:set_size("fuel", 1)
            inv:set_size("output", 1)

        end,

        on_metadata_inventory_put = function(pos)

            -- Start timer function, it will sort out whether furnace can burn or not
            core.get_node_timer(pos):start(1.0)

        end,

        on_metadata_inventory_take = on_metadata_inventory_take,

        on_timer = function(pos, elapsed)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()

            -- Do we have the right ingredients?
            if meta:get_string("metal_type") == "" or meta:get_string("bucket_type") == "" then
                return
            end

            local fuel_total_time = consume_fuel(pos)
            if fuel_total_time == 0 then
                return
            end

            -- Fuel consumed; start the cooking cycle
            switch_to_active_furnace(pos, fuel_total_time)
            core.get_node_timer(pos):start(1.0)

        end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:machine_furnace_induction",
        recipe = {
            {c_ingot, c_brick, c_ingot},
            {c_brick, "", c_brick},
            {c_ingot, c_brick, c_ingot},
        },
    })

    unilib.register_node("unilib:machine_furnace_induction_active", nil, mode, {
        -- Original to unilib
        description = description,
        tiles = {
            "unilib_machine_furnace_induction_top.png",
            "unilib_machine_furnace_induction_bottom.png",
            "unilib_machine_furnace_induction_side.png",
            "unilib_machine_furnace_induction_side.png",
                "unilib_machine_furnace_induction_side.png",
            {
                image = "unilib_machine_furnace_induction_active_front.png",
                backface_culling = false,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1.5,
                },
            },
        },
        groups = {active_furnace = 1, cracky = 1, not_in_creative_inventory = 1},
        -- (no sounds)

        drop = "unilib:machine_furnace_induction",
        is_ground_content = false,
        paramtype2 = "facedir",

        allow_metadata_inventory_put = allow_metadata_inventory_put,

        can_dig = can_dig,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()

            meta:set_string("formspec", get_formspec(description))
            meta:set_string("infotext", description)
            -- (Only extract the types once, when items are placed in the inventories)
            meta:set_string("metal_type", "")
            meta:set_string("bucket_type", "")
            meta:set_int("fuel_elapsed_time", 0)
            meta:set_int("fuel_total_time", 0)
            meta:set_int("output_elapsed_time", 0)
            meta:set_int("output_total_time", output_total_time)

            inv:set_size("metal", 1)
            inv:set_size("bucket", 1)
            inv:set_size("fuel", 1)
            inv:set_size("output", 1)

        end,

        on_metadata_inventory_take = on_metadata_inventory_take,

        on_timer = function(pos, elapsed)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()

            -- Do we have still have the right ingredients?
            local metal_type = meta:get_string("metal_type")
            local bucket_type = meta:get_string("bucket_type")
            if metal_type == "" or bucket_type == "" then

                -- No output and halt timer
                switch_to_inactive_furnace(pos)
                return

            end

            -- Is there room in the output slot?
            local output_name = "unilib:" .. meta:get_string("bucket_type") .. "_with_molten_" ..
                    meta:get_string("metal_type")
            if not inv:room_for_item("output", ItemStack(output_name)) then

                -- No output and halt timer
                switch_to_inactive_furnace(pos)
                return

            end

            -- Produce output
            local output_elapsed_time = meta:get_int("output_elapsed_time")
            if output_elapsed_time >= meta:get_int("output_total_time") then

                inv:add_item("output", ItemStack(output_name))
                meta:set_int("output_elapsed_time", 0)

                -- Consume ingredients - 9 ingots/1 block, and 1 bucket
                local metal_stack = inv:get_stack("metal", 1)
                local metal_name = metal_stack:get_name()
                if string.find(metal_name, "_ingot$") then
                    inv:remove_item("metal", ItemStack(metal_name .. " 9"))
                else
                    inv:remove_item("metal", ItemStack(metal_name))
                end

                metal_stack = inv:get_stack("metal", 1)
                if metal_stack:get_count() == 0 then
                    meta:set_string("metal_type", "")
                end

                local bucket_stack = inv:get_stack("bucket", 1)
                inv:remove_item("bucket", ItemStack(bucket_stack:get_name()))

                bucket_stack = inv:get_stack("bucket", 1)
                if bucket_stack:get_count() == 0 then
                    meta:set_string("bucket_type", "")
                end

                if meta:get_string("metal_type") == "" or meta:get_string("bucket_type") == "" then

                    -- Ingredients exhausted, halt timer
                    switch_to_inactive_furnace(pos)
                    return

                end

            else

                meta:set_int("output_elapsed_time", output_elapsed_time + 1)

            end

            -- Consume fuel
            local fuel_elapsed_time = meta:get_int("fuel_elapsed_time")
            if fuel_elapsed_time >= meta:get_int("fuel_total_time") then

                local fuel_total_time = consume_fuel(pos)
                if fuel_total_time == 0 then

                    -- Fuel exhausted, halt timer
                    switch_to_inactive_furnace(pos)
                    return

                else

                    meta:set_int("fuel_elapsed_time", 1)
                    meta:set_int("fuel_total_time", fuel_total_time)

                end

            else

                meta:set_int("fuel_elapsed_time", fuel_elapsed_time + 1)

            end

            -- Play sound every 5 seconds while the furnace is active
            if fuel_elapsed_time == 0 or (fuel_elapsed_time + 1) % 5 == 0 then

                core.sound_play(
                    "unilib_furnace_active",
                    {pos = pos, max_hear_distance = 16, gain = 0.5},
                    true
                )

            end

            -- Continue the cooking cycle
            return true

        end,
    })

end
