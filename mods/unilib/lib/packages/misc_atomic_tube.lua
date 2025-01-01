---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_atomic_tube = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Lookup table, used to check that the next tube in the chain has a compatible orientation
local tube_dir_table = {[0] = 2, [1] = 3, [2] = 4, [3] = 1}
-- Lookup table, used to check that the receiving collector has a compatible orientation
local collector_dir_table = {[0] = 1, [1] = 2, [2] = 3, [3] = 0}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function find_empty_slot(pos)

    -- The tubes are set up to hold itemstacks of 1, so incoming items must be placed in their own
    --      "slot" in the tube's inventory. Find the first empty slot, and return its number (or
    --      nil if all slots are full)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    for i = 1, unilib.pkg.shared_atomic.machine_size do

        local stack = inv:get_stack("input", i)
        if stack:get_count() == 0 then
            return i
        end

    end

    return nil

end

local function get_next_item(pos)

    -- Called by do_transfer()
    -- Get the first item in the tube's inventory, so it can be transferred to the next tube or
    --      collector in the chain
    -- We transfer data, not ItemStacks; so return the item's name and distance travelled so far

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    -- Get the ItemStack at position 1
    local stack = inv:get_stack("input", 1)
    if stack:get_count() < 1 then
        return nil
    end

    local item_name = stack:get_name()
    local stack_meta = stack:get_meta()
    local distance = stack_meta:get_int("distance") or 0

    -- Any other ItemStacks in the inventory are moved to the previous slot, so that the tube
    --      operates as first in, first out
    local replace_list = {}
    for i = 2, unilib.pkg.shared_atomic.machine_size do

        local other_stack = inv:get_stack("input", i)
        local other_meta = other_stack:get_meta()
        local other_distance = other_meta:get_int("distance") or 0

        local replace_stack = ItemStack(other_stack:get_name())
        local replace_meta = replace_stack:get_meta()
        replace_meta:set_int("distance", other_distance)

        table.insert(replace_list, replace_stack)

    end

    table.insert(replace_list, ItemStack(""))
    inv:set_list("input", replace_list)

    return item_name, distance

end

local function do_transfer(pos)

    -- Called by the active tube's .on_timer() to transfer an item from the tube's inventory to the
    --      next tube or collector in the chain

    -- Get the next item to be transferred; other items in the inventory are shifted one position,
    --      so that it's first in, first out
    local this_node = core.get_node(pos)
    local item_name, distance = get_next_item(pos)
    if item_name == nil then

        -- Inventory is empty; this active tube becomes an inactive tube
        core.swap_node(pos, {name = "unilib:misc_atomic_tube", param2 = this_node.param2})
        return

    end

    -- Find the next node in the chain, which must be a tube or a collector
    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    local vector_pos = {
        x = meta:get_int("transfer_x"),
        y = meta:get_int("transfer_y"),
        z = meta:get_int("transfer_z"),
    }

    local nearby_pos = {
        x = pos.x + vector_pos.x,
        y = pos.y + vector_pos.y,
        z = pos.z + vector_pos.z,
    }

    local nearby_node = core.get_node(nearby_pos)
    local nearby_name = nearby_node.name
    if nearby_name == "unilib:misc_atomic_tube" or
            nearby_name == "unilib:misc_atomic_tube_active" then

        -- Check the tube has the same orientation as this one
        if nearby_node.param2 == this_node.param2 or
                nearby_node.param2 == tube_dir_table[this_node.param2] then

            -- Transfer the item to the next tube
            unilib.pkg.misc_atomic_tube.receive_input(
                pos,
                nearby_pos,
                vector_pos,
                item_name,
                distance
            )

            -- Continue the timer for the next item (if any)
            return true

        else

            -- We can't transfer an item to a misrotated tube, so just discard it
            if inv:is_empty("input") then
                core.swap_node(pos, {name = "unilib:misc_atomic_tube", param2 = this_node.param2})
            end

            return

        end

    elseif nearby_name == "unilib:machine_atomic_collector" then

        -- Check that the collector's connector sides are facing the tube
        if collector_dir_table[this_node.param2] ~= nearby_node.param2 then

            -- Transfer the item to the next tube
            unilib.pkg.machine_atomic_collector.receive_input(
                pos,
                nearby_pos,
                vector_pos,
                item_name,
                distance
            )

            -- Continue the timer for the next item (if any)
            return true

        else

            -- We can't transfer an item to a misrotated collector, so just discard it
            if inv:is_empty("input") then
                core.swap_node(pos, {name = "unilib:misc_atomic_tube", param2 = this_node.param2})
            end

            return

        end

    else

        -- We can't transfer an item to a broken tube (or anything else), so just discard it
        if inv:is_empty("input") then
            core.swap_node(pos, {name = "unilib:misc_atomic_tube", param2 = this_node.param2})
        end

        return

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_atomic_tube.receive_input(
    sender_pos, receiver_pos, vector_pos, input_name, distance
)
    -- Called by the vapouriser's .on_timer() (when items are received from the vapouriser), or
    --      by this package's .do_transfer() (when items are received from the previous tube in
    --      the chain)
    -- Tries to store the incoming item in this tube's inventory, ready for it to be transferred to
    --      the next tube or collector in the chain

    -- Failsafes. If any failsafe is triggered (for example, if the node at receiver_pos is a
    --      broken tube), the input material is lost forever
    local sender_name = core.get_node(sender_pos).name
    if sender_name ~= "unilib:machine_atomic_vapouriser" and
            sender_name ~= "unilib:misc_atomic_tube_active" then
        return
    end

    local receiver_node =  core.get_node(receiver_pos)
    local receiver_name =  receiver_node.name
    if receiver_name ~= "unilib:misc_atomic_tube" and
            receiver_name ~= "unilib:misc_atomic_tube_active" then
        return
    end

    if core.registered_items[input_name] == nil then
        return
    end

    -- Handle the incoming item
    local inv
    if receiver_name ~= "unilib:misc_atomic_tube" then

        local meta = core.get_meta(receiver_pos)
        inv = meta:get_inventory()

    else

        -- Convert an inactive tube into an active tube
        core.swap_node(
            receiver_pos, {name = "unilib:misc_atomic_tube_active", param2 = receiver_node.param2}
        )

        local meta = core.get_meta(receiver_pos)
        -- The vapouriser, tubes and collector must all be in a straight line
        -- We don't need the y-coordinate right now, but maybe it will be needed later
        meta:set_int("transfer_x", vector_pos.x)
        meta:set_int("transfer_y", vector_pos.y)
        meta:set_int("transfer_z", vector_pos.z)

        -- The vapouriser's time delay is the same as the speed at which items pass through tubes,
        --      so this tube's inventory should not contain more than one item. An inventory that's
        --      larger than 1 allows the chain to continue working through server glitches. If
        --      the inventory fills nonetheless, the "active" tube is switched for a "broken" tube
        inv = meta:get_inventory()
        inv:set_size("input", unilib.pkg.shared_atomic.machine_size)

        -- Start a timer, so input items can be passed down the chain
        core.get_node_timer(receiver_pos):start(unilib.pkg.shared_atomic.transfer_time)

    end

    -- Find the first empty slot in the active tube's inventory
    local slot = find_empty_slot(receiver_pos)
    if not slot then

        -- Tube is full; swap it for a broken tube (the inventory is lost forever)
        core.swap_node(
            receiver_pos,
            {name = "unilib:misc_atomic_tube_broken", param2 = receiver_node.param2}
        )

        core.sound_play(
            "unilib_break_glass",
            {pos = pos, gain = 1.0, max_hear_distance = unilib.pkg.shared_atomic.optimal_distance}
        )

        return

    end

    -- Store the input in the tube's inventory
    local stack = ItemStack(input_name)
    local stack_meta = stack:get_meta()
    if not distance then
        stack_meta:set_int("distance", 1)
    else
        stack_meta:set_int("distance", distance + 1)
    end

    inv:set_stack("input", slot, stack)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_atomic_tube.init()

    return {
        description = "Atomic tubes",
        depends = {"metal_steel", "shared_atomic"},
        notes = "A row of tubes connects an atomic vapouriser to an atomic collector. Tubes" ..
                " must be placed in a straight line, and must connect to the vapouriser and" ..
                " collector on the correct side. Occasional server glitches may produce a" ..
                " \"broken\" tube, which can be \"repaired\" by digging and then placing" ..
                " it back in its former position",
    }

end

function unilib.pkg.misc_atomic_tube.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    local node_box = {
        type = "fixed",
        fixed = {-0.5, -0.25, -0.25, 0.5, 0.25, 0.25, },
    }

    unilib.register_node("unilib:misc_atomic_tube", nil, mode, {
        -- Original to unilib
        description = unilib.utils.brackets(S("Atomic Tube"), S("inactive")),
        tiles = {
            "unilib_misc_atomic_tube.png",
            "unilib_misc_atomic_tube.png",
            "unilib_misc_atomic_tube_side.png",
            "unilib_misc_atomic_tube_side.png",
            "unilib_misc_atomic_tube.png^[transformR180",
            "unilib_misc_atomic_tube.png",
        },
        groups = {atomic_tube = 1, cracky = 1},
        -- (no sounds)

        drawtype = "nodebox",
        is_ground_content = false,
        light_source = 4,
        node_box = node_box,
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = node_box,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:misc_atomic_tube",
        recipe = {
            {"unilib:metal_steel_ingot", "unilib:rail_ordinary", "unilib:metal_steel_ingot"},
        },
    })

    unilib.register_node("unilib:misc_atomic_tube_active", nil, mode, {
        -- Original to unilib
        description = unilib.utils.brackets(S("Atomic Tube"), S("active")),
        tiles = {
            "unilib_misc_atomic_tube_active.png",
            "unilib_misc_atomic_tube_active.png",
            "unilib_misc_atomic_tube_side.png",
            "unilib_misc_atomic_tube_side.png",
            "unilib_misc_atomic_tube_active.png^[transformR180",
            "unilib_misc_atomic_tube_active.png",
        },
        groups = {atomic_tube = 1, cracky = 1, not_in_creative_inventory = 1},
        -- (no sounds)

        drawtype = "nodebox",
        drop = "unilib:misc_atomic_tube",
        is_ground_content = false,
        light_source = 6,
        node_box = node_box,
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = node_box,

        on_timer = function(pos)
            return do_transfer(pos)
        end,
    })

    unilib.register_node("unilib:misc_atomic_tube_broken", nil, mode, {
        -- Original to unilib
        description = unilib.utils.brackets(S("Atomic Tube"), S("broken")),
        tiles = {
            "unilib_misc_atomic_tube_broken.png",
            "unilib_misc_atomic_tube_broken.png",
            "unilib_misc_atomic_tube_side.png",
            "unilib_misc_atomic_tube_side.png",
            "unilib_misc_atomic_tube_broken.png^[transformR180",
            "unilib_misc_atomic_tube_broken.png",
        },
        groups = {atomic_tube = 1, cracky = 1, not_in_creative_inventory = 1},
        -- (no sounds)

        drawtype = "nodebox",
        drop = "unilib:misc_atomic_tube",
        is_ground_content = false,
        node_box = node_box,
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = node_box,
    })

end
