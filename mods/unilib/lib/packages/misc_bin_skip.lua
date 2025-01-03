---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    trash_can
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_bin_skip = {}

local S = unilib.intllib
local FS = function(...) return core.formspec_escape(S(...)) end
local mode = unilib.global.imported_mod_table.trash_can.add_mode

local fdir_to_front_list = {
    {x = 0, z = 1},
    {x = 1, z = 0},
    {x = 0, z = -1},
    {x = -1, z = 0},
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function check_wall(pos)

    local fdir = core.get_node(pos).param2
    local second_node_x = pos.x + fdir_to_front_list[fdir + 1].x
    local second_node_z = pos.z + fdir_to_front_list[fdir + 1].z
    local second_node_pos = {x = second_node_x, y = pos.y, z = second_node_z}
    local second_node = core.get_node(second_node_pos)

    if not second_node or
            not core.registered_nodes[second_node.name] or
            not core.registered_nodes[second_node.name].buildable_to then
        return true
    else
        return false
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_bin_skip.init()

    return {
        description = "Skip Bin",
        depends = {"dye_basic", "metal_steel", "mineral_coal"},
    }

end

function unilib.pkg.misc_bin_skip.exec()

    local c_coal = "unilib:mineral_coal_block"
    local c_iron = "unilib:metal_steel_ingot"

    local def_table = {
        description = S("Skip Bin"),
        tiles = {
            "unilib_misc_bin_skip_top.png",
            "unilib_misc_bin_skip_bottom.png",
            "unilib_misc_bin_skip_side.png",
        },
        groups = {cracky = 3, oddly_breakable_by_hand = 1},
        sounds = unilib.sound.generate_node({
            dig = {name = "unilib_misc_bin_skip", gain = 0.6},
            dug = {name = "unilib_dug_node", gain = 1.0},
            footstep = {name = "unilib_hard_footstep", gain = 0.4},
        }),

        drawtype = "nodebox",
        inventory_image = "unilib_misc_bin_skip_inv.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.4375, -0.375, -0.4375, 0.4375, 0.5, 1.4375},
                {-0.4375, -0.5, -0.4375, -0.25, -0.375, -0.25},
                {0.25, -0.5, -0.4375, 0.4375, -0.375, -0.25},
                {0.25, -0.5, 1.25, 0.4375, -0.375, 1.4375},
                {-0.4375, -0.5, 1.25, -0.25, -0.375, 1.4375},
                {-0.5, 0.25, -0.5, 0.5, 0.375, 1.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5625, -0.5, 0.5, 0.5, 1.5},
        },

        after_place_node = function(pos, placer, itemstack)

            if check_wall(pos) then

                core.set_node(pos, {name = "air"})
                return true

            end

        end,

        can_dig = function(pos,player)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("main")

        end,

        -- N.B. No .on_blast() function, either here or in original code; destroying the bin should
        --      destroy its contents

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string("formspec",
                "size[8,9]" ..
                "button[0,0;3,1;empty;" .. FS("Empty skip bin") .. "]" ..
                "list[context;main;1,1;6,3;]" ..
                "list[current_player;main;0,5;8,4;]"..
                "listring[]"
            )
            meta:set_string("infotext", S("Skip Bin"))
            local inv = meta:get_inventory()
            inv:set_size("main", 8 * 4)

        end,

        --[[
        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items in skip bin at " ..
                        core.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items to skip bin at " ..
                        core.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            unilib.utils.log(
                "action",
                player:get_player_name() .. " takes items from skip bin at " ..
                        core.pos_to_string(pos)
            )

        end,
        ]]--

        on_receive_fields = function(pos, formname, fields, sender)

            if fields.empty then

                local meta = core.get_meta(pos)
                local inv = meta:get_inventory()
                inv:set_list("main", {})
                core.sound_play(
                    "unilib_misc_bin",
                    {to_player = sender:get_player_name(), gain = 2.0}
                )

            end

        end,
    }

    unilib.utils.set_inventory_action_loggers(def_table, "skip bin")
    unilib.register_node(
        -- From trash_can:dumpster
        "unilib:misc_bin_skip", "trash_can:dumpster", mode, def_table
    )

    unilib.register_craft({
        -- From trash_can:dumpster
        output = "unilib:misc_bin_skip",
        recipe = {
            {c_coal, c_coal, c_coal},
            {c_iron, "unilib:dye_green", c_iron},
            {c_iron, c_iron, c_iron},
        },
    })

end
