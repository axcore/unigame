---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_grill_kettle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

local empty_msg = S("Kettle grill is empty")
local active_msg = S("Kettle grill active")
local inactive_msg = S("Kettle grill inactive")

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_grill_kettle.init()

    return {
        description = "Kettle grill",
        depends = {"material_charcoal_artificial_lump", "metal_steel", "shared_bbq_grill"},
    }

end

function unilib.pkg.machine_grill_kettle.exec()

    local c_charcoal = "unilib:material_charcoal_artificial_lump"

    unilib.register_node("unilib:machine_grill_kettle", "bbq:kettle_grill", mode, {
        -- From bbq:kettle_grill
        description = S("Kettle Grill"),
        tiles = {
            "unilib_machine_grill_kettle_ext_top.png",
            "unilib_machine_grill_kettle_ext_top.png",
            "unilib_machine_grill_kettle_ext.png",
            "unilib_machine_grill_kettle_ext.png",
            "unilib_machine_grill_kettle_ext.png",
            "unilib_machine_grill_kettle_ext.png",
        },
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        inventory_image = "unilib_machine_grill_kettle_inv.png",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, -0.3, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        wield_image = "unilib_machine_grill_kettle_inv.png",

        after_destruct = function(pos, oldnode)

            if core.get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name ==
                    "unilib:machine_grill_kettle_base" then
                core.set_node({x = pos.x, y = pos.y - 1, z = pos.z},{name = "air"})
            end

        end,

        after_place_node = function(pos, placer)

            core.set_node(
                {x = pos.x, y = pos.y, z = pos.z},
                {
                    name = "unilib:machine_grill_kettle_base",
                    param2 = core.dir_to_facedir(placer:get_look_dir())
                }
            )

            core.set_node(
                {x = pos.x, y = pos.y + 1, z = pos.z},
                {
                    name = "unilib:machine_grill_kettle",
                    param2 = core.dir_to_facedir(placer:get_look_dir())
                }
            )

        end,

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
            default.get_inventory_drops(pos, "src", drops)
            default.get_inventory_drops(pos, "fuel", drops)
            default.get_inventory_drops(pos, "dst", drops)
            drops[#drops + 1] = "unilib:machine_grill_kettle"
            core.remove_node(pos)
            return drops

        end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string("formspec", unilib.pkg.shared_bbq_grill.get_inactive_formspec())
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
                "unilib:machine_grill_kettle", "unilib:machine_grill_kettle_active",
                inactive_msg, active_msg,
                unilib.pkg.shared_bbq_grill.get_inactive_formspec,
                unilib.pkg.shared_bbq_grill.get_active_formspec
            )

        end,
    })
    unilib.register_craft({
        -- From bbq:kettle_grill
        output = "unilib:machine_grill_kettle",
        recipe = {
            {"unilib:metal_steel_ingot", c_charcoal, "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", c_charcoal, "unilib:metal_steel_ingot"},
            {"", "unilib:metal_steel_ingot", ""},
        },
    })

    unilib.register_node("unilib:machine_grill_kettle_active", "bbq:kettle_grill_active", mode, {
        -- From bbq:kettle_grill_active
        description = S("Kettle Grill"),
        tiles = {
            "unilib_machine_grill_kettle_ext_top_animated.png",
            "unilib_machine_grill_kettle_ext_top.png",
            {
                image = "unilib_machine_grill_kettle_ext_animated.png",
                backface_culling = false,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1.5
                },
            },
            {
                image = "unilib_machine_grill_kettle_ext_animated.png",
                backface_culling = false,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1.5
                },
            },
            {
                image = "unilib_machine_grill_kettle_ext_animated.png",
                backface_culling = false,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1.5
                },
            },
            {
                image = "unilib_machine_grill_kettle_ext_animated.png",
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
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        drop = "unilib:machine_grill_kettle",
        inventory_image = "unilib_machine_grill_kettle_inv.png",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
                {-0.18, -0.3, -0.0, 0.18, .4, 0.0},
                {-0.0, -0.3, -0.18, 0.0, .4, 0.18},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        wield_image = "unilib_machine_grill_kettle_inv.png",

        after_destruct = function(pos, oldnode)

            if core.get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name ==
                    "unilib:machine_grill_kettle_base" then
                core.set_node({x = pos.x, y = pos.y - 1, z = pos.z},{name = "air"})
            end

        end,

        after_place_node = function(pos, placer)

            core.set_node(
                {x = pos.x, y = pos.y, z = pos.z},
                {
                    name = "unilib:machine_grill_kettle_base",
                    param2 = core.dir_to_facedir(placer:get_look_dir())
                }
            )

            core.set_node(
                {x = pos.x, y = pos.y + 1, z = pos.z},
                {
                    name = "unilib:machine_grill_kettle",
                    param2 = core.dir_to_facedir(placer:get_look_dir())
                }
            )

        end,

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
                "unilib:machine_grill_kettle", "unilib:machine_grill_kettle_active",
                inactive_msg, active_msg,
                unilib.pkg.shared_bbq_grill.get_inactive_formspec,
                unilib.pkg.shared_bbq_grill.get_active_formspec
            )

        end,
    })

    unilib.register_node("unilib:machine_grill_kettle_base", "bbq:kettle_grill_base", mode, {
        -- From bbq:kettle_grill_base
        description = S("Kettle Grill Base"),
        tiles = {
            "unilib_machine_grill_kettle_base_top.png",
            "unilib_machine_grill_kettle_base_bottom.png^[transformFY",
            "unilib_machine_grill_kettle_base.png^[transformFX",
            "unilib_machine_grill_kettle_base.png",
            "unilib_machine_grill_kettle_base_side.png",
            "unilib_machine_grill_kettle_base_side.png",
        },
        groups = {cracky = 2, not_in_creative_inventory = 1},
        -- (no sounds)

        drawtype = "nodebox",
        drop = "unilib:machine_grill_kettle",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.45, 0.4, -0.45, 0.45, 0.5, 0.45},
                {-0.4, 0.313, -0.4, 0.4, 0.5, 0.4},
                {-0.1, 0.1, -0.05, 0.05, 0.5, 0.05},
                {-0.342, -0.5, -0.35, -0.292, 0.5, -0.30},
                {-0.342, -0.5, 0.35, -0.292, 0.5, 0.30},
                {0.342, -0.5, -0.35, 0.292, 0.5, -0.30},
                {0.342, -0.5, 0.35, 0.292, 0.5, 0.30},
                {-0.342, -0.3, -0.35, 0.35, -0.35, -0.30},
                {-0.342, -0.3, 0.35, 0.30, -0.35, 0.30},
                {0.342, -0.3, -0.35, 0.30, -0.35, 0.35},
                {-0.342, -0.3, -0.35, -0.30, -0.35, 0.35},
                {-0.30, -0.315, -0.2, 0.30, -0.335, -0.18},
                {-0.30, -0.315, 0.2, 0.30, -0.335, 0.18},
                {-0.30, -0.315, -0.06, 0.30, -0.335, -0.08},
                {-0.30, -0.315, 0.06, 0.30, -0.335, 0.08},
                {-0.2, -0.315, 0.30, -0.18, -0.335, -0.30},
                {0.2, -0.315, 0.30, 0.18, -0.335, -0.30},
                {-0.06, -0.315, 0.30, -0.08, -0.335, -0.30},
                {0.06, -0.315, 0.30, 0.08, -0.335, -0.30},
                {-0.468, -0.5, -0.425, -0.35, -0.25, -0.225},
                {-0.468, -0.475, -0.45, -0.35, -0.275, -0.20},
                {-0.475, -0.375, -0.345, -0.415, -0.345, -0.315},
                {0.45, -0.5, -0.425, 0.35, -0.25, -0.225},
                {0.45, -0.475, -0.45, 0.35, -0.275, -0.20},
                {0.475, -0.375, -0.345, 0.415, -0.345, -0.315},
                {-0.29, -0.5, 0.36, -0.36, -0.4375, 0.29},
                {0.29, -0.5, 0.36, 0.36, -0.4375, 0.29},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,

        after_destruct = function(pos, oldnode)

            core.set_node({x = pos.x, y = pos.y + 1, z = pos.z}, {name = "air"})

        end,

        after_place_node = function(pos, placer)

            core.set_node(
                {x = pos.x, y = pos.y + 1, z = pos.z},
                {
                    name = "unilib:machine_grill_kettle",
                    param2 = core.dir_to_facedir(placer:get_look_dir())
                }
            )

        end,
    })

end
