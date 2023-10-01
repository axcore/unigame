---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    stripped_tree
-- Code:    GPLv3.0
-- Media:   GPLv3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_chiselling = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.stripped_tree.add_mode

local max_stack = tonumber(minetest.settings:get("default_stack_max")) or 99

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_chiselling.init()

    return {
        description = "Tree chiselling machine",
        depends = {"item_bark_tree", "mineral_diamond", "item_chisel_tree"},
    }

end

function unilib.pkg.machine_chiselling.exec()

    local description = S("Tree Chiselling Machine")
    --[[
    local formspec = "size[8,9]"..
            "label[0,0;Chiseling Machine]"..
            "image[2,2;1,1;chisel.png]"..
            "list[current_name;src;2,1;1,1;]"..
            "list[current_name;dst;5,1;2,2;]"..
            "list[current_player;main;0,5;8,4;]"..
            "listring[current_name;dst]"..
            "listring[current_player;main]"..
            "listring[current_name;src]"..
            "listring[current_player;main]"
    ]]--
    local formspec = "size[8,7.5]" ..
            "label[0,0;" .. description .. "]" ..
            "image[2,2;1,1;unilib_item_chisel_tree.png]" ..
            "list[current_name;src;2,1;1,1;]" ..
            "list[current_name;dst;4,1;2,2;]" ..
            "list[current_player;main;0,3.5;8,4;]" ..
            "listring[current_name;dst]" ..
            "listring[current_player;main]" ..
            "listring[current_name;src]" ..
            "listring[current_player;main]"

    unilib.register_node("unilib:machine_chiselling", "stripped_tree:chiseling_machine", mode, {
        -- From stripped_tree:chiseling_machine
        description = description,
        tiles = {
            "unilib_machine_chiselling.png",
            "unilib_machine_chiselling.png",
            "unilib_machine_chiselling_side.png",
            "unilib_machine_chiselling_side.png",
            "unilib_machine_chiselling_side.png",
            "unilib_machine_chiselling_side.png",
        },
        groups = {cracky = 1},
        -- (no sounds)

        after_place_node = function(pos, placer)

            local meta = minetest.get_meta(pos)
            meta:set_string("formspec", formspec)

        end,

        allow_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            if pos then
                return count
            end

            return 0

        end,

        -- N.B. not in original code, which allows a non-empty machine to be destroyed, losing its
        --      contents
        can_dig = function(pos)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("dst") and inv:is_empty("src")

        end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            meta:set_string("formspec", formspec)
            meta:set_string("infotext", description)
            local inv = meta:get_inventory()
            inv:set_size("src", 1)
            inv:set_size("dst", 2)
            meta:set_int("elapsed", 0)
            meta:set_int("cook_time", 0)
            minetest.get_node_timer(pos):start(1.0)

        end,

        on_metadata_inventory_move = function(pos)
            minetest.get_node_timer(pos):start(1.0)
        end,

        on_metadata_inventory_put = function(pos)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local stack = inv:get_stack("src", 1)
            local full_name = stack:get_name()
            if full_name ~= "" then

                local count = stack:get_count()
                local stripped_name = full_name .. "_stripped"
                local stripped_flag = minetest.registered_nodes[stripped_name]

                local dstcount = inv:get_stack("dst",1):get_count()
                if stripped_flag and dstcount < max_stack then

                    inv:add_item("dst", stripped_name .. " " .. count)
                    inv:add_item("dst", "unilib:item_bark_tree" .. " " .. count .. "")
                    inv:remove_item("src", stack)

                end

            end

        end,
    })
    unilib.register_craft({
        -- From stripped_tree:chiseling_machine
        output = "unilib:machine_chiselling",
        recipe = {
            {"group:wood", "unilib:mineral_diamond_gem", "group:wood"},
            {"group:wood", "unilib:item_chisel_tree", "group:wood"},
            {"group:wood", "group:wood", "group:wood"},
        },
    })

end
