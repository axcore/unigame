---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_polishing = {}

local S = unilib.intllib
local F = core.formspec_escape
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- The time taken to "burn" a mese crystal (the time to "burn" a mese block is 9 times higher)
local fuel_burn_time = 5
-- The time taken, in seconds, to produce one gem (does not need to be a multiple of 5)
local output_total_time = 45

---------------------------------------------------------------------------------------------------
-- Local functions (general)
---------------------------------------------------------------------------------------------------

local function get_formspec(description)

    return "size[8,7.5]" ..
            "label[0,0;" .. F(description) .. "]" ..
            "image[1,1;1,1;unilib_mineral_diamond_lump.png]" ..
            "list[current_name;mineral;2,1;1,1;]" ..
            "image[3,1;1,1;unilib_bucket_steel_empty.png" ..
                    "^unilib_bucket_water_ordinary_overlay.png]" ..
            "list[current_name;bucket;4,1;1,1;]" ..
            "image[5,1;1,1;unilib_mineral_mese_crystal.png]" ..
            "list[current_name;fuel;6,1;1,1;]" ..
            "image[1,2;1,1;unilib_mineral_diamond_gem.png]" ..
            "list[current_name;output;2,2;1,1;]" ..
            "image[3,2;1,1;unilib_bucket_steel_empty.png]" ..
            "list[current_name;spare;4,2;1,1;]" ..
            "list[current_player;main;0,3.5;8,4;]" ..
            "listring[current_player;main]" ..
            "listring[current_name;mineral]" ..
            "listring[current_player;main]" ..
            "listring[current_name;bucket]" ..
            "listring[current_player;main]" ..
            "listring[current_name;fuel]" ..
            "listring[current_player;main]" ..
            "listring[current_name;output]" ..
            "listring[current_player;main]" ..
            "listring[current_name;spare]" ..
            "listring[current_player;main]"

end

local function consume_fuel(pos)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    local fuel_stack = inv:get_stack("fuel", 1)
    local fuel_name = fuel_stack:get_name()
    local fuel_count = fuel_stack:get_count()

    if fuel_count < 1 then
        return 0
    end

    fuel_stack:set_count(fuel_count - 1)
    inv:set_stack("fuel", 1, fuel_stack)
    if fuel_name == "unilib:mineral_mese_block" then
        return fuel_burn_time * 9
    elseif fuel_name == "unilib:mineral_mese_crystal_large" then
        return fuel_burn_time * 2
    else
        return fuel_burn_time
    end

end

local function switch_to_active_machine(pos, fuel_total_time)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    local mineral_stack = inv:get_stack("mineral", 1)
    local bucket_stack = inv:get_stack("bucket", 1)
    local fuel_stack = inv:get_stack("fuel", 1)
    local old_node = core.get_node(pos)

    core.swap_node(pos, {name = "unilib:machine_polishing_active", param2 = old_node.param2})

    local new_meta = core.get_meta(pos)
    new_meta:set_string("mineral_type", meta:get_string("mineral_type"))
    new_meta:set_string("bucket_type", meta:get_string("bucket_type"))
    new_meta:set_int("fuel_total_time", fuel_total_time)
    new_meta:set_int("output_total_time", output_total_time)

    local new_inv = new_meta:get_inventory()
    new_inv:set_stack("mineral", 1, mineral_stack)
    new_inv:set_stack("bucket", 1, bucket_stack)
    new_inv:set_stack("fuel", 1, fuel_stack)

end

local function switch_to_inactive_machine(pos)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    local mineral_stack = inv:get_stack("mineral", 1)
    local bucket_stack = inv:get_stack("bucket", 1)
    local fuel_stack = inv:get_stack("fuel", 1)
    local old_node = core.get_node(pos)

    core.swap_node(pos, {name = "unilib:machine_polishing", param2 = old_node.param2})

    local new_meta = core.get_meta(pos)
    new_meta:set_string("mineral_type", meta:get_string("mineral_type"))
    new_meta:set_string("bucket_type", meta:get_string("bucket_type"))
    new_meta:set_int("fuel_elapsed_time", 0)
    new_meta:set_int("fuel_total_time", 0)
    new_meta:set_int("output_elapsed_time", 0)
    new_meta:set_int("output_total_time", output_total_time)

    local new_inv = new_meta:get_inventory()
    new_inv:set_stack("mineral", 1, mineral_stack)
    new_inv:set_stack("bucket", 1, bucket_stack)
    new_inv:set_stack("fuel", 1, fuel_stack)

end

---------------------------------------------------------------------------------------------------
-- Local functions (callbacks)
---------------------------------------------------------------------------------------------------

local function allow_metadata_inventory_put(pos, listname, index, stack, player)

    if listname == "mineral" then

        -- Accept mineral lumps that have a corresponding gem
        -- Some minerals (including mese) have crystal variants instead of/as well as gems
        local stack_name = stack:get_name()
        local mineral_type = string.match(stack_name, "^unilib:mineral_(.*)_lump")
        if mineral_type == nil then
            return 0
        end

        local gem_name = "unilib:mineral_" .. mineral_type .. "_gem"
        if core.registered_items[gem_name] == nil then

            return 0

        else

            local meta = core.get_meta(pos)
            meta:set_string("mineral_type", mineral_type)
            return stack:get_count()

        end

    elseif listname == "bucket" then

        -- Accept all water buckets
        local stack_name = stack:get_name()
        local data_table = unilib.global.full_bucket_table[stack_name]
        if data_table == nil or data_table.water_flag == nil or data_table.water_flag == false then

            return 0

        else

            local meta = core.get_meta(pos)
            meta:set_string("bucket_type", data_table.bucket_type)
            return stack:get_count()

        end

    elseif listname == "fuel" then

        -- Accept only mese blocks/crystals
        local stack_name = stack:get_name()
        if stack_name ~= "unilib:mineral_mese_block" and
                stack_name ~= "unilib:mineral_mese_crystal_large" and
                stack_name ~= "unilib:mineral_mese_crystal" then
            return 0
        else
            return stack:get_count()
        end

    else

        return 0

    end

end

local function can_dig(pos)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    if inv:is_empty("mineral") and
            inv:is_empty("bucket") and
            inv:is_empty("fuel") and
            inv:is_empty("output") and
            inv:is_empty("spare") then
        return true
    else
        return false
    end

end

local function on_metadata_inventory_take(pos, listname, index, stack, player)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    if listname == "mineral" and inv:is_empty("mineral") then
        meta:set_string("mineral_type", "")
    elseif listname == "bucket" and inv:is_empty("bucket") then
        meta:set_string("bucket_type", "")
    end

    -- Check whether the machine is empty or not
    core.get_node_timer(pos):start(1.0)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_polishing.init()

    return {
        description = "Gem-polishing machine",
        notes = "Polishes compatible mineral lumps to produce gems. Typically, mineral packages" ..
                " will create gems only when this package is loaded. In a few cases (such as" ..
                " diamonds from minetest_game), ores will drop lumps instead of the finished" ..
                " gems, when this polisher is available. To place a limit on the number of" ..
                " \"precious\" gems a player can produce, the machine consumes a single mese" ..
                " block (or nine mese crystals) to polish a single gem, taking forty-five" ..
                " seconds to do so",
        depends = {"metal_steel", "mineral_mese"},
    }

end

function unilib.pkg.machine_polishing.exec()

    local c_crystal = "unilib:mineral_mese_crystal"
    local c_ingot = "unilib:metal_steel_ingot"
    local description = S("Gem-Polishing Machine")

    unilib.register_node("unilib:machine_polishing", nil, mode, {
        -- Original to unilib
        description = description,
        tiles = {
            "unilib_machine_polishing_top.png",
            "unilib_machine_polishing_bottom.png",
            "unilib_machine_polishing_side.png",
            "unilib_machine_polishing_side.png",
            "unilib_machine_polishing_side.png",
            "unilib_machine_polishing_front.png",
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
            meta:set_string("mineral_type", "")
            meta:set_string("bucket_type", "")

            inv:set_size("mineral", 1)
            inv:set_size("bucket", 1)
            inv:set_size("fuel", 1)
            inv:set_size("output", 1)
            inv:set_size("spare", 1)

        end,

        on_metadata_inventory_put = function(pos)

            -- Start timer function, it will sort out whether machine can polish or not
            core.get_node_timer(pos):start(1.0)

        end,

        on_metadata_inventory_take = on_metadata_inventory_take,

        on_timer = function(pos, elapsed)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()

            -- Do we have the right ingredients?
            if meta:get_string("mineral_type") == "" or meta:get_string("bucket_type") == "" then
                return
            end

            local fuel_total_time = consume_fuel(pos)
            if fuel_total_time == 0 then
                return
            end

            -- Fuel consumed; start the polishing cycle
            switch_to_active_machine(pos, fuel_total_time)
            core.get_node_timer(pos):start(1.0)

        end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:machine_polishing",
        recipe = {
            {c_ingot, c_crystal, c_ingot},
            {c_crystal, "", c_crystal},
            {c_ingot, c_crystal, c_ingot},
        },
    })

    unilib.register_node("unilib:machine_polishing_active", nil, mode, {
        -- Original to unilib
        description = description,
        tiles = {
            "unilib_machine_polishing_top_active.png",
            "unilib_machine_polishing_bottom.png",
            "unilib_machine_polishing_side.png",
            "unilib_machine_polishing_side.png",
            "unilib_machine_polishing_side.png",
            "unilib_machine_polishing_front.png",
        },
        groups = {cracky = 1, not_in_creative_inventory = 1},
        -- (no sounds)

        drop = "unilib:machine_polishing",
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
            meta:set_string("mineral_type", "")
            meta:set_string("bucket_type", "")
            meta:set_int("fuel_elapsed_time", 0)
            meta:set_int("fuel_total_time", 0)
            meta:set_int("output_elapsed_time", 0)
            meta:set_int("output_total_time", output_total_time)

            inv:set_size("mineral", 1)
            inv:set_size("bucket", 1)
            inv:set_size("fuel", 1)
            inv:set_size("output", 1)
            inv:set_size("spare", 1)

        end,

        on_metadata_inventory_take = on_metadata_inventory_take,

        on_timer = function(pos, elapsed)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()

            -- Do we have still have the right ingredients?
            local mineral_type = meta:get_string("mineral_type")
            local bucket_type = meta:get_string("bucket_type")
            if mineral_type == "" or bucket_type == "" then

                -- No output and halt timer
                switch_to_inactive_machine(pos)
                return

            end

            -- Is there room in the output/spare bucket slots?
            local output_name = "unilib:mineral_" .. mineral_type .. "_gem"
            local spare_name = "unilib:" .. bucket_type .. "_empty"
            if not inv:room_for_item("output", ItemStack(output_name)) or
                    not inv:room_for_item("spare", ItemStack(spare_name)) then

                -- No output and halt timer
                switch_to_inactive_machine(pos)
                return

            end

            -- Produce output
            local output_elapsed_time = meta:get_int("output_elapsed_time")
            if output_elapsed_time >= meta:get_int("output_total_time") then

                inv:add_item("output", ItemStack(output_name))
                inv:add_item("spare", ItemStack(spare_name))
                meta:set_int("output_elapsed_time", 0)

                -- Consume ingredients - 9 mese crystals/1 mese block, and 1 bucket
                local mineral_stack = inv:get_stack("mineral", 1)
                inv:remove_item("mineral", ItemStack(mineral_stack:get_name()))

                mineral_stack = inv:get_stack("mineral", 1)
                if mineral_stack:get_count() == 0 then
                    meta:set_string("mineral_type", "")
                end

                local bucket_stack = inv:get_stack("bucket", 1)
                inv:remove_item("bucket", ItemStack(bucket_stack:get_name()))

                bucket_stack = inv:get_stack("bucket", 1)
                if bucket_stack:get_count() == 0 then
                    meta:set_string("bucket_type", "")
                end

                if meta:get_string("mineral_type") == "" or
                        meta:get_string("bucket_type") == "" then

                    -- Ingredients exhausted, halt timer
                    switch_to_inactive_machine(pos)
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
                    switch_to_inactive_machine(pos)
                    return

                else

                    meta:set_int("fuel_elapsed_time", 1)
                    meta:set_int("fuel_total_time", fuel_total_time)

                end

            else

                meta:set_int("fuel_elapsed_time", fuel_elapsed_time + 1)

            end

            -- Sound effect is only 1 second long, so play on every call to this function
            core.sound_play(
                "unilib_cart_moving",
                {pos = pos, max_hear_distance = 16, gain = 0.5},
                true
            )

            -- Continue the polishing cycle
            return true

        end,
    })

end
