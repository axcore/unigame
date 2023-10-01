---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_grill_propane = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

local empty_msg = S("Propane grill is empty")
local active_msg = S("Propane grill active")
local inactive_msg = S("Propane grill inactive")

---------------------------------------------------------------------------------------------------
-- Local functions (formspecs)
---------------------------------------------------------------------------------------------------

function get_grill_active_formspec(fuel_percent, item_percent)

    -- Was default.get_propane_grill_active_formspec()

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

function get_grill_inactive_formspec()

    -- Was default.get_propane_grill_inactive_formspec()

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
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_grill_propane.init()

    return {
        description = "Propane grill",
        depends = {"glass_ordinary", "metal_steel", "misc_propane", "shared_bbq_grill"},
    }

end

function unilib.pkg.machine_grill_propane.exec()

    unilib.register_node("unilib:machine_grill_propane", "bbq:propane_grill", mode, {
        -- From bbq:propane_grill
        description = S("Propane Grill"),
        tiles = {
            "unilib_machine_grill_propane_top.png",
            "unilib_machine_grill_propane_bottom.png",
            "unilib_machine_grill_propane_side.png",
            "unilib_machine_grill_propane_side.png",
            "unilib_machine_grill_propane_back.png",
            "unilib_machine_grill_propane_front.png",
        },
        groups = {cracky = 2},
        -- N.B. "stone" in original code
        sounds = unilib.sound_table.metal,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
                {-0.5, 0.25, -0.5, 0.5, 0.68, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,

        allow_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            return unilib.pkg.shared_bbq_grill.allow_metadata_inventory_move(
                pos, from_list, from_index, to_list, to_index, count, player, empty_msg
            )

        end,

        allow_metadata_inventory_put = function(pos, listname, index, stack, player)

            return unilib.pkg.shared_bbq_grill.allow_metadata_inventory_put(
                pos, listname, index, stack, player, empty_msg
            )

        end,

        allow_metadata_inventory_take = unilib.pkg.shared_bbq_grill.allow_metadata_inventory_take,

        can_dig = unilib.pkg.shared_bbq_grill.can_dig,

        on_blast = function(pos)

            local drops = {}
            unilib.get_inventory_drops(pos, "src", drops)
            unilib.get_inventory_drops(pos, "fuel", drops)
            unilib.get_inventory_drops(pos, "dst", drops)
            drops[#drops + 1] = "unilib:machine_grill_propane"
            minetest.remove_node(pos)
            return drops

        end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            meta:set_string("formspec", get_grill_inactive_formspec())
            local inv = meta:get_inventory()
            inv:set_size("src", 1)
            inv:set_size("fuel", 1)
            inv:set_size("dst", 9)

        end,

        on_metadata_inventory_move = function(pos)

            minetest.get_node_timer(pos):start(1.0)

        end,

        on_metadata_inventory_put = function(pos)

            -- Start timer function, it decides whether the grill can burn or not
            minetest.get_node_timer(pos):start(1.0)

        end,

        on_timer = function(pos, elapsed)

            return unilib.pkg.shared_bbq_grill.grill_node_timer(
                pos, elapsed,
                "unilib:machine_grill_propane", "unilib:machine_grill_propane_active",
                inactive_msg, active_msg,
                get_grill_inactive_formspec, get_grill_active_formspec
            )

        end,
    })
    unilib.register_craft({
        -- From bbq:propane_grill
        output = "unilib:machine_grill_propane",
        recipe = {
            {"unilib:metal_steel_ingot", "unilib:glass_ordinary", "unilib:metal_steel_ingot"},
            {"", "unilib:misc_propane", ""},
            {"", "unilib:metal_steel_ingot", ""}
        }
    })

    unilib.register_node("unilib:machine_grill_propane_active", "bbq:propane_grill_active", mode, {
        -- From bbq:propane_grill_active
        description = S("Propane Grill"),
        tiles = {
            "unilib_machine_grill_propane_top.png",
            "unilib_machine_grill_propane_bottom.png",
            {
                image = "unilib_machine_grill_propane_side_active.png",
                backface_culling = false,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1.5
                },
            },
            {
                image = "unilib_machine_grill_propane_side_active.png",
                backface_culling = false,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1.5
                },
            },
            "unilib_machine_grill_propane_back.png",
            {
                image = "unilib_machine_grill_propane_front_active.png",
                backface_culling = false,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1.5
                },
            },
        },
        groups = {cracky = 2, not_in_creative_inventory = 1},
        -- N.B. "stone" in original code
        sounds = unilib.sound_table.metal,

        drawtype = "nodebox",
        drop = "unilib:machine_grill_propane",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
                {-0.5, 0.25, -0.5, 0.5, 0.68, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,

        allow_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            return unilib.pkg.shared_bbq_grill.allow_metadata_inventory_move(
                pos, from_list, from_index, to_list, to_index, count, player, empty_msg
            )

        end,

        allow_metadata_inventory_put = function(pos, listname, index, stack, player)

            return unilib.pkg.shared_bbq_grill.allow_metadata_inventory_put(
                pos, listname, index, stack, player, empty_msg
            )

        end,

        allow_metadata_inventory_take = unilib.pkg.shared_bbq_grill.allow_metadata_inventory_take,

        can_dig = unilib.pkg.shared_bbq_grill.can_dig,

        on_timer = function(pos, elapsed)

            return unilib.pkg.shared_bbq_grill.grill_node_timer(
                pos, elapsed,
                "unilib:machine_grill_propane", "unilib:machine_grill_propane_active",
                inactive_msg, active_msg,
                get_grill_inactive_formspec, get_grill_active_formspec
            )

        end,
    })

end
