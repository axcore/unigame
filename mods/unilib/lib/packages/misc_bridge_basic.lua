---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bridges
-- Code:    GPL 3.0
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_bridge_basic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bridges.add_mode

local leg_front_left_list = {-0.5, -0.5, -0.5, -0.4, 0.5, -0.4}
local leg_front_right_list = {0.4, -0.5, -0.5, 0.5, 0.5, -0.4}
local leg_back_left_list = {-0.5, -0.5, 0.4, -0.4, 0.5, 0.5}
local leg_back_right_list = {0.4, -0.5, 0.4, 0.5, 0.5, 0.5}

local bar_left_list = {-0.5, 0.35, -0.4, -0.4, 0.4, 0.4}
local bar_right_list = {0.4, 0.35, -0.4, 0.5, 0.4, 0.4}
local bar_back_list = {0.4, 0.35, 0.4, -0.5, 0.4, 0.5}
local bar_front_list = {0.5, 0.35, -0.5, -0.5, 0.4, -0.4}

local bar_left_long_list = {-0.4, 0.35, -0.5, -0.5, 0.4, 0.5}
local bar_right_long_list = {0.4, 0.35, -0.5, 0.5, 0.4, 0.5}

local groundplate_small_list = {-0.4, -0.45, -0.5, 0.4, -0.4, 0.5}
local groundplate_corner_list = {-0.5, -0.45, -0.5, 0.5, -0.4, 0.5}

local large_node_box = {
    type = "fixed",
    fixed = {
        {-0.5, -0.5, -0.7, -0.4, 0.5, -0.6},
        {0.4, -0.5, -0.7, 0.5, 0.5, -0.6},
        {-0.5, 0.35, -1.5, -0.4, 0.4, 1.5},
        {-0.5, -0.5, 0.6, -0.4, 0.5, 0.7},
        {0.4, -0.5, 0.6, 0.5, 0.5, 0.7},
        { 0.4, 0.35, -1.5, 0.5, 0.4, 1.5},
        {-0.4, -0.45, -1.5, 0.4, -0.4, 1.5},
    }
}

local c_stick = "group:stick"

-- The standard maximum length of a bridge
local max_length = 32

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

function do_register(data_table)

    -- Adapted from bridges/init.lua
    -- Creates various nodes for building wooden bridges, all crafted from a particular tree
    -- Also creates an automatic bridge-building machine. Once deployed, the machine becomes a
    --      temporary container, storing any leftover parts
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen" (a key in unilib.global.tree_table)
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Aspen Wood"

    local part_name = data_table.part_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Wood")

    local c_base = "unilib:misc_bridge_" .. part_name .. "_base"
    local c_rail = "unilib:misc_bridge_" .. part_name .. "_handrail_middle"
    local c_slab = "unilib:tree_" .. part_name .. "_wood_stair_slab"
    local c_rope = "unilib:rope_normal"

    local img = "unilib_tree_" .. part_name .. "_wood.png"

    local bridge_list = {
        {
            "base",
            "bridge_basis",
            S("Bridge Ground Plate"),
            {groundplate_small_list},
            {
                {c_rope, c_rope, c_rope},
                {c_rope, c_slab, c_rope},
                {c_rope, c_rope, c_rope},
            },
            " 2",
        },
        {
            "small",
            "bridge_small",
            S("Small Bridge"),
            {
                leg_front_left_list,
                leg_front_right_list,
                leg_back_left_list,
                leg_back_right_list,
                bar_right_list,
                bar_left_list,
                groundplate_small_list,
            },
            {
                {c_stick, "", c_stick},
                {c_rail, c_base, c_rail},
                {c_stick, "", c_stick},
            },
            "",
        },
        {
            "middle",
            "bridge_middle",
            S("Middle of Bridge"),
            {
                bar_right_long_list,
                bar_left_long_list,
                groundplate_small_list,
            },
            {
                {"", "", ""},
                {c_rail, c_base, c_rail},
                {"", "", ""},
            },
            "",
        },
        {
            "corner",
            "bridge_corner",
            S("Corner of Bridge"),
            {
                leg_front_left_list,
                leg_front_right_list,
                leg_back_left_list,
                leg_back_right_list,
                bar_right_list,
                bar_back_list,
                groundplate_corner_list,
            },
            {
                {c_stick, c_rail, c_stick},
                {"", c_base, c_rail},
                {c_stick, "", c_stick},
            },
            "",
        },
        {
            "tjunction",
            "bridge_t",
            S("Bridge T-Junction"),
            {
                leg_front_left_list,
                leg_front_right_list,
                leg_back_left_list,
                leg_back_right_list,
                bar_back_list,
                groundplate_corner_list,
            },
            {
                {c_stick, c_rail, c_stick},
                {"", c_base, ""},
                {c_stick, "", c_stick},
            },
            ""
        },
        {
            "end",
            "bridge_end",
            S("End of Bridge"),
            {
                leg_front_left_list,
                leg_front_right_list,
                leg_back_left_list,
                leg_back_right_list,
                bar_left_list,
                bar_right_list,
                bar_back_list,
                groundplate_corner_list,
            },
            {
                {c_stick, c_rail, c_stick},
                {c_rail, c_base, c_rail},
                {c_stick, "", c_stick},
            },
            "",
        },
        {
            "handrail_middle",
            "handrail_middle",
            S("Bridge Handrail"),
            {bar_front_list},
            {
                {"", "", ""},
                {"", c_base, ""},
                {"", "", ""},
            },
            " 4",
        },
        {
            "handrail_top",
            "handrail_top",
            S("Staircase handrail, one closed side"),
            {
                leg_front_left_list,
                leg_front_right_list,
                bar_front_list,
            },
            {
                {"", "", ""},
                {"", "", ""},
                {c_stick, c_rail, c_stick},
            },
            "",
        },
        {
            "handrail_corner",
            "handrail_corner",
            S("Staircase handrail, two closed sides"),
            {
                leg_front_left_list,
                leg_front_right_list,
                bar_front_list,
                bar_left_list,
            },
            {
                {c_stick, "", ""},
                {c_rail, "", ""},
                {c_stick, c_rail, c_stick},
            },
            "",
        },
        {
            "handrail_closed",
            "handrail_closed",
            S("Staircase handrail, three closed sides"),
            {
                leg_front_left_list,
                leg_front_right_list,
                bar_front_list,
                bar_right_list,
                bar_left_list,
            },
            {
                {c_stick, c_rail, c_stick},
                {c_rail, "", ""},
                {c_stick, c_rail, c_stick},
            },
            "",
        },
    }

    for _, mini_list in ipairs(bridge_list) do

        local this_part_name = mini_list[1]
        local this_orig_part_name = mini_list[2]
        local this_description = mini_list[3]
        local this_node_box = mini_list[4]
        local this_recipe_table = mini_list[5]
        local this_output = mini_list[6]

        local this_full_name = "unilib:misc_bridge_" .. part_name .. "_" .. this_part_name
        -- (In original code, only one type of bridge, made of apple tree wood, was created)
        local this_orig_name
        if part_name == "apple" then
            this_orig_name = "bridges:" .. this_orig_part_name
        end

        unilib.register_node(this_full_name, this_orig_name, replace_mode, {
            description = unilib.utils.brackets(this_description, description),
            tiles = {img},
            groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, snappy = 2},
            -- N.B. No sounds in original code
            sounds = unilib.global.sound_table.wood,

            drawtype = "nodebox",
            node_box = {
                type = "fixed",
                fixed = this_node_box,
            },
            paramtype = 'light',
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {-0.5,-0.5,-0.5, 0.5, 0.5, 0.5},
            },
            sunlight_propagates = true,
        })
        unilib.register_craft({
            output = this_full_name .. this_output,
            recipe = this_recipe_table,
        })

    end

    -- A bridge section, 3 nodes in length
    local large_full_name = "unilib:misc_bridge_" .. part_name .. "_large"
    local large_orig_name
    if part_name == "apple" then
        large_orig_name = "bridges:bridge_large"
    end

    unilib.register_node(large_full_name, large_orig_name, replace_mode, {
        description = unilib.utils.brackets(S("Large Bridge"), description),
        tiles = {img},
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        node_box = large_node_box,
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -1.5, 0.5, 0.5, 1.5},
        },
        sunlight_propagates = true,
    })
    unilib.register_craft({
        output = large_full_name,
        recipe = {
            {"", "unilib:misc_bridge_" .. part_name .. "_middle", ""},
            {"", "unilib:misc_bridge_" .. part_name .. "_small", ""},
            {"", "unilib:misc_bridge_" .. part_name .. "_middle", ""},
        },
    })

    -- An automatic bridge-building machine. Once deployed, any leftover parts a placed inside the
    --      machine, which acts as a temporary chest
    local machine_full_name = "unilib:machine_auto_bridge_" .. part_name
    local machine_orig_name
    if part_name == "apple" then
        machine_orig_name = "bridges:bridge_auto"
    end

    unilib.register_node(machine_full_name, machine_orig_name, replace_mode, {
        description = unilib.utils.brackets(S("Self-Building Bridge Machine"), description),
        tiles = {
            img,
            img,
            img .. "^unilib_machine_auto_bridge_overlay.png",
        },
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, snappy = 2},
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.wood,

        drawtype = "cube",
        -- Notes from bridges:
        -- All leftover parts are inside the machine
        drop = "",

        after_place_node = function(pos, placer)

            local x_dir, z_dir, this_pos, this_node

            -- The bridge ought to unfold in the direction the player is looking
            local dir = placer:get_look_dir()
            local fdir = core.dir_to_facedir(dir)

            if math.abs(dir.x) > math.abs(dir.z) then

                -- The player is looking more in x- than in z-direction
                z_dir = 0
                if dir.x > 0 then
                    x_dir = 1
                else
                    x_dir = -1
                end

            else

                x_dir = 0
                if dir.z > 0 then
                    z_dir = 1
                else
                    z_dir = -1
                end

            end

            -- Work out how far the bridge can extend
            local i = 1
            -- How many parts of the bridge remain?
            local rem_small = math.floor(max_length / 3)
            local rem_middle = max_length - rem_small

            -- Extend up to a maximum of "max_length" nodes long, but only until the bridge
            --      reaches a solid surface
            while i < max_length  do

                -- Is there space for a bridge?
                this_pos = {x = pos.x + (x_dir * i), y = pos.y, z = pos.z + (z_dir * i)}
                this_node = core.get_node(this_pos)
                if this_node == nil or this_node.name ~= "air" then

                    i = max_length + 1

                else

                    -- One small bridge is followed by two middle parts
                    if (i % 3) == 1 then

                        core.add_node(
                            this_pos,
                            {
                                name = "unilib:misc_bridge_" .. part_name .. "_small",
                                param1 = 0,
                                param2 = fdir,
                            }
                        )

                        -- One small part used
                        rem_small = rem_small - 1

                    else

                        core.add_node(
                            this_pos,
                            {
                                name = "unilib:misc_bridge_" .. part_name .. "_middle",
                                param1 = 0,
                                param2 = fdir,
                            }
                        )

                        -- One middle part used
                        rem_middle = rem_middle - 1

                    end

                    i = i + 1

                end

            end

            -- Do we need to return any leftover parts?
            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()

            if rem_small > 0 then

                inv:add_item(
                    "main", "unilib:misc_bridge_" .. part_name .. "_small "..tostring(rem_small)
                )

            end

            if rem_middle > 0 then

                inv:add_item(
                    "main", "unilib:misc_bridge_" .. part_name .. "_middle "..tostring(rem_middle)
                )

            end

        end,

        can_dig = function(pos,player)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("main")

        end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string(
                "formspec",
                "invsize[8,9;]" ..
                        "list[current_name;main;0,0;8,4;]" ..
                        "list[current_player;main;0,5;8,4;]"
            )

            meta:set_string(
                "infotext",
                unilib.utils.brackets(S("Self-Building Bridge Machine"), S("Leftover parts"))
            )

            local inv = meta:get_inventory()
            inv:set_size("main", 8 * 4)

        end,
    })
    unilib.register_craft_3x3({
        output = machine_full_name,
        ingredient = large_full_name,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_bridge_basic.init()

    return {
        description = "Basic wooden bridge set",
        notes = "This package creates bridges from the full range of super trees. No bridges" ..
                " are generated if basic stairs are disabled",
        depends = "rope_normal",
    }

end

function unilib.pkg.misc_bridge_basic.post()

    if not unilib.setting.add_stairs_basic_flag then
        return
    end

    for tree_type, _ in pairs(unilib.global.super_tree_table) do

        if unilib.global.tree_table[tree_type] ~= nil and
                unilib.global.pkg_executed_table["tree_" .. tree_type] ~= nil then

            do_register({
                part_name = tree_type,

                replace_mode = mode,
                description = unilib.global.tree_table[tree_type]["description"],
            })

        end

    end

end
