---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pkarcs/pkarcs_doors
-- Code:    LGPL-2.1
-- Media:   CC-BY-SA-4.0
--
-- From:    pkarcs/pkarcs_doors3
-- Code:    LGPL-2.1
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_pkarcs = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pkarcs_doors.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_open(pos, node, part_name, side, door_sound)

    if not side or side == "left" then

        minetest.swap_node(
            pos,
            {name = "unilib:door_arched_" .. part_name .. "_left_open", param2 = node.param2}
        )

    elseif side == "right" or side then

        minetest.swap_node(
            pos,
            {name = "unilib:door_arched_" .. part_name .. "_right_open", param2 = node.param2}
        )

    end

    minetest.sound_play(door_sound .. "_open", {pos = pos, gain = 0.20, max_hear_distance = 10})

end

local function do_close(pos, node, part_name, side, door_sound)

    if not side or side == "left" then

        minetest.swap_node(
            pos,
            {name = "unilib:door_arched_" .. part_name .. "_left_closed", param2 = node.param2}
        )

    elseif side == "right" or side then

        minetest.swap_node(
            pos,
            {name = "unilib:door_arched_" .. part_name .. "_right_closed", param2 = node.param2}
        )

    end

    minetest.sound_play(door_sound .. "_close", {pos = pos, gain = 0.15, max_hear_distance = 10})

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_pkarcs.register_arched_door(data_table)

    -- Creates a normal-height arched door
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "wood_acacia"
    --      orig_name (str): e.g. The corresponding component in the original node's name, e.g.
    --          "acacia_wood"
    --      img_list (list): List of images for the .textures field
    --      ingredient (str): e.g. "unilib:tree_acacia_wood"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Acacia Wood Arched Door"
    --      group_table (table): Complete table table, e.g. {choppy = 2, door = 1}
    --      open_sound (str): Sound when opening, e.g. "unilib_door", corresponding to the files
    --          "unilib_door_open.ogg" and "unilib_door_close.ogg"
    --      sound_type (str): Sound type when punched, e.g. "wood"

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local img_list = data_table.img_list
    local ingredient = data_table.ingredient

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Arched Door")
    local group_table = data_table.group_table or {choppy = 2, door = 1}
    local open_sound = data_table.open_sound or "unilib_door"
    local sound_type = data_table.sound_type or "wood"

    local mesecons_flag = unilib.mesecons_door_flag and minetest.get_modpath("mesecons")

    local left_closed_table = {
        description = description,
        tiles = {img_list},
        groups = group_table,
        sounds = unilib.sound_table[sound_type],

        collision_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 1.4375, -0.375},
            },
        },
        drawtype = "mesh",
        inventory_image = "unilib_door_arched_" .. part_name .. "_inv.png",
        is_ground_content = false,
        mesh = "unilib_door_arched_left_closed.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 1.4375, -0.375},
            },
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        wield_image = "unilib_door_arched_" .. part_name .. "_inv.png",

        on_rightclick = function(pos, node, puncher)
            do_open(pos, node, part_name, "left", open_sound)
        end,

        on_rotate = function(pos, node, user, mode, new_param2)

            if unilib.pkg_executed_table["shared_screwdriver"] ~= nil then
                unilib.pkg.shared_screwdriver.rotate_simple(pos, node, user, mode, new_param2)
            end

        end,
    }

    if mesecons_flag then

        left_closed_table.mesecons = {
            effector = {
                action_on = function(pos, node)
                    do_open(pos, node, part_name, "left", open_sound)
                end,

                rules = mesecon.rules.pplate,
            },
        }

    end

    unilib.register_node(
        "unilib:door_arched_" .. part_name .. "_left_closed",
        "pkarcs_doors:" .. orig_name .. "_Ldoor",
        mode,
        left_closed_table
    )
    unilib.register_craft({
        output = "unilib:door_arched_" .. part_name .. "_left_closed",
        recipe = {
            {"", "", ""},
            {"", ingredient, ""},
            {ingredient, ingredient, ""},
        },
    })

    local left_open_table = {
        -- (no description)
        tiles = {img_list},
        groups = group_table,
        sounds = unilib.sound_table[sound_type],

        collision_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -1.4375, -0.375, 1.4375, -0.4375},
            },
        },
        drawtype = "mesh",
        drop = "unilib:door_arched_" .. part_name .. "_left_closed",
        is_ground_content = false,
        mesh = "unilib_door_arched_left_open.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -1.4375, -0.375, 1.4375, -0.4375},
            },
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",

        on_rightclick = function(pos, node, puncher)
            do_close(pos, node, part_name, "left", open_sound)
        end,

        on_rotate = function(pos, node, user, mode, new_param2)

            if unilib.pkg_executed_table["shared_screwdriver"] ~= nil then
                unilib.pkg.shared_screwdriver.rotate_simple(pos, node, user, mode, new_param2)
            end

        end,
    }

    if mesecons_flag then

        left_open_table.mesecons = {
            effector = {
                action_on = function(pos, node)
                    do_close(pos, node, part_name, "left", open_sound)
                end,

                rules = mesecon.rules.pplate,
            },
        }

    end

    unilib.register_node(
        "unilib:door_arched_" .. part_name .. "_left_open",
        "pkarcs_doors:" .. orig_name .. "_Ldoor_open",
        mode,
        left_open_table
    )

    local right_closed_table = {
        description = description,
        tiles = {img_list},
        groups = group_table,
        sounds = unilib.sound_table[sound_type],

        collision_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 1.4375, -0.375},
            },
        },
        drawtype = "mesh",
        inventory_image = "unilib_door_arched_" .. part_name .. "_inv.png^[transformFXX",
        is_ground_content = false,
        mesh = "unilib_door_arched_right_closed.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 1.4375, -0.375},
            },
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        wield_image = "unilib_door_arched_" .. part_name .. "_inv.png^[transformFXX",

        on_rightclick = function(pos, node, puncher)
            do_open(pos, node, part_name, "right", open_sound)
        end,

        on_rotate = function(pos, node, user, mode, new_param2)

            if unilib.pkg_executed_table["shared_screwdriver"] ~= nil then
                unilib.pkg.shared_screwdriver.rotate_simple(pos, node, user, mode, new_param2)
            end

        end,
    }

    if mesecons_flag then

        right_closed_table.mesecons = {
            effector = {
                action_on = function(pos, node)
                    do_open(pos, node, part_name, "right", open_sound)
                end,

                rules = mesecon.rules.pplate,
            },
        }

    end

    unilib.register_node(
        "unilib:door_arched_" .. part_name .. "_right_closed",
        "pkarcs_doors:" .. orig_name .. "_Rdoor",
        mode,
        right_closed_table
    )
    unilib.register_craft({
        output = "unilib:door_arched_" .. part_name .. "_right_closed",
        recipe = {
            {"", "", ""},
            {"", ingredient, ""},
            {"", ingredient, ingredient},
        }
    })

    local right_open_table = {
        -- (no description)
        tiles = {img_list},
        groups = group_table,
        sounds = unilib.sound_table[sound_type],

        collision_box = {
            type = "fixed",
            fixed = {
                {0.375, -0.5, -1.4375, 0.5, 1.4375, -0.4375},
            },
        },
        drawtype = "mesh",
        drop = "unilib:door_arched_" .. part_name .. "_right_closed",
        is_ground_content = false,
        mesh = "unilib_door_arched_right_open.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {0.375, -0.5, -1.4375, 0.5, 1.4375, -0.4375},
            },
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",

        on_rightclick = function(pos, node, puncher)
            do_close(pos, node, part_name, "right", open_sound)
        end,

        on_rotate = function(pos, node, user, mode, new_param2)

            if unilib.pkg_executed_table["shared_screwdriver"] ~= nil then
                unilib.pkg.shared_screwdriver.rotate_simple(pos, node, user, mode, new_param2)
            end

        end,
    }

    if mesecons_flag then

        right_open_table.mesecons = {
            effector = {
                action_on = function(pos, node)
                    do_close(pos, node, part_name, "right", open_sound)
                end,

                rules = mesecon.rules.pplate,
            },
        }

    end

    unilib.register_node(
        "unilib:door_arched_" .. part_name .. "_right_open",
        "pkarcs_doors:" .. orig_name .. "_Rdoor_open",
        mode,
        right_open_table
    )

end

function unilib.pkg.shared_pkarcs.register_tall_arched_door(data_table)

    -- Creates a tall arched door
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "wood_acacia"
    --      orig_name (str): e.g. The corresponding component in the original node's name, e.g.
    --          "acacia_wood"
    --      img_list (list): List of images for the .textures field
    --      ingredient (str): e.g. "unilib:tree_acacia_wood"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Tall Acacia Wood Arched Door"
    --      group_table (table): Complete table table, e.g. {choppy = 2, door = 1}
    --      open_sound (str): Sound when opening, e.g. "unilib_door", corresponding to the files
    --          "unilib_door_open.ogg" and "unilib_door_close.ogg"
    --      sound_type (str): Sound type when punched, e.g. "wood"

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local img_list = data_table.img_list
    local ingredient = data_table.ingredient

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Tall Arched Door")
    local group_table = data_table.group_table or {choppy = 2, door = 1}
    local open_sound = data_table.open_sound or "unilib_door"
    local sound_type = data_table.sound_type or "wood"

    local mesecons_flag = unilib.mesecons_door_flag and minetest.get_modpath("mesecons")

    local left_closed_table = {
        description = description,
        tiles = {img_list},
        groups = group_table,
        sounds = unilib.sound_table[sound_type],

        collision_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 2.4375, -0.375},
            },
        },
        drawtype = "mesh",
        inventory_image = "unilib_door_arched_" .. part_name .. "_tall_inv.png",
        is_ground_content = false,
        mesh = "unilib_door_arched_tall_left_closed.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 2.4375, -0.375},
            },
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        wield_image = "unilib_door_arched_" .. part_name .. "_tall_inv.png",

        on_rightclick = function(pos, node, puncher)
            do_open(pos, node, part_name .. "_tall", "left", open_sound)
        end,

        on_rotate = function(pos, node, user, mode, new_param2)

            if unilib.pkg_executed_table["shared_screwdriver"] ~= nil then
                unilib.pkg.shared_screwdriver.rotate_simple(pos, node, user, mode, new_param2)
            end

        end,
    }

    if mesecons_flag then

        left_closed_table.mesecons = {
            effector = {
                action_on = function(pos, node)
                    do_open(pos, node, part_name .. "_tall", "left", open_sound)
                end,

                rules = mesecon.rules.pplate,
            },
        }

    end

    unilib.register_node(
        "unilib:door_arched_" .. part_name .. "_tall_left_closed",
        "pkarcs_doors3:" .. orig_name .. "_Ldoor",
        mode,
        left_closed_table
    )
    unilib.register_craft({
        output = "unilib:door_arched_" .. part_name .. "_tall_left_closed",
        recipe = {
            {"", ingredient, ""},
            {ingredient, ingredient, ""},
            {ingredient, ingredient, ""},
        },
    })

    local left_open_table = {
        -- (no description)
        tiles = {img_list},
        groups = group_table,
        sounds = unilib.sound_table[sound_type],

        collision_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -1.4375, -0.375, 2.4375, -0.4375},
            },
        },
        drawtype = "mesh",
        drop = "unilib:door_arched_" .. part_name .. "_tall_left_closed",
        is_ground_content = false,
        mesh = "unilib_door_arched_tall_left_open.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -1.4375, -0.375, 2.4375, -0.4375},
            },
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",

        on_rightclick = function(pos, node, puncher)
            do_close(pos, node, part_name .. "_tall", "left", open_sound)
        end,

        on_rotate = function(pos, node, user, mode, new_param2)

            if unilib.pkg_executed_table["shared_screwdriver"] ~= nil then
                unilib.pkg.shared_screwdriver.rotate_simple(pos, node, user, mode, new_param2)
            end

        end,
    }

    if mesecons_flag then

        left_open_table.mesecons = {
            effector = {
                action_on = function(pos, node)
                    do_close(pos, node, part_name .. "_tall", "left", open_sound)
                end,

                rules = mesecon.rules.pplate,
            },
        }

    end

    unilib.register_node(
        "unilib:door_arched_" .. part_name .. "_tall_left_open",
        "pkarcs_doors3:" .. orig_name .. "_Ldoor_open",
        mode,
        left_open_table
    )

    local right_closed_table = {
        description = description,
        tiles = {img_list},
        groups = group_table,
        sounds = unilib.sound_table[sound_type],

        collision_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 2.4375, -0.375},
            },
        },
        drawtype = "mesh",
        inventory_image = "unilib_door_arched_" .. part_name .. "_tall_inv.png^[transformFXX",
        is_ground_content = false,
        mesh = "unilib_door_arched_tall_right_closed.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 2.4375, -0.375},
            },
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        wield_image = "unilib_door_arched_" .. part_name .. "_tall_inv.png^[transformFXX",

        on_rightclick = function(pos, node, puncher)
            do_open(pos, node, part_name .. "_tall", "right", open_sound)
        end,

        on_rotate = function(pos, node, user, mode, new_param2)

            if unilib.pkg_executed_table["shared_screwdriver"] ~= nil then
                unilib.pkg.shared_screwdriver.rotate_simple(pos, node, user, mode, new_param2)
            end

        end,
    }

    if mesecons_flag then

        right_closed_table.mesecons = {
            effector = {
                action_on = function(pos, node)
                    do_open(pos, node, part_name .. "_tall", "right", open_sound)
                end,

                rules = mesecon.rules.pplate,
            },
        }

    end

    unilib.register_node(
        "unilib:door_arched_" .. part_name .. "_tall_right_closed",
        "pkarcs_doors3:" .. orig_name .. "_Rdoor",
        mode,
        right_closed_table
    )
    unilib.register_craft({
        output = "unilib:door_arched_" .. part_name .. "_tall_right_closed",
        recipe = {
            {"", ingredient, ""},
            {"", ingredient, ingredient},
            {"", ingredient, ingredient},
        },
    })

    local right_open_table = {
        -- (no description)
        tiles = {img_list},
        groups = group_table,
        sounds = unilib.sound_table[sound_type],

        collision_box = {
            type = "fixed",
            fixed = {
                {0.375, -0.5, -1.4375, 0.5, 2.4375, -0.4375},
            },
        },
        drawtype = "mesh",
        drop = "unilib:door_arched_" .. part_name .. "_tall_right_closed",
        is_ground_content = false,
        mesh = "unilib_door_arched_tall_right_open.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {0.375, -0.5, -1.4375, 0.5, 2.4375, -0.4375},
            },
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",

        on_rightclick = function(pos, node, puncher)
            do_close(pos, node, part_name .. "_tall", "right", open_sound)
        end,

        on_rotate = function(pos, node, user, mode, new_param2)

            if unilib.pkg_executed_table["shared_screwdriver"] ~= nil then
                unilib.pkg.shared_screwdriver.rotate_simple(pos, node, user, mode, new_param2)
            end

        end,
    }

    if mesecons_flag then

        right_open_table.mesecons = {
            effector = {
                action_on = function(pos, node)
                    do_close(pos, node, part_name .. "_tall", "right", open_sound)
                end,

                rules = mesecon.rules.pplate,
            },
        }

    end

    unilib.register_node(
        "unilib:door_arched_" .. part_name .. "_tall_right_open",
        "pkarcs_doors3:" .. orig_name .. "_Rdoor_open",
        mode,
        right_open_table
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_pkarcs.init()

    return {
        description = "Shared functions for arched doors (from pkarcs)",
    }

end
