---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_atomic_collector = {}

local S = unilib.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Debug flags, which (when true) can be used to pre-determine the results of any vapourisation
--      (for testing purposes)
-- Flag set to true, to assume tubes of all length are the optimal length
local debug_ignore_distance_flag = false
-- Flag set to true, if every vapourisation occurs with a probability of 1
local debug_max_probability_flag = false
-- Flag set to true, if every vapourisation produces the maximum number of samplings
local debug_max_quantity_flag = false

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_formspec_slot(x, y, slot)

    -- (Don't draw non-existent slots, obviously)
    if slot > unilib.pkg.shared_atomic.machine_size then
        return ""
    end

    return "image_button[" .. (x + 0.2) .. "," .. (y + 0.1) .. ";0.8,0.8;unilib_gui_discard.png" ..
                    ";discard" .. slot .. ";;;;]" ..
            "tooltip[discard" .. slot .. ";" .. FS("Discard items") .. "]" ..
            "list[current_name;input;" .. (x + 1) .. "," .. y .. ";1,1;" .. (slot - 1) .. "]" ..
            "list[current_name;output;" .. (x + 2) .. "," .. y .. ";1,1;" .. (slot - 1) .. "]"

end

local function get_formspec(description)

    return "size[8,9.5]" ..
            "label[0,0;" .. F(description) .. "]" ..
            get_formspec_slot(0, 1, 1) ..
            get_formspec_slot(0, 2, 2) ..
            get_formspec_slot(0, 3, 3) ..
            get_formspec_slot(0, 4, 4) ..
            get_formspec_slot(3, 1, 5) ..
            get_formspec_slot(3, 2, 6) ..
            get_formspec_slot(3, 3, 7) ..
            get_formspec_slot(3, 4, 8) ..
            "image_button[6.2,1.1;0.8,0.8;unilib_gui_discard.png;discard_spare;;;;]" ..
            "tooltip[discard_spare;" .. FS("Discard items") .. "]" ..
            "list[current_name;spare;7,1;1,1;]" ..
            "image_button[7,4;1,1;unilib_gui_discard_all.png;discard_all;;;;]" ..
            "tooltip[discard_all;" .. FS("Discard all items") .. "]" ..
            "list[current_player;main;0,5.5;8,4;]" ..
            "listring[current_player;main]" ..
            "listring[current_name;output]" ..
            "listring[current_player;main]"

end

local function generate_smoke(pos)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    if meta:get_string("spare_is_empty") == "true" then

        meta:set_string("spare_is_empty", "false")
        core.sound_play(
            "unilib_cool_lava",
            {pos = pos, gain = 1.0, max_hear_distance = unilib.pkg.shared_atomic.optimal_distance}
        )

    end

    inv:add_item("spare", ItemStack("unilib:sampling_smoke 1"))

end

local function get_first_real_item(list)

    -- unilib.pkg.shared_atomic.construct_table stores a list of up to two items, a unilib item
    --      name and the original mod's equivalent
    -- Check both, returning the first one that actually exists in the game

    for _, item in ipairs(list) do

        if core.registered_items[item] ~= nil then
            return item
        end

    end

end

local function do_vapourise(pos, element_name, sampling_name, quantity, max_quantity)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    local stack = ItemStack(sampling_name .. " " .. quantity)

    if not inv:room_for_item("input", stack) then

        -- If the "input" inventory is full of other items, convert the input item into a single
        --      wisp of smoke
        generate_smoke(pos)

    else

        -- There is enough room for the samplings in the machine's inventory
        inv:add_item("input", stack)

        -- The "input" inventory (containing, for example, gold samplings) is exactly analogous to
        --      the "output" inventory (containing, for example, the corresponding number of gold
        --      ingots)
        -- When the former is updated, the latter must be too
        local construct_mini_list = unilib.pkg.shared_atomic.construct_table[element_name]
        if construct_mini_list ~= nil then

            -- This sampling is convertable
            local construct_name = get_first_real_item(construct_mini_list[1])
            local construct_factor = construct_mini_list[2]
            for i = 1, unilib.pkg.shared_atomic.machine_size do

                -- Check every slot, to see if it contains this sampling
                local input_stack = inv:get_stack("input", i)
                if input_stack:get_name() == sampling_name and
                        input_stack:get_count() >= construct_factor then

                    -- This slot contains enough of the sampling to construct at least one output
                    --      item
                    inv:set_stack(
                        "output", i, ItemStack(
                            construct_name .. " " ..
                            math.floor(input_stack:get_count() / construct_factor)
                        )
                    )

                end

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_atomic_collector.receive_input(
    sender_pos, receiver_pos, vector_pos, input_name, distance
)
    -- Called by unilib:misc_atomic_tube_active's .on_timer() when items are received from the
    --      tube in the chain

    -- Convert the incoming item to its consituent elements ("samplings")
    local meta = core.get_meta(receiver_pos)
    local inv = meta:get_inventory()

    -- Calculate the baseline probability that each sampling will be produced. The baseline
    --      probability is 1 when input items have travelled through the optimal tube distance, and
    --      is reduced by a fraction for every tube above or below this value
    local baseline_probability = 1
    -- (Save columns by using local variables)
    local optimal_distance = unilib.pkg.shared_atomic.optimal_distance
    local tube_probability = unilib.pkg.shared_atomic.tube_probability_penalty
    if not debug_ignore_distance_flag then

        if distance > optimal_distance then

            baseline_probability =
                    baseline_probability - ((distance - optimal_distance) * tube_probability)

        elseif distance < optimal_distance then

            baseline_probability =
                    baseline_probability - ((optimal_distance - distance) * tube_probability)

        end

        if baseline_probability < 0 then
            baseline_probability = 0
        end

    end

    -- Incoming items can be "vapourised" into one or more samplings, in the proportions and
    --      probabilities specified by the vapourise.csv file in the "atomic" remix
    -- The contents of vapourise.csv are stored in two shared tables; one specifying the samplings
    --      for vapourised items directly, and another specifying the samplings for all items in a
    --      particular group
    -- For a full explanation of the calculation, see the comments in vapourise.csv
    --
    -- Extract all vapourisation data that applies to "input_name", eventually combining it into a
    --      single list
    local group_vapourise_list = {}
    local other_vapourise_list = {}
    local item_vapourise_list = {}

    local input_def_table = core.registered_items[input_name]
    if input_def_table.groups ~= nil then

        for group_name, _ in pairs(input_def_table.groups) do

            if unilib.pkg.shared_atomic.vapourise_group_table[group_name] ~= nil then

                for _, group_mini_list in ipairs(
                    unilib.pkg.shared_atomic.vapourise_group_table[group_name]
                ) do

                    -- "group_vapourise_list" can specify the word "other" in place of an element
                    --      name, in which case, data from"other_vapourise_list" is substituted into
                    --      it below, rather than being added to "item_vapourise_list"
                    if group_mini_list[1] == "other" then
                        table.insert(other_vapourise_list, group_mini_list)
                    else
                        table.insert(group_vapourise_list, group_mini_list)
                    end

                end

            end

        end

    end

    if unilib.pkg.shared_atomic.vapourise_item_table[input_name] ~= nil then

        for _, item_mini_list in ipairs(
            unilib.pkg.shared_atomic.vapourise_item_table[input_name]
        ) do
            table.insert(item_vapourise_list, item_mini_list)
        end

    end

    -- Substitute in data, as described above
    if #other_vapourise_list > 0 then

        local adj_vapourise_list = {}
        for _, other_mini_list in ipairs(other_vapourise_list) do

            local quantity = other_mini_list[2]
            local total_quantity = 0

            for _, item_mini_list in ipairs(item_vapourise_list) do
                total_quantity = total_quantity + item_mini_list[2]
            end

            for _, item_mini_list in ipairs(item_vapourise_list) do

                local new_mini_list = {
                    item_mini_list[1],
                    item_mini_list[2] * quantity / total_quantity,
                    item_mini_list[3],
                }

                table.insert(adj_vapourise_list, new_mini_list)

            end

        end

        item_vapourise_list = adj_vapourise_list

    end

    local combined_vapourise_list = {}
    for _, group_mini_list in ipairs(group_vapourise_list) do
        table.insert(combined_vapourise_list, group_mini_list)
    end

    for _, item_mini_list in ipairs(item_vapourise_list) do
        table.insert(combined_vapourise_list, item_mini_list)
    end

    -- The combined list having been obtained, vapourise the input item
    if #combined_vapourise_list == 0 then

        -- Non-vapourisable input item; convert it to a wisp of smoke
        generate_smoke(receiver_pos)

    else

        -- Vapourisable input item
        -- Every such item can be "vapourised" into one or more samplings, at the quantities and
        --      probabilities specified by the vapourise.csv file in the "atomic" remix
        for _, mini_list in ipairs(combined_vapourise_list) do

            local element_name = mini_list[1]
            local sampling_name = "unilib:sampling_" .. element_name
            local max_quantity = mini_list[2]
            local probability = mini_list[3] * baseline_probability
            if debug_max_probability_flag then
                probability = 1
            end

            if probability > math.random() then

                local quantity = math.random(0, max_quantity)
                if debug_max_quantity_flag then
                    quantity = max_quantity
                end

                if quantity > 0 then
                    do_vapourise(receiver_pos, element_name, sampling_name, quantity, max_quantity)
                end

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_atomic_collector.init()

    return {
        description = "Atomic collector",
        depends = {
            "glass_ordinary",
            "light_block_mese",
            "metal_steel",
            "mineral_mese",
            "shared_atomic",
        },
        notes = "Collects residues that were generated by an atomic vapouriser, then passed" ..
                " along a row of atomic tubes. The collector uses the residue to construct a" ..
                " variety of items. The optimal tube length is 20; above and below that value," ..
                " the amount of residue reaching the collector is reduced. The residues produced" ..
                " by each input item, and the items constructed from residues, are specified by" ..
                " CSV files in the \"atomic\" remix; you can modify them as you please",
    }

end

function unilib.pkg.machine_atomic_collector.exec()

    local description = S("Atomic Collector")

    unilib.register_node("unilib:machine_atomic_collector", nil, mode, {
        -- Original to unilib
        description = description,
        tiles = {
            "unilib_machine_atomic_collector_top.png",
            "unilib_machine_atomic_collector_bottom.png",
            "unilib_machine_atomic_collector_side.png",
            "unilib_machine_atomic_collector_side.png",
            "unilib_machine_atomic_collector_side.png",
            "unilib_machine_atomic_collector_front.png",
        },
        groups = {atomic_machine = 1, cracky = 1},
        -- (no sounds)

        is_ground_content = false,
        paramtype2 = "facedir",

        allow_metadata_inventory_put = function(pos, listname, index, stack, player)
            return 0
        end,

        allow_metadata_inventory_take = function(pos, listname, index, stack, player)

            if listname ~= "output" then
                return 0
            else
                return stack:get_count()
            end

        end,

        can_dig = function(pos)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("input")

        end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string("formspec", get_formspec(description))
            meta:set_string("infotext", description)
            -- (Play a sound effect when the first wisp of smoke is generated, but not every
            --      single time; that would be annoying)
            meta:set_string("spare_is_empty", "true")

            local inv = meta:get_inventory()
            inv:set_size("input", unilib.pkg.shared_atomic.machine_size)
            inv:set_size("output", unilib.pkg.shared_atomic.machine_size)
            inv:set_size("spare", 1)

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            if listname == "output" then

                -- The player has removed ingots/samples (etc) from the slot "index" in the "output"
                --      inventory
                -- In the "input" inventory, reduce the number of samplings in the same slot by the
                --      corresponding amount
                local meta = core.get_meta(pos)
                local inv = meta:get_inventory()

                local input_stack = inv:get_stack("input", index)
                local element_name = unilib.pkg.shared_atomic.lookup_table[input_stack:get_name()]
                local mini_list = unilib.pkg.shared_atomic.construct_table[element_name]
                if mini_list ~= nil then

                    input_stack:set_count(
                        input_stack:get_count() - mini_list[2] * stack:get_count()
                    )

                    inv:set_stack("input", index, input_stack)

                end

            end

        end,

        on_receive_fields = function(pos, formname, fields, sender)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()

            if fields.discard_all ~= nil then

                -- Discard items in all slots
                for i = 1, unilib.pkg.shared_atomic.machine_size do

                    inv:set_stack("input", i, ItemStack(""))
                    inv:set_stack("output", i, ItemStack(""))

                end

                inv:set_stack("spare", 1, ItemStack(""))
                meta:set_string("spare_is_empty", "true")

            elseif fields.discard_spare ~= nil then

                -- Discard items in the "spare" slot
                inv:set_stack("spare", 1, ItemStack(""))
                meta:set_string("spare_is_empty", "true")

            else

                for i = 1, unilib.pkg.shared_atomic.machine_size do

                    if fields["discard" .. i] ~= nil then

                        -- Discard both the input items and their corresponding output items in this
                        --      slot
                        inv:set_stack("input", i, ItemStack(""))
                        inv:set_stack("output", i, ItemStack(""))

                    end

                end

            end

       end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:machine_atomic_collector",
        recipe = {
            {"unilib:metal_steel_ingot", "unilib:glass_ordinary", "unilib:metal_steel_ingot"},
            {"unilib:light_block_mese", "unilib:mineral_mese_crystal", "unilib:light_block_mese"},
            {"unilib:metal_steel_block", "unilib:glass_ordinary", "unilib:metal_steel_block"},
        },
    })

end
