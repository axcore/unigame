---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_grill_smoker = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

local empty_msg = S("Smoker grill is empty")
local active_msg = S("Smoker grill active")
local inactive_msg = S("Smoker grill inactive")

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_grill_smoker.init()

    return {
        description = "Smoker grill",
        depends = {"metal_steel", "shared_bbq_grill"},
    }

end

function unilib.pkg.machine_grill_smoker.exec()

    unilib.register_node("unilib:machine_grill_smoker", "bbq:smoker", mode, {
        -- From bbq:smoker
        description = S("Smoker Grill"),
        tiles = {
            "unilib_machine_grill_smoker_bottom.png",
            "unilib_machine_grill_smoker_bottom.png^[transformFY",
            "unilib_machine_grill_smoker_side.png",
            "unilib_machine_grill_smoker_side.png^[transformFX",
            "unilib_machine_grill_smoker_back.png",
            "unilib_machine_grill_smoker.png",
        },
        groups = {cracky = 2},
        -- N.B. "stone" in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-1.5, -0.03, -0.3, -1.0, 0.35, 0.093},
                {-1.0, -0.08, -0.5, 0.5, 0.6, 0.435},
                {-0.375, 0.095, -.52, -0.16, 0.155, -0.54},
                {-1.37, 0.095, -.32, -1.16, 0.155, -0.34},
                {-0.345, 0.115, -.5, -0.325, 0.135, -0.55},
                {-0.21, 0.115, -.5, -0.19, 0.135, -0.55},
                {-1.32, 0.115, -.35, -1.34, 0.135, -0.3},
                {-1.19, 0.115, -.35, -1.21, 0.135, -0.3},
                {0.5, 0.18, .10, 0.99, 0.30, 0.22},
                {0.87, 0.18, .10, 0.99, .62, 0.22},
                {-0.8, -0.5, -0.3, -0.9, -0.08, -0.4},
                {0.3, -0.5, -0.3, 0.4, -0.08, -0.4},
                {-0.8, -0.5, 0.3, -0.9, -0.08, 0.4},
                {0.3, -0.5, 0.3, 0.4, -0.08, 0.4},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        use_texture_alpha = "clip",

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
            unilib.misc.get_inventory_drops(pos, "src", drops)
            unilib.misc.get_inventory_drops(pos, "fuel", drops)
            unilib.misc.get_inventory_drops(pos, "dst", drops)
            drops[#drops + 1] = "unilib:machine_grill_smoker"
            core.remove_node(pos)
            return drops

        end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string("formspec", get_grill_inactive_formspec())
            local inv = meta:get_inventory()
            inv:set_size("src", 1)
            inv:set_size("fuel", 1)
            inv:set_size("dst", 9)

        end,

        on_metadata_inventory_move = function(pos)

            core.get_node_timer(pos):start(1.0)

        end,

        on_metadata_inventory_put = function(pos)

            -- Start timer function, it decides whether the grill can burn or not
            core.get_node_timer(pos):start(1.0)

        end,

        on_timer = function(pos, elapsed)

            return unilib.pkg.shared_bbq_grill.grill_node_timer(
                pos, elapsed,
                "unilib:machine_grill_smoker", "unilib:machine_grill_smoker_active",
                inactive_msg, active_msg,
                unilib.pkg.shared_bbq_grill.get_inactive_formspec,
                unilib.pkg.shared_bbq_grill.get_active_formspec
            )

        end,
    })
    unilib.register_craft({
        -- From bbq:smoker
        output = "unilib:machine_grill_smoker",
        recipe = {
            {"", "", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "group:wood", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "", "unilib:metal_steel_ingot"},
        },
    })

    unilib.register_node("unilib:machine_grill_smoker_active", "bbq:smoker_active", mode, {
        -- From bbq:smoker_active
        description = S("Smoker Grill"),
        tiles = {
            "unilib_machine_grill_smoker_bottom.png",
            "unilib_machine_grill_smoker_bottom.png^[transformFY",
            {
                image = "unilib_machine_grill_smoker_side_animated.png",
                backface_culling = false,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1.5
                },
            },
            {
                image = "unilib_machine_grill_smoker_side_animated.png^[transformFX",
                backface_culling = false,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1.5
                },
            },
            {
                image = "unilib_machine_grill_smoker_back_animated.png",
                backface_culling = false,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1.5
                },
            },
            {
                image = "unilib_machine_grill_smoker_animated.png",
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
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        drop = "unilib:machine_grill_smoker",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-1.5, -0.03, -0.3, -1.0, 0.35, 0.093},
                {-1.0, -0.08, -0.5, 0.5, 0.6, 0.435    },
                {-0.375, 0.095, -.52, -0.16, 0.155, -0.54},
                {-1.37, 0.095, -.32, -1.16, 0.155, -0.34},
                {-0.345, 0.115, -.5, -0.325, 0.135, -0.55},
                {-0.21, 0.115, -.5, -0.19, 0.135, -0.55},
                {-1.32, 0.115, -.35, -1.34, 0.135, -0.3},
                {-1.19, 0.115, -.35, -1.21, 0.135, -0.3},
                {0.5, 0.18, .10, 0.99, 0.30, 0.22},
                {0.87, 0.18, .10, 0.99, .62, 0.22},
                {0.93, 0.62, .10, 0.93, .9, 0.22},
                {0.87, 0.62, .16, 0.99, .9, 0.16},
                {-0.8, -0.5, -0.3, -0.9, -0.08, -0.4},
                {0.3, -0.5, -0.3, 0.4, -0.08, -0.4},
                {-0.8, -0.5, 0.3, -0.9, -0.08, 0.4},
                {0.3, -0.5, 0.3, 0.4, -0.08, 0.4},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        use_texture_alpha = "clip",

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
                "unilib:machine_grill_smoker", "unilib:machine_grill_smoker_active",
                inactive_msg, active_msg,
                unilib.pkg.shared_bbq_grill.get_inactive_formspec,
                unilib.pkg.shared_bbq_grill.get_active_formspec
            )

        end,
    })

end
