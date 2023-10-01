---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_gates
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_castle_gates = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.castle_gates.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_ingredient_properties(data_table)

    -- Adapted from castle_gates/gate_slots.lua

    local ingredient_def_table, burn_time

    -- Override the properties of the ingredient, if required, as described below
    if data_table.override_ingredient ~= nil then

        ingredient_def_table = minetest.registered_nodes[data_table.override_ingredient]
        burn_time = minetest.get_craft_result(
            {method = "fuel", width = 1, items = {ItemStack(data_table.override_ingredient)}}
        ).time

    else

        ingredient_def_table = minetest.registered_nodes[data_table.ingredient]
        burn_time = minetest.get_craft_result(
            {method = "fuel", width = 1, items = {ItemStack(data_table.ingredient)}}
        ).time

    end

    local description = data_table.description
    if description == nil then
        description = ingredient_def_table.description
    end

    local img_list = data_table.img_list
    if img_list == nil then
        img_list = ingredient_def_table.img_list
    elseif type(img_list) == "string" then
        img_list = {img_list}
    end

    return ingredient_def_table, description, img_list, burn_time

end

---------------------------------------------------------------------------------------------------
-- Shared functions (create slots)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_castle_gates.register_gateway_slot(data_table)

    -- Adapted from castle_gates/gate_slots.lua
    -- Creates a gateway slot using the specified material
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "stone_ordinary_brick", from the item in the "stone_ordinary"
    --          package
    --      orig_slot_name (str): e.g. "castle_gates:stonebrick_gate_slot"
    --      orig_reverse_slot_name (str): e.g. "castle_gates:stonebrick_gate_slot_reverse"
    --      ingredient (str): e.g. "unilib:stone_ordinary_brick"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Ordinary Stone Bricks"
    --      img_list (str or list): Textures used for the gateway slot
    --      override_ingredient (str): Overrides the properties of .ingredient, usually specified
    --          when .ingredient is a group, e.g. "group:wood", in which case we have to extract
    --          data from the override ingredient's definition table (because non exists for
    --          "group:wood")

    local part_name = data_table.part_name
    local orig_slot_name = data_table.orig_slot_name
    local orig_reverse_slot_name = data_table.orig_reverse_slot_name
    local ingredient = data_table.ingredient

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode

    local ingredient_def_table, description, img_list, burn_time = get_ingredient_properties(
        data_table
    )

    unilib.register_node("unilib:" .. part_name .. "_slot", orig_slot_name, replace_mode, {
        description = unilib.brackets(description, S("Gateway Slot")),
        tiles = img_list,
        groups = ingredient_def_table.groups,
        sounds = ingredient_def_table.sounds,

        collision_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 1.5},
        },
        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                {-0.5, -0.5, -0.75, 0.5, 0.5, -1.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })

    unilib.register_node(
        "unilib:" .. part_name .. "_slot_reverse",
        orig_reverse_slot_name,
        replace_mode,
        {
            description = unilib.brackets(description, S("Reverse Gateway Slot")),
            tiles = img_list,
            groups = ingredient_def_table.groups,
            sounds = ingredient_def_table.sounds,

            collision_box = {
                type = "fixed",
                fixed = {-0.5, -0.5, -1.25, 0.5, 0.5, 0.5},
            },
            drawtype = "nodebox",
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -1.25, 0.5, 0.5, 0.5},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
        }
    )
    unilib.register_craft({
        output = "unilib:" .. part_name .. "_slot 3",
        recipe = {
            {ingredient, "", ingredient},
            {ingredient, "", ingredient},
            {ingredient, "", ingredient},
        },
    })
    unilib.register_craft({
        type = "shapeless",
        output = "unilib:" .. part_name .. "_slot",
        recipe = {"unilib:" .. part_name .. "_slot_reverse"},
    })
    unilib.register_craft({
        type = "shapeless",
        output = "unilib:" .. part_name .. "_slot_reverse",
        recipe = {"unilib:" .. part_name .. "_slot"},
    })
    if burn_time > 0 then

        unilib.register_craft({
            type = "fuel",
            recipe = "unilib:" .. part_name .. "_slot",
            burntime = burn_time * 2,
        })
        unilib.register_craft({
            type = "fuel",
            recipe = "unilib:" .. part_name .. "_slot_reverse",
            burntime = burn_time * 2,
        })

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_castle_gates.init()

    return {
        description = "Shared functions for gateways (from castle modpack)",
        notes = "Creates items of various materials, which have a carved slot through which a " ..
                " sliding gateway can pass",
    }

end
