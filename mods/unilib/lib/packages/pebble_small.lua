---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.pebble_small = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.valleys_c.add_mode

-- Code, commented out in the original valleys_c mod, allowed for the creation of spheroids as well
--      as cubes. In modern version of Minetest, they do not appear to be visible, even when this
--      flag is enabled
local spheroid_flag = false

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- Number of pebble variants for each super-stone type. If this value is changed, the corresponding
--      value in the "deco_valleys_c_pebble_small" package must be changed, too
unilib.pkg.pebble_small.variant_count = 3

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function generate_spheroids(grid, pos, diameters, embed_flag)

    -- Adapted from valleys_c/deco_rocks.lua
    -- N.B. The "embed_flag" argument was never used in the original code

    local step = {x = diameters.x * 0.2, y = diameters.y * 0.2, z = diameters.z * 0.2}

    if embed_flag then
        embed_flag = 1
    else
        embed_flag = 0
    end

    table.insert(grid, {
        pos.x + step.x,
        pos.y + (step.y * embed_flag),
        pos.z,
        pos.x + diameters.x - step.x,
        diameters.y + pos.y - step.y - (step.y * embed_flag),
        pos.z + diameters.z,
    })

    table.insert(grid, {
        pos.x,
        pos.y + (step.y * embed_flag),
        pos.z + step.z,
        pos.x + step.x,
        diameters.y + pos.y - step.y - (step.y * embed_flag),
        pos.z + diameters.z - step.z,
    })

    table.insert(grid, {
        pos.x + diameters.x - step.x,
        pos.y + (step.y * embed_flag),
        pos.z + step.z,
        pos.x + diameters.x,
        diameters.y + pos.y - step.y - (step.y * embed_flag),
        pos.z + diameters.z - step.z,
    })

    if not embed_flag then

        table.insert(grid, {
            pos.x + step.x,
            pos.y,
            pos.z + step.z,
            pos.x + diameters.x - step.x,
            step.y + pos.y,
            pos.z + diameters.z - step.z,
        })

    end

    table.insert(grid, {
        pos.x + step.x,
        diameters.y + pos.y - step.y - (step.y * embed_flag),
        pos.z + step.z,
        pos.x + diameters.x - step.x,
        diameters.y + pos.y - (step.y * embed_flag),
        pos.z + diameters.z - step.z,
    })

end

local function generate_small_cube(grid, pos, diameters)

    -- Adapted from valleys_c/deco_rocks.lua

    table.insert(grid, {
        pos.x,
        pos.y,
        pos.z,
        pos.x + diameters.x,
        pos.y + diameters.y,
        pos.z + diameters.z,
    })

end

local function place_random_node(itemstack, placer, pointed_thing, part_name)

    -- Original to unilib

    local num = math.random(unilib.pkg.pebble_small.variant_count)
    local leftover, pos = core.item_place_node(
        ItemStack("unilib:pebble_small_stone_" .. part_name .. "_" .. num), placer, pointed_thing
    )

    if leftover:get_count() == 0 and not core.setting_getbool("creative_mode") then
        itemstack:take_item()
    end

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.pebble_small.register_pebble(data_table)

    -- Adapted from valleys_c/deco_rocks.lua
    -- Creates a group of pebbles in an arrangement that's randomised every time the server starts
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "ordinary", a key in unilib.global.stone_table
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode

    local def_table = core.registered_nodes["unilib:stone_" .. part_name]
    if def_table == nil then
        return
    end

    local img = def_table.tiles[1]
    local inv_img = img .. "^[mask:unilib_mask_pebble_small.png"

    -- N.B. The original code generated six items from three stone types, and a separate inventory
    --      item (so the player's inventory didn't have six different stacks)
    -- The unilib code generates three items for each super-stone type; the inventory item is the
    --      first one. When the inventory item is placed, it is swapped randomly for one of the
    --      three
    -- Because we are taking a slightly different approach, we don't use the original valleys_c
    --      node names in our calls to unilib.register_node()
    for i = 1, unilib.pkg.pebble_small.variant_count do

        local full_name = "unilib:pebble_small_stone_" .. part_name .. "_" .. i

        local grid = {}
        for rock_count = 2, math.random(1, 4) + 1 do

            local diameter = math.random(5, 15) / 100
            local x = (math.random(1, 80) / 100) - 0.5
            local z = (math.random(1, 80) / 100) - 0.5

            if spheroid_flag then

                generate_spheroids(
                    grid, {x = x, y = -0.5, z = z}, {x = diameter, y = diameter, z = diameter}
                )

            end

            generate_small_cube(
                grid, {x = x, y = -0.5, z = z}, {x = diameter, y = diameter, z = diameter}
            )

        end

        -- N.B. falling_node = 1 not in original code
        local group_table = {falling_node = 1, oddly_breakable_by_hand = 3, stone = 1}
        if i ~= 1 then
            group_table.not_in_creative_inventory = 1
        end

        -- N.B. This code block is original to unilib
        local on_place = nil
        if i == 1 then

            on_place = function(itemstack, placer, pointed_thing)
                place_random_node(itemstack, placer, pointed_thing, part_name)
            end

        end

        unilib.register_node(full_name, nil, replace_mode, {
            description = unilib.utils.brackets(S("Small Stone Pebbles"), def_table.description),
            tiles = {img},
            groups = group_table,
            sounds = unilib.global.sound_table.stone,

            buildable_to = true,
            drawtype = "nodebox",
            drop = "unilib:pebble_small_stone_" .. part_name .. "_1",
            -- N.B. No .inventory_image in original code
            inventory_image = inv_img,
            node_box = {
                type = "fixed",
                fixed = grid,
            },
            paramtype = "light",
            -- N.B. No .paramtype2 in original code
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
            },
            walkable = false,
            -- N.B. No .wield_image in original code
            wield_image = inv_img,

            on_place = on_place,
        })

        unilib.register_decoration_generic(
            "valleys_c_pebble_small_stone_" .. part_name .. "_" .. i,
                {
                deco_type = "simple",
                decoration = full_name,

                fill_ratio = 0.002,
                flags = "place_center_x, place_center_z",
                -- N.B. .param2 and .param2_max replaces the useless .rotation field in original
                --      code
--              rotation = "random",
                param2 = 0,
                param2_max = 3,
                sidelen = 80,
            }
        )

    end

    -- Small pebbles can be crafted into cobble/rubble, if available
    local cobble_name = "unilib:stone_" .. part_name .. "_cobble"
    if core.registered_nodes[cobble_name] == nil then
        cobble_name = "unilib:stone_" .. part_name .. "_rubble"
    end

    if core.registered_nodes[cobble_name] ~= nil then

        local ingredient = "unilib:pebble_small_stone_" .. part_name .. "_1"

        unilib.register_craft({
            output = cobble_name,
            recipe = {
                {"", "", ""},
                {ingredient, ingredient, ""},
                {ingredient, ingredient, ""},
            },
        })

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pebble_small.init()

    return {
        description = "Small stone pebbles",
        notes = "This package creates small pebbles from the full range of super stones",
    }

end

function unilib.pkg.pebble_small.post()

    for stone_type, _ in pairs(unilib.global.super_stone_table) do

        local data_table = unilib.global.stone_table[stone_type]

        if unilib.global.pkg_executed_table["stone_" .. stone_type] ~= nil then

            unilib.pkg.pebble_small.register_pebble({
                part_name = stone_type,

                replace_mode = mode,
            })

        end

    end

end
