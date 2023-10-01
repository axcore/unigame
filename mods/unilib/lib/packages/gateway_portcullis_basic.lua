---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_gates
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.gateway_portcullis_basic = {}

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
    --      ingredient (str): e.g. "unilib:tree_aspen_wood"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Wood")
    local ingredient = data_table.ingredient or "unilib:tree_" .. part_name .. "_wood"

    local section_full_name = "unilib:gateway_portcullis_" .. part_name .. "_section"
    local section_orig_name
    if part_name == "apple" then
        section_orig_name = "castle_gates:portcullis_bars"
    end

    local edge_full_name = "unilib:gateway_portcullis_" .. part_name .. "_section_edge"
    local edge_orig_name
    if part_name == "apple" then
        edge_orig_name = "castle_gates:portcullis_bars_bottom"
    end

    local img = "unilib_tree_" .. part_name .. "_wood.png"
    local top_img = "unilib_door_steel_castle.png^(" .. img .. "^[transformR90" ..
            "^[mask:unilib_mask_gateway_portcullis.png)"

    unilib.register_node(section_full_name, section_orig_name, replace_mode, {
        description = unilib.brackets(S("Portcullis Section"), description),
        tiles = {
            top_img,
            top_img,
            img .. "^[transformR90",
            img .. "^[transformR90",
            top_img,
            top_img,
        },
        -- N.B. castle_gateway = 1 was castle_gate = 1 in original code
        groups = {castle_gateway = 1, choppy = 1, flow_through = 1},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.125, -0.5, -0.5, 0.125, 0.5, -0.25},
                {-0.5, -0.5, -0.5, -0.375, 0.5, -0.25},
                {0.375, -0.5, -0.5, 0.5, 0.5, -0.25},
                {-0.375, 0.1875, -0.4375, 0.375, 0.3125, -0.3125},
                {-0.375, -0.3125, -0.4375, 0.375, -0.1875, -0.3125},
            }
        },
        paramtype = "light",
        paramtype2 = "facedir",

        on_rightclick = unilib.trigger_gateway,
    })
    unilib.register_craft({
        output = section_full_name .. " 3",
        recipe = {
            {ingredient, "unilib:metal_steel_ingot", ingredient},
            {ingredient, "unilib:metal_steel_ingot", ingredient},
            {ingredient, "unilib:metal_steel_ingot", ingredient},
        },
    })
    unilib.register_craft({
        output = section_full_name,
        recipe = {
            {edge_full_name},
        },
    })

    unilib.register_node(edge_full_name, edge_orig_name, replace_mode, {
        description = unilib.brackets(S("Portcullis Edge"), description),
        tiles = {
            top_img,
            top_img,
            img .. "^[transformR90",
            img .. "^[transformR90",
            top_img,
            top_img,
        },
        -- N.B. castle_gateway = 1 was castle_gate = 1 in original code
        groups = {castle_gateway = 1, choppy = 1, flow_through = 1},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.125, -0.5, -0.5, 0.125, 0.5, -0.25},
                {-0.5, -0.5, -0.5, -0.375, 0.5, -0.25},
                {0.375, -0.5, -0.5, 0.5, 0.5, -0.25},
                {-0.375, 0.1875, -0.4375, 0.375, 0.3125, -0.3125},
                {-0.375, -0.3125, -0.4375, 0.375, -0.1875, -0.3125},
                {-0.0625, -0.5, -0.4375, 0.0625, -0.625, -0.3125},
                {0.4375, -0.5, -0.4375, 0.5, -0.625, -0.3125},
                {-0.5, -0.5, -0.4375, -0.4375, -0.625, -0.3125},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",

        _gate_edges = {bottom = true},

        on_rightclick = unilib.trigger_gateway,
    })
    unilib.register_craft({
        output = edge_full_name,
        recipe = {
            {section_full_name},
        },
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gateway_portcullis_basic.init()

    return {
        description = "Portcullis set",
        notes = "This package creates portcullis sections from the full range of super trees." ..
                " Multiple portcullis sections, placed together, will slide when right-clicked." ..
                " The portcullis \'edge\' can be used at the point that meets another" ..
                " portcullis, if required. Use a screwdriver to reorientate sections as required",
        depends = "metal_steel",
    }

end

function unilib.pkg.gateway_portcullis_basic.post()

    for tree_type, _ in pairs(unilib.super_tree_table) do

        if unilib.tree_table[tree_type] ~= nil and
                unilib.pkg_executed_table["tree_" .. tree_type] ~= nil then

            do_register({
                part_name = tree_type,

                replace_mode = mode,
                description = unilib.tree_table[tree_type]["description"],
                ingredient = "unilib:tree_" .. tree_type .. "_wood",
            })

        end

    end

end
