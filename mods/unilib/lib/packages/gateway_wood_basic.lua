---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_gates
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.gateway_wood_basic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.castle_gates.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_register(data_table)

    -- Adapted from castle/castle_gates/gates.lua
    -- Creates various wooden gateway sections based on a tree type
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Aspen Wood"
    --      ingredient (str): e.g. "unilib:tree_aspen_wood_stair_slab"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Wood")
    local ingredient = data_table.ingredient or "unilib:tree_" .. part_name .. "_wood_stair_slab"

    local section_full_name = "unilib:gateway_wood_" .. part_name .. "_section"
    local section_orig_name
    if part_name == "apple" then
        section_orig_name = "castle_gates:gate_panel"
    end

    local handle_full_name = "unilib:gateway_wood_" .. part_name .. "_section_handle"
    local handle_orig_name
    if part_name == "apple" then
        handle_orig_name = "castle_gates:gate_edge_handle"
    end

    local edge_full_name = "unilib:gateway_wood_" .. part_name .. "_edge"
    local edge_orig_name
    if part_name == "apple" then
        edge_orig_name = "castle_gates:gate_edge"
    end

    local hinge_full_name = "unilib:gateway_wood_" .. part_name .. "_section_hinge"
    local hinge_orig_name
    if part_name == "apple" then
        hinge_orig_name = "castle_gates:gate_hinge"
    end

    local img = "unilib_tree_" .. part_name .. "_wood.png"

    unilib.register_node(section_full_name, section_orig_name, replace_mode, {
        description = unilib.brackets(S("Wooden Gateway Section"), description),
        tiles = {
            img .. "^[transformR90",
            img .. "^[transformR90",
            img .. "^[transformR90",
            img .. "^[transformR90",
            img .. "^[transformR90",
            img .. "^[transformR90",
        },
        -- N.B. castle_gateway = 1 was castle_gate = 1 in original code
        groups = {castle_gateway = 1, choppy = 1},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, -0.25},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",

        on_rightclick = unilib.trigger_gateway,
    })
    unilib.register_craft({
        -- From castle_gates:gate_panel
        output = section_full_name .. " 8",
        recipe = {
            {ingredient, ingredient, ""},
            {ingredient, ingredient, ""},
        },
    })
    unilib.register_craft({
        type = "shapeless",
        output = section_full_name,
        recipe = {handle_full_name},
    })

    unilib.register_node(edge_full_name, edge_orig_name, replace_mode, {
        description = unilib.brackets(S("Wooden Gateway Edge"), description),
        tiles = {
            img .. "^[transformR90",
            img .. "^[transformR90",
            img .. "^[transformR90",
            img .. "^[transformR90",
            img .. "^[transformR90^(unilib_mineral_coal_block.png" ..
                    "^[mask:unilib_mask_gateway_edge.png^[transformFX)",
            img .. "^[transformR90^(unilib_mineral_coal_block.png" ..
                    "^[mask:unilib_mask_gateway_edge.png)",
        },
        -- N.B. castle_gateway = 1 was castle_gate = 1 in original code
        groups = {castle_gateway = 1, choppy = 1},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, -0.25},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",

        _gate_edges = {right = true},

        on_rightclick = unilib.trigger_gateway,
    })
    unilib.register_craft({
        type = "shapeless",
        output = edge_full_name,
        recipe = {section_full_name},
    })

    unilib.register_node(handle_full_name, handle_orig_name, replace_mode, {
        description = unilib.brackets(S("Wooden Gateway Section with Handle"), description),
        tiles = {
            "unilib_door_steel_castle.png^(" .. img ..
                    "^[mask:unilib_mask_gateway_side.png^[transformR90)",
            "unilib_door_steel_castle.png^(" .. img ..
                    "^[mask:unilib_mask_gateway_side.png^[transformR270)",
            "unilib_door_steel_castle.png^(" .. img .. "^[transformR90" ..
                    "^[mask:unilib_mask_gateway_side.png)",
            "unilib_door_steel_castle.png^(" .. img .. "^[transformR90" ..
                    "^[mask:(unilib_mask_gateway_side.png^[transformFX))",
            img .. "^[transformR90^(unilib_mineral_coal_block.png" ..
                    "^[mask:unilib_mask_gateway_edge.png^[transformFX)" ..
                    "^(unilib_door_steel_castle.png^[mask:unilib_mask_gateway_handle.png" ..
                    "^[transformFX)",
            img .. "^[transformR90^(unilib_mineral_coal_block.png" ..
                    "^[mask:unilib_mask_gateway_edge.png)^(unilib_door_steel_castle.png" ..
                    "^[mask:unilib_mask_gateway_handle.png)",
        },
        groups = {castle_gateway = 1, choppy = 1},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, -0.25},
                {4/16, -4/16, -2/16, 6/16, 4/16, -3/16},
                {4/16, -4/16, -9/16, 6/16, 4/16, -10/16},
                {4/16, -4/16, -9/16, 6/16, -3/16, -3/16},
                {4/16, 4/16, -9/16, 6/16, 3/16, -3/16},
            }
        },
        paramtype = "light",
        paramtype2 = "facedir",

        _gate_edges = {right = true},

        on_rightclick = unilib.trigger_gateway,
        }
    )
    unilib.register_craft({
        -- From castle_gates:gate_edge_handle
        type = "shapeless",
        output = handle_full_name,
        recipe = {edge_full_name},
    })

    unilib.register_node(hinge_full_name, hinge_orig_name, replace_mode, {
        description = unilib.brackets(S("Wooden Gateway Section with Hinge"), description),
        tiles = {img .. "^[transformR90"},
        -- N.B. castle_gateway = 1 was castle_gate = 1 in original code
        groups = {castle_gateway = 1, choppy = 1},
        sounds = unilib.sound_table.wood,

        collision_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, -0.25},
        },
        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, -0.25},
                {-10/16, -4/16, -10/16, -6/16, 4/16, -6/16},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",

        _gate_hinge = {axis = "top", offset = {"front", "left"}},

        on_rightclick = unilib.trigger_gateway,
    })
    unilib.register_craft({
        -- From castle_gates:gate_hinge
        output = hinge_full_name .. " 3",
        recipe = {
            {"", section_full_name, ""},
            {"unilib:metal_steel_ingot", section_full_name, ""},
            {"", section_full_name, ""}
        },
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gateway_wood_basic.init()

    return {
        description = "Wooden gateway set",
        notes = "This package creates gateway sections from the full range of super trees." ..
                " No gateway sections are generated if basic stairs are disabled." ..
                " Multiple gateway sections, placed together, will slide when right-clicked." ..
                " The gateway \'edge\' can be used at the point that meets another gateway," ..
                " if required. The gateway \'handle\' is decorative, but can be used in the" ..
                " same way as an \'edge\'. The gateway \'hinge\' allows the gate to swing" ..
                " open, rather than slide. Use a screwdriver to reorientate sections as required",
        depends = "metal_steel",
    }

end

function unilib.pkg.gateway_wood_basic.post()

    if not unilib.add_stairs_basic_flag then
        return
    end

    for tree_type, _ in pairs(unilib.super_tree_table) do

        if unilib.tree_table[tree_type] ~= nil and
                unilib.pkg_executed_table["tree_" .. tree_type] ~= nil then

            do_register({
                part_name = tree_type,

                replace_mode = mode,
                description = unilib.tree_table[tree_type]["description"],
                ingredient = "unilib:tree_" .. tree_type .. "_wood_stair_slab",
            })

        end

    end

end
