---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_atomic_vapouriser = {}

local S = unilib.intllib
local F = core.formspec_escape
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_formspec(description)

    -- (The images inform the player, that many different kinds of things can be used as input)
    return "size[8,7.5]" ..
            "label[0,0;" .. F(description) .. "]" ..
            "image[1,1;1,1;unilib_metal_iron_lump.png]" ..
            "image[1,2;1,1;unilib_flower_rose_red.png]" ..
            "image[6,1;1,1;unilib_stone_ordinary_cobble.png]" ..
            "image[6,2;1,1;unilib_tree_apple_trunk_top.png]" ..
            "list[current_name;input;2,1;4,2;]" ..
            "list[current_player;main;0,3.5;8,4;]" ..
            "listring[current_player;main]" ..
            "listring[current_name;input]" ..
            "listring[current_player;main]"

end

local function find_tube(pos)

    -- Searches the nodes immediately adjacent to the vapouriser's connectors, looking for atomic
    --      tubes. Returns the position of the first tube found

    -- The vapouriser has connectors on three sides, whose position varies according to .param2
    local vector_list = {
        {x = 1, y = 0, z = 0},
        {x = -1, y = 0, z = 0},
        {x = 0, y = 0, z = 1},
        {x = 0, y = 0, z = -1},
    }

    -- (Remove the non-connecting side)
    local node = core.get_node(pos)
    if node.param2 == 0 then
        table.remove(vector_list, 4)
    elseif node.param2 == 1 then
        table.remove(vector_list, 2)
    elseif node.param2 == 2 then
        table.remove(vector_list, 3)
    elseif node.param2 == 3 then
        table.remove(vector_list, 1)
    else
        return nil
    end

    for _, vector_pos in ipairs(vector_list) do

        local nearby_pos = {x = pos.x + vector_pos.x, y = pos.y, z = pos.z + vector_pos.z}
        local nearby_node = core.get_node(nearby_pos)
        if nearby_node.name == "unilib:misc_atomic_tube" or
                nearby_node.name == "unilib:misc_atomic_tube_active" then

            -- Check the tube's orientation is correct
            if (
                vector_pos.x ~= 0 and (nearby_node.param2 == 0 or nearby_node.param2 == 2)
            ) or (
                vector_pos.z ~= 0 and (nearby_node.param2 == 1 or nearby_node.param2 == 3)
            ) then
                return nearby_pos, vector_pos
            end
        end

    end

    return nil

end

local function get_next_item(pos)

    -- Returns the next (i.e. first remaining) itemstack in the vapouriser's inventory, which will
    --      be transferred to the first tube in the chain

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    for i = 1, unilib.pkg.shared_atomic.machine_size do

        local stack = inv:get_stack("input", i)
        if stack:get_count() > 0 then
            return stack, i
        end

    end

    return nil

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_atomic_vapouriser.init()

    return {
        description = "Atomic vapouriser",
        depends = {
            "glass_obsidian",
            "metal_steel",
            "mineral_diamond",
            "shared_atomic",
            "stone_obsidian",
        },
        notes = "Vapourises items and sends the residue along an atomic tube towards a" ..
                " collector. The collector uses the residue to construct a variety of items." ..
                " The optimal tube length is 20; above and below that value, the amount of" ..
                " residue reaching the collector is reduced. The residues produced by each" ..
                " input item, and the items constructed from residues, are specified by CSV" ..
                " files in the \"atomic\" remix; you can modify them as you please",
    }

end

function unilib.pkg.machine_atomic_vapouriser.exec()

    local description = S("Atomic Vapouriser")

    unilib.register_node("unilib:machine_atomic_vapouriser", nil, mode, {
        -- Original to unilib
        description = description,
        tiles = {
            "unilib_machine_atomic_vapouriser_top.png",
            "unilib_machine_atomic_vapouriser_bottom.png",
            "unilib_machine_atomic_vapouriser_side.png",
            "unilib_machine_atomic_vapouriser_side.png",
            "unilib_machine_atomic_vapouriser_side.png",
            "unilib_machine_atomic_vapouriser_front.png",
        },
        groups = {atomic_machine = 1, cracky = 1},
        -- (no sounds)

        is_ground_content = false,
        paramtype2 = "facedir",

        can_dig = function(pos)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("input")

        end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string("formspec", get_formspec(description))
            meta:set_string("infotext", description)
            meta:set_string("is_active", "false")

            local inv = meta:get_inventory()
            inv:set_size("input", unilib.pkg.shared_atomic.machine_size)

        end,

        on_metadata_inventory_put = function(pos)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            if meta:get_string("is_active") == "false" and not inv:is_empty("input") then

                meta:set_string("is_active", "true")
                core.get_node_timer(pos):start(unilib.pkg.shared_atomic.transfer_time)

            end

        end,

        on_timer = function(pos)

            -- (Failsafe)
            local meta = core.get_meta(pos)
            if meta:get_string("is_active") == "false" then
                return
            end

            -- Check that there are still some input materials left in the vapouriser's inventory
            local inv = meta:get_inventory()
            if inv:is_empty("input") then

                meta:set_string("is_active", "false")
                return

            end

            -- Get the location of the neighbouring tube, the first one in a chain of nodes leading
            --      (hopefully) to a collector
            local tube_pos, vector_pos = find_tube(pos)
            if tube_pos == nil then

                meta:set_string("is_active", "false")
                return

            end


            -- Get the next (i.e. first remaining) itemstack in the vapouriser's inventory, which
            --      will be transferred to the first tube in the chain
            local stack, slot = get_next_item(pos)
            if stack == nil then

                meta:set_string("is_active", "false")
                return

            end

            -- Pass the item to the tube...
            unilib.pkg.misc_atomic_tube.receive_input(pos, tube_pos, vector_pos, stack:get_name())
            -- ...and remove it from our inventory
            stack:take_item(1)
            inv:set_stack("input", slot, stack)

            -- Continue the timer for the next item (if any)
            return true

        end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:machine_atomic_vapouriser",
        recipe = {
            {"unilib:metal_steel_ingot", "unilib:glass_obsidian", "unilib:metal_steel_ingot"},
            {"unilib:stone_obsidian", "unilib:mineral_diamond_gem", "unilib:stone_obsidian"},
            {"unilib:metal_steel_block", "unilib:glass_obsidian", "unilib:metal_steel_block"},
        },
    })

end
