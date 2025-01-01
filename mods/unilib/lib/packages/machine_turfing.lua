---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_turfing = {}

local S = unilib.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- The time in seconds to grow turf on a dirt node; it's a comparitively long time because the
--      turf spread ABM itself is quite slow
local grow_time = 30
-- Compatible fertilisers, and the cost to grow one dirt-with-turf node
local cost_table = {
    ["unilib:item_fertiliser_mulch"] = 3,
    ["bonemeal:mulch"] = 3,
    ["unilib:item_fertiliser_bonemeal"] = 2,
    ["bonemeal:bonemeal"] = 2,
    ["unilib:item_fertiliser_compound"] = 1,
    ["bonemeal:fertiliser"] = 1,
}

-- Infotext messages
local empty_msg = S("Empty Turfing Machine")
local ready_msg = S("Ready for turfing.")
local error_msg = S("Not enough fertiliser!")
local impossible_msg = S("Item doesn't exist!")
local turfing_msg = S("Growing turf...")
local collect_msg = S("Collect your turf.")

-- Formspecs
local put_dirt_msg = S("Put dirt here")
local put_turf_msg = S("Put turf here")
local put_fertiliser_msg = S("Put fertiliser here")
local one_button_msg = S("Grow One")
local many_button_msg = S("Grow Many")

local base_formspec =
    "label[1,1;" .. F(put_dirt_msg) .. "]" ..
    "label[1,2;" .. F(put_turf_msg) .. "]" ..
    "label[1,3;" .. F(put_fertiliser_msg) .. "]" ..
    "button[4,2.9;2,1;grow_one;" .. F(one_button_msg) .. "]" ..
    "button[6,2.9;2,1;grow_many;" .. F(many_button_msg) .. "]" ..
    "list[current_name;dirt;0,0.8;1,1;]" ..
    "list[current_name;turf;0,1.8;1,1;]" ..
    "list[current_name;fertiliser;0,2.8;1,1;]" ..
    "list[current_name;output;4,0.8;4,2;]" ..
    "list[current_player;main;0,4;8,4;]" ..
    "listring[current_player;main]" ..
    "listring[current_name;dirt]" ..
    "listring[current_player;main]" ..
    "listring[current_name;turf]" ..
    "listring[current_player;main]" ..
    "listring[current_name;fertiliser]" ..
    "listring[current_player;main]" ..
    "listring[current_name;output]" ..
    "listring[current_player;main]"

local machine_idle_formspec =
    "size[8,8]" ..
    "label[0,0;" .. FS("Grow turf on different dirts!") .. "]" ..
    base_formspec

local machine_running_formspec =
    "size[8,8]" ..
    "label[0,0;" .. FS("Turf is being grown...") .. "]" ..
    base_formspec

local machine_error_formspec =
    "size[8,8]" ..
    "label[0,0;" .. FS("You need to add more fertiliser!") .. "]" ..
    base_formspec

local machine_impossible_formspec =
    "size[8,8]" ..
    "label[0,0;" .. FS("This turf can't be grown on this dirt!") .. "]" ..
    base_formspec

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_turfing.init()

    return {
        description = "Turfing machine",
        notes = "A machine used to grow different turfs on different types of dirt. It's" ..
                " intended for use in worlds where other methods of obtaining a specific" ..
                " dirt-with-turf node (such as the crystallite shovel from ethereal) are not" ..
                " available. To use the machine, place it on top of a dirt-with-turf node;" ..
                " that is the type of turf that will be grown. If you place it on some other" ..
                " type of node, then you must place a dirt-with-turf node in the slot manually",
        depends = "metal_steel",
    }

end

function unilib.pkg.machine_turfing.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:machine_turfing", nil, mode, {
        -- Original to unilib
        description = S("Turfing Machine"),
        tiles = {
            "unilib_machine_turfing.png",
            "unilib_machine_turfing.png",
            "unilib_machine_turfing_side.png",
            "unilib_machine_turfing_side.png",
            "unilib_machine_turfing_side.png",
            "unilib_machine_turfing_side.png",
        },
        groups = {cracky = 1},
        -- (no sounds)

        is_ground_content = false,

        allow_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            local meta = core.get_meta(pos)
            if from_list == "turf" and meta:get_string("under") ~= "" then
                return 0
            else
                return count
            end

        end,

        allow_metadata_inventory_put = function(pos, listname, index, stack, player)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            local full_name = stack:get_name()
            local item_name = unilib.utils.get_item_name(full_name)

            if listname == "dirt" then

                if unilib.global.fertile_dirt_table[item_name] ~= nil then
                    return 99
                else
                    return 0
                end

            elseif listname == "turf" then

                if unilib.global.dirt_with_turf_table[full_name] ~= nil and
                        inv:is_empty("turf") then
                    return 1
                else
                    return 0
                end

            elseif listname == "fertiliser" then

                if cost_table[full_name] ~= nil then
                    return 99
                else
                    return 0
                end

            else

                return 99

            end

        end,

        allow_metadata_inventory_take = function(pos, listname, index, stack, player)

            local meta = core.get_meta(pos)
            if listname == "turf" and meta:get_string("under") ~= "" then
                return 0
            else
                return stack:get_count()
            end

        end,

        can_dig = function(pos)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            if inv:is_empty("dirt") and
                    (inv:is_empty("turf") or meta:get_string("under") ~= "") and
                    inv:is_empty("fertiliser") and
                    inv:is_empty("output") then
                return true
            else
                return false
            end

        end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            inv:set_size("main", 8 * 4)
            inv:set_size("dirt", 1)
            inv:set_size("turf", 1)
            inv:set_size("fertiliser", 1)
            inv:set_size("output", 8)
            meta:set_string("infotext", empty_msg)
            meta:set_string("formspec", machine_idle_formspec)

            -- (If the machine is placed on top of a dirt-with-turf node, then that's the one we
            --  use in the "turf" slot)
            local under_pos = vector.add(pos, {x = 0, y = -1, z = 0})
            local under_name = core.get_node(under_pos).name
            if unilib.global.dirt_with_turf_table[under_name] ~= nil then

                inv:add_item("turf", ItemStack(under_name))
                meta:set_string("under", under_name)

            else

                meta:set_string("under", "")

            end

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            meta:set_string("infotext", ready_msg)

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            local timer = core.get_node_timer(pos)
            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            timer:stop()

            if inv:is_empty("dirt") and
                    inv:is_empty("turf") and
                    inv:is_empty("fertiliser") then
                meta:set_string("infotext", empty_msg)
            elseif inv:is_empty("output") then
                meta:set_string("infotext", ready_msg)
            end

            meta:set_string("formspec", machine_idle_formspec)

        end,

        on_receive_fields = function(pos, formname, fields, sender)

            if fields["grow_one"] or fields["grow_many"] then

                local meta = core.get_meta(pos)
                local inv = meta:get_inventory()
                local timer = core.get_node_timer(pos)

                local dirt_stack = inv:get_stack("dirt", 1)
                local dirt_name = dirt_stack:get_name()
                local turf_stack = inv:get_stack("turf", 1)
                local turf_name = turf_stack:get_name()
                local fertiliser_stack = inv:get_stack("fertiliser", 1)
                local fertiliser_name = fertiliser_stack:get_name()

                local data_table = unilib.global.dirt_with_turf_table[turf_name]
                local output_name = dirt_name .. "_with_" .. data_table.turf_part_name

                if core.registered_nodes[output_name] == nil then

                    meta:set_string("infotext", impossible_msg)
                    meta:set_string("formspec", machine_impossible_formspec)

                elseif cost_table[fertiliser_name] > fertiliser_stack:get_count() then

                    meta:set_string("infotext", error_msg)
                    meta:set_string("formspec", machine_error_formspec)

                elseif dirt_name ~= "" and turf_name ~= "" and fertiliser_name ~= "" then

                    meta:set_string("output", output_name)
                    meta:set_int("cost", cost_table[fertiliser_name])
                    meta:set_string("infotext", turfing_msg)
                    meta:set_string("formspec", machine_running_formspec)

                    if fields["grow_one"] then
                        meta:set_string("grow_type", "grow_one")
                    else
                        meta:set_string("grow_type", "grow_many")
                    end

                    timer:start(grow_time)

                end

            end

        end,

        on_timer = function(pos)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            local timer = core.get_node_timer(pos)

            local dirt_stack = inv:get_stack("dirt", 1)
            local dirt_name = dirt_stack:get_name()
            local fertiliser_stack = inv:get_stack("fertiliser", 1)
            local fertiliser_name = fertiliser_stack:get_name()

            inv:remove_item("dirt", ItemStack(dirt_name))
            inv:remove_item(
                "fertiliser", ItemStack(fertiliser_name .. " " .. meta:get_int("cost"))
            )
            inv:add_item("output", ItemStack(meta:get_string("output")))

            if meta:get_string("grow_type") ~= "grow_many" then

                meta:set_string("infotext", collect_msg)
                meta:set_string("formspec", machine_idle_formspec)

            else

                timer:start(grow_time)

            end

        end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:machine_turfing",
        recipe = {
            {c_ingot, "", c_ingot},
            {"", "group:soil", ""},
            {c_ingot, "", c_ingot},
        },
    })

end
