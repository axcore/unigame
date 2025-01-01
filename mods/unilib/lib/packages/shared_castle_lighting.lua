---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_lighting
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_castle_lighting = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.castle_lighting.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_ingredient_properties(data_table)

    -- Adapted from castle_lighting/brasier.lua

    local ingredient_def_table, burn_time

    -- Override the properties of the ingredient, if required, as described below
    if data_table.override_ingredient ~= nil then

        ingredient_def_table = core.registered_nodes[data_table.override_ingredient]
        burn_time = core.get_craft_result(
            {method = "fuel", width = 1, items = {ItemStack(data_table.override_ingredient)}}
        ).time

    else

        ingredient_def_table = core.registered_nodes[data_table.ingredient]
        burn_time = core.get_craft_result(
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

    -- Apply a bed of coals to the textures
    if table.getn(img_list) == 1 then

        img_list = {
            img_list[1] .. "^(unilib_light_brazier_bed.png" ..
                    "^[mask:unilib_mask_light_brazier_bed.png)",
            img_list[1],
            img_list[1],
            img_list[1],
            img_list[1],
            img_list[1],
        }

    else

        img_list[1] = img_list[1] .. "^(unilib_light_brazier_bed.png" ..
                "^[mask:unilib_mask_light_brazier_bed.png)"

    end

    return ingredient_def_table, description, img_list, burn_time

end

---------------------------------------------------------------------------------------------------
-- Shared functions (general)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_castle_lighting.brazier_allow_metadata_inventory_put(
    pos, listname, index, stack, player
)
    -- Adapted from castle_lighting/brasier.lua
    -- Only allow fuel items to be placed in fuel

    if listname == "fuel" then

        if core.get_craft_result({method = "fuel", width = 1, items = {stack}}).time ~= 0 then
            return stack:get_count()
        else
            return 0
        end

    end

    return 0

end

function unilib.pkg.shared_castle_lighting.brazier_burn(pos)

    -- Adapted from castle_lighting/brasier.lua

    local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
    local node_above = core.get_node(pos_above)
    local timer = core.get_node_timer(pos)

    -- If already burning, don't burn something new
    if timer:is_started() and node_above.name == "unilib:fire_permanent" then
        return
    end

    local inv = core.get_inventory({type = "node", pos = pos})
    local item = inv:get_stack("fuel", 1)
    local fuel_burned = core.get_craft_result(
        {method = "fuel", width = 1, items = {item:peek_item(1)}}
    ).time

    if fuel_burned > 0 and (
        node_above.name == "air" or node_above.name == "unilib:fire_permanent"
    ) then

        item:set_count(item:get_count() - 1)
        inv:set_stack("fuel", 1, item)

        -- One minute of flame per second of burn time, for balance
        timer:start(fuel_burned * 60)

        if node_above.name == "air" then
            core.set_node(pos_above, {name = "unilib:fire_permanent"})
        end

    else

        if node_above.name == "unilib:fire_permanent" then
            core.set_node(pos_above, {name = "air"})
        end

    end

end

function unilib.pkg.shared_castle_lighting.brazier_can_dig(pos, player)

    -- Adapted from castle_lighting/brasier.lua

    local inv = core.get_meta(pos):get_inventory()
    return inv:is_empty("fuel")

end

function unilib.pkg.shared_castle_lighting.brazier_on_construct(pos)

    -- Adapted from castle_lighting/brasier.lua

    local inv = core.get_meta(pos):get_inventory()
    inv:set_size("fuel", 1)

    local meta = core.get_meta(pos)
    meta:set_string("formspec",
        "size[8,5.3]" ..
        "list[current_name;fuel;3.5,0;1,1;]" ..
        "list[current_player;main;0,1.15;8,1;]" ..
        "list[current_player;main;0,2.38;8,3;8]" ..
        "listring[current_name;main]" ..
        "listring[current_player;main]" ..
        unilib.misc.get_hotbar_bg(0, 1.15)
    )

end

function unilib.pkg.shared_castle_lighting.brazier_on_destruct(pos, oldnode)

    -- Adapted from castle_lighting/brasier.lua

    local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
    local node_above = core.get_node(pos_above)

    if node_above.name == "unilib:fire_permanent" then
        core.set_node(pos_above, {name = "air"})
    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (register masonry braziers)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_castle_lighting.register_pillar_brazier(data_table)

    -- Adapted from castle_lighting/brasier.lua
    -- Creates a pillar brazier using the specified material
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "stone_ordinary_brick", from the item in the "stone_ordinary"
    --          package
    --      orig_name (str): e.g. "castle_lighting:stonebrick_pillar_brasier"
    --      ingredient (str): e.g. "unilib:stone_ordinary_brick"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Ordinary Stone Bricks"
    --      img_list (str or list): Textures used for the gateway slot
    --      override_ingredient (str): Overrides the properties of .ingredient, usually specified
    --          when .ingredient is a group, e.g. "group:wood"

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local ingredient = data_table.ingredient

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode

    local ingredient_def_table, description, img_list, burn_time = get_ingredient_properties(
        data_table
    )

    -- No wooden braziers, snow braziers, or ice braziers, alas
    if burn_time > 0 or ingredient_def_table.groups.puts_out_fire then
        return
    end

    local full_name = "unilib:light_brazier_pillar_" .. part_name

    local group_table = {}
    for group, val in pairs(ingredient_def_table.groups) do
        group_table[group] = val
    end
    group_table.crossbrace_connectable = 1

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = unilib.utils.brackets(description, S("Pillar Brazier")),
        tiles = img_list,
        groups = group_table,
        sounds = ingredient_def_table.sounds,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.375, 0.125, -0.375, 0.375, 0.25, 0.375},
                {-0.5, 0.25, -0.5, 0.5, 0.375, 0.5},
                {-0.5, 0.375, 0.375, 0.5, 0.5, 0.5},
                {-0.5, 0.375, -0.5, 0.5, 0.5, -0.375},
                {0.375, 0.375, -0.375, 0.5, 0.5, 0.375},
                {-0.5, 0.375, -0.375, -0.375, 0.5, 0.375},
                {-0.25, -0.5, -0.25, 0.25, 0.125, 0.25},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.375, 0.125, -0.375, 0.375, 0.25, 0.375},
                {-0.5, 0.25, -0.5, 0.5, 0.5, 0.5},
                {-0.25,-0.5,-0.25,0.25,0.125,0.25},
            },
        },

        allow_metadata_inventory_put =
                unilib.pkg.shared_castle_lighting.brazier_allow_metadata_inventory_put,
        can_dig = unilib.pkg.shared_castle_lighting.brazier_can_dig,
        on_construct = unilib.pkg.shared_castle_lighting.brazier_on_construct,
        on_destruct = unilib.pkg.shared_castle_lighting.brazier_on_destruct,
        on_metadata_inventory_put = unilib.pkg.shared_castle_lighting.brazier_burn,
        on_timer = unilib.pkg.shared_castle_lighting.brazier_burn,
    })
    unilib.register_craft({
        output = full_name .. " 5",
        recipe = {
            {ingredient, "unilib:torch_ordinary", ingredient},
            {ingredient, ingredient, ingredient},
        },
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_castle_lighting.init()

    return {
        description = "Shared functions for braziers (from castle modpack)",
        notes = "To ignite a braiser, place flammable fuel in its inventory slot. A lump of" ..
                " coal will burn for about half an hour",
        depends = {"fire_permanent", "torch_ordinary"},
    }

end
