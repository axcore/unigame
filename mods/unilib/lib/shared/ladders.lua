---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- ladders.lua
--      Set up shared functions for ladders
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register ladders
---------------------------------------------------------------------------------------------------

function unilib.register_ladder(data_table)

    -- Adapted from default:ladder_wood
    -- Creates a ladder node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "wood_ordinary"
    --      orig_name (str): e.g. "default:ladder_wood"
    --      ingredient (str): e.g. "group:stick"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      centre_ingredient (str): e.g. "unilib:tree_jungle_wood". Used in the centre slots of the
    --          crafting recipe. If not specified, only "ingredient" is used there
    --      description (str): e.g. "Ordinary Wooden Ladder"
    --      group_table (table): Standard group table for the minetest.register_node() call
    --      side_ingredient (str): e.g. "unilib:item_string_ordinary". Used in the centre-left and
    --          centre-right slots of the crafting recipe. If not specified, only "ingredient" is
    --          used there
    --      multiple (int): Number of nodes produced in craft recipe, e.g. 1
    --      sound_name (str): e.g. "wood", a key in unilib.sound_table
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local ingredient = data_table.ingredient

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local centre_ingredient = data_table.centre_ingredient or ingredient
    local description = data_table.description or S("Ladder")
    local group_table = data_table.group_table or {}
    local side_ingredient = data_table.side_ingredient or ingredient
    local multiple = data_table.multiple or 1
    local sound_name = data_table.sound_name or "node"

    local full_name = "unilib:ladder_" .. part_name
    local img = "unilib_ladder_" .. part_name .. ".png"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {img},
        groups = group_table,
        sounds = unilib.sound_table[sound_name],

        climbable = true,
        drawtype = "signlike",
        inventory_image = img,
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {type = "wallmounted"},
        sunlight_propagates = true,
        walkable = false,
        wield_image = img,
    })
    unilib.register_craft({
        output = full_name .. " " .. multiple,
        recipe = {
            {ingredient, "", ingredient},
            {side_ingredient, centre_ingredient, side_ingredient},
            {ingredient, "", ingredient},
        }
    })

    return full_name

end
