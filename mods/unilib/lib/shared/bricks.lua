---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- bricks.lua
--      Set up shared functions for bricks
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register coloured bricks
---------------------------------------------------------------------------------------------------

function unilib.register_coloured_brick_block(data_table)

    -- Adapted from morebricks/init.lua
    -- Creates horizontal and vertical brick blocks in the specified colour
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "green"
    --      horizontal_orig_name (str): e.g. "morebricks:green"
    --      vertical_orig_name (str): e.g. "morebricks:greenvertical"
    --      major_ingredient (str): e.g. "unilib:brick_ordinary" or "unilib:metal_gold_ingot"
    --      minor_ingredient (str): e.g. "unilib:clay_baked_green" or ""
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Green Brick Block"
    --      group_table (table): e.g. {cracky = 1, level = 2}
    --      old_flag (bool): true to create "aged" blocks, using group:dirt as a further ingredient
    --      quantity (int): The craft recipe output quantity, e.g. 3

    local part_name = data_table.part_name
    local horizontal_orig_name = data_table.horizontal_orig_name
    local vertical_orig_name = data_table.vertical_orig_name
    local major_ingredient = data_table.major_ingredient
    local minor_ingredient = data_table.minor_ingredient

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Brick Block")
    local group_table = data_table.group_table or {cracky = 2, level = 1}
    local old_flag = data_table.old_flag or false
    local quantity = data_table.quantity or 3

    local horizontal_full_name = "unilib:brick_" .. part_name .. "_block"
    local vertical_full_name = "unilib:brick_" .. part_name .. "_block_vertical"

    local old_ingredient = ""
    if old_flag then

        -- N.B. "default:dirt" in original code
        old_ingredient = "group:soil"

    end

    local on_place, place_param2
    if not unilib.auto_rotate_brick_flag then
        on_place = minetest.rotate_node
    else
        place_param2 = 0
    end

    unilib.register_node(horizontal_full_name, horizontal_orig_name, replace_mode, {
        description = description,
        tiles = {"unilib_brick_" .. part_name .. "_block.png"},
        groups = group_table,
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
        light_source = 0,
        paramtype2 = "facedir",
        place_param2 = place_param2,

        on_place = on_place,
    })
    unilib.register_craft({
        output = horizontal_full_name .. " " .. tostring(quantity),
        recipe = {
            {major_ingredient, major_ingredient, minor_ingredient},
            {major_ingredient, major_ingredient, minor_ingredient},
            {"", old_ingredient, ""},
        }
    })
    unilib.register_craft({
        output = horizontal_full_name,
        recipe = {
            {"", "", ""},
            {"", vertical_full_name, ""},
            {"", "", ""},
        }
    })
    unilib.register_stairs(horizontal_full_name)

    unilib.register_node(vertical_full_name, vertical_orig_name, replace_mode, {
        description = unilib.brackets(description, S("Vertical")),
        tiles = {"unilib_brick_" .. part_name .. "_block_vertical.png"},
        groups = {cracky = 3, bakedclay = 1},
        sounds = unilib.sound_table.stone,

        -- N.B. is_ground_content and light_source not in original code
        is_ground_content = false,
        light_source = 0,
        paramtype2 = "facedir",
        place_param2 = place_param2,

        on_place = on_place,
    })
    unilib.register_craft({
        -- Original to unilib
        output = vertical_full_name .. " " .. tostring(quantity),
        recipe = {
            {major_ingredient, major_ingredient, ""},
            {major_ingredient, major_ingredient, old_ingredient},
            {minor_ingredient, minor_ingredient, ""},
        }
    })
    unilib.register_craft({
        output = vertical_full_name,
        recipe = {
            {"", "", ""},
            {"", horizontal_full_name, ""},
            {"", "", ""},
        }
    })
    unilib.register_stairs(vertical_full_name)

end
