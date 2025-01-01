---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_cheese_rack = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_cheese(cheese_list)

    -- Adapted from cheese/cheese_rack.lua
    -- Returns a random cheese type (from a list of cheeses compatible with the cheese rack), in
    --      a random quantity (2-4)

    -- (Protect against unloaded cheese packages)
    local adj_list = {}
    for _, part_name in pairs(cheese_list) do

        if core.registered_craftitems["unilib:food_cheese_" .. part_name] ~= nil then
            table.insert(adj_list, part_name)
        end

    end

    if #adj_list == 0 then
        return

    else

        return "unilib:food_cheese_" .. adj_list[math.random(#adj_list)] .. " " ..
                math.random(2, 4)

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_cheese_rack.register_cheese_rack(data_table)

    -- Adapted from cheese/cheese_rack.lua
    -- Creates cheese racks crafted from a specified ingredient

    -- data_table compulsory fields:
    --      part_name (str): e.g. "wooden"
    --      orig_part_name (str): Partial name of the original cheese mod nodes, e.g.
    --          "wooden_cheese_rack" for "cheese:wooden_cheese_rack_empty", etc
    --      cheese_list (list): Partial names for compatible cheeses, e.g. "parmesan" which
    --          corresponds to unilib:cheese_food_parmesan. When curd is placed in the rack, it ages
    --          into a random cheese from this list
    --      ingredient (str): e.g. "unilib:tree_apple_wood"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      age_time (float): The minimum cheese ageing time, in seconds. The actual time is
    --          randomised
    --      description (str): e.g. "Wooden Cheese Rack"
    --      img (str): e.g. "unilib_tree_apple_wood.png"
    --      wood_flag (bool): True for wooden racks, false (or nil) for everything else

    local part_name = data_table.part_name
    local orig_part_name = data_table.orig_part_name
    local cheese_list = data_table.cheese_list
    local ingredient = data_table.ingredient

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local age_time = data_table.age_time or 30.0
    local description = data_table.description or S("Cheese Rack")
    local img = data_table.img or "unilib_tree_apple_wood.png"
    local wood_flag = data_table.wood_flag or false

    local item_name = "container_cheese_rack_" .. part_name

    local empty_group_table, active_group_table, full_group_table, sound_table
    if not wood_flag then

        empty_group_table = {cheese_rack = 1, cracky = 2}
        active_group_table = {cheese_rack = 1, cracky = 2, not_in_creative_inventory = 1}
        full_group_table = {cheese_rack = 1, cracky = 2, not_in_creative_inventory = 1}
        sound_table = unilib.global.sound_table.stone

    else

        empty_group_table = {cheese_rack = 1, choppy = 2}
        active_group_table = {cheese_rack = 1, choppy = 2, not_in_creative_inventory = 1}
        full_group_table = {cheese_rack = 1, choppy = 2, not_in_creative_inventory = 1}
        sound_table = unilib.global.sound_table.wood

    end

    -- Empty rack
    unilib.register_node(
        "unilib:" .. item_name .. "_empty",
        "cheese:" .. orig_part_name .. "_empty",
        replace_mode,
        {
            description = unilib.utils.brackets(description, S("Empty")),
            tiles = {img},
            groups = empty_group_table,
            sounds = sound_table,

            collision_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.4375, 0.5, 0.5, 0.5},
                },
            },
            drawtype = "nodebox",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.4375, 0.5, -0.375, 0.375},
                    {-0.5, 0.375, -0.4375, 0.5, 0.5, 0.375},
                    {-0.5, -0.5, 0.375, 0.5, 0.5, 0.5},
                    {0.375, -0.375, -0.375, 0.5, 0.375, 0.375},
                    {-0.5, -0.375, -0.375, -0.375, 0.375, 0.375},
                    {-0.4375, -0.0625, -0.4375, 0.4375, 0.0625, 0.375},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.4375, 0.5, 0.5, 0.5},
                },
            },

            on_rightclick = function(pos, node, player, itemstack, pointed_thing)

                -- Pointed_thing can be nil when called by a mod :/
                if player:is_player() and itemstack:get_name() == "unilib:ingredient_curd" then

                    itemstack:take_item()
                    core.sound_play(
                        "unilib_cheese_rack_insert",
                        {pos = pos, max_hear_distance = 8, gain = 0.5}
                    )

                    core.set_node(
                        pos, {name = "unilib:" .. item_name .. "_active", param2 = node.param2}
                    )

                    local meta = core.get_meta(pos)
                    meta:set_string("ageing", itemstack:get_name())

                end

                return itemstack

            end,
        }
    )
    if core.registered_nodes[ingredient .. "_stair_slab"] ~= nil then

        unilib.register_craft({
            output = "unilib:" .. item_name .. "_empty",
            recipe = {
                {ingredient, ingredient .. "_stair_slab", ingredient},
                {ingredient, ingredient .. "_stair_slab", ingredient},
                {ingredient, ingredient .. "_stair_slab", ingredient},
            },
        })

    else

        -- Original to unilib. Fallback craft recipe, in case no slabs are available for this
        --      ingredient
        unilib.register_craft({
            output = "unilib:" .. item_name .. "_empty",
            recipe = {
                {ingredient, "", ingredient},
                {ingredient, ingredient .. "_stair_slab", ingredient},
                {ingredient, "", ingredient},
            },
        })

    end

    -- Rack with ageing cheese
    unilib.register_node(
        "unilib:" .. item_name .. "_active",
        "cheese:" .. orig_part_name .. "_with_aging_cheese",
        replace_mode,
        {
            description = unilib.utils.brackets(description, S("with Ageing Cheese")),
            tiles = {
                img, img, img, img, img, img .. "^unilib_container_cheese_rack_active_overlay.png",
            },
            groups = active_group_table,
            sounds = sound_table,

            collision_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.4375, 0.5, 0.5, 0.5},
                },
            },
            drawtype = "nodebox",
            drop = "unilib:" .. item_name .. "_empty",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.4375, 0.5, -0.375, 0.375},
                    {-0.5, 0.375, -0.4375, 0.5, 0.5, 0.375},
                    {-0.5, -0.5, 0.375, 0.5, 0.5, 0.5},
                    {0.375, -0.375, -0.375, 0.5, 0.375, 0.375},
                    {-0.5, -0.375, -0.375, -0.375, 0.375, 0.375},
                    {-0.4375, -0.0625, -0.4375, 0.4375, 0.0625, 0.375},
                    {-0.375, -0.375, -0.3125, 0.375, 0.375, 0.375},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.4375, 0.5, 0.5, 0.5},
                },
            },

            on_construct = function(pos)

                local meta = core.get_meta(pos)
                if meta:get_string("ageing") == nil or meta:get_string("ageing") == "" then
                    meta:set_string("ageing", "unilib:ingredient_curd")
                end

                local timer = core.get_node_timer(pos)
                timer:start(age_time + math.random(-3.0 , 3.0))

            end,

            on_timer = function(pos)

                if core.get_node_light(pos) <= 11 and math.random(1, 10) <= 1 then

                    local node = core.get_node(pos)
                    if node.name ~= "ignore" then

                        core.set_node(
                            pos, {name = "unilib:" .. item_name .. "_full", param2 = node.param2}
                        )

                        return false

                    end

                end

                return true

            end,
        }
    )

    -- Rack with aged cheese
    unilib.register_node(
        "unilib:" .. item_name .. "_full",
        "cheese:" .. orig_part_name .. "_with_cheese",
        replace_mode,
        {
            description = unilib.utils.brackets(description, S("with Aged Cheese")),
            tiles = {
                img, img, img, img, img, img .. "^unilib_container_cheese_rack_full_overlay.png",
            },
            groups = full_group_table,
            sounds = sound_table,

            collision_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.4375, 0.5, 0.5, 0.5},
                },
            },
            drawtype = "nodebox",
            drop = "unilib:" .. item_name .. "_empty",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.4375, 0.5, -0.375, 0.375},
                    {-0.5, 0.375, -0.4375, 0.5, 0.5, 0.375},
                    {-0.5, -0.5, 0.375, 0.5, 0.5, 0.5},
                    {0.375, -0.375, -0.375, 0.5, 0.375, 0.375},
                    {-0.5, -0.375, -0.375, -0.375, 0.375, 0.375},
                    {-0.4375, -0.0625, -0.4375, 0.4375, 0.0625, 0.375},
                    {-0.375, -0.375, -0.3125, 0.375, 0.375, 0.375},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.4375, 0.5, 0.5, 0.5},
                },
            },

            on_punch = function(pos, node, player, pointed_thing)

                local inv, leftover
                local cheese_name = get_cheese(cheese_list)

                -- (If no cheese packages loaded, "cheese_name" will be nil)
                if cheese_name ~= nil and player:is_player() then

                    core.sound_play(
                        "unilib_cheese_rack_extract",
                        {pos = pos, max_hear_distance = 8, gain = 0.5}
                    )

                    inv = player:get_inventory()
                    if inv:room_for_item("main", cheese_name) then

                        leftover = inv:add_item("main", cheese_name)
                        if not leftover:is_empty() then
                            core.add_item(player:get_pos(), leftover)
                        end

                    else

                        core.add_item(player:get_pos(), cheese_name)

                    end

                    local node = core.get_node(pos)
                    core.set_node(
                        pos, {name = "unilib:" .. item_name .. "_empty", param2 = node.param2}
                    )

                end

            end,
        }
    )

    -- Update unified_inventory/I3 (if loaded) with custom craft types
    if core.get_modpath("unified_inventory") ~= nil then

        unified_inventory.register_craft_type("cheese_rack_aging", {
            description = S("Cheese Rack Ageing"),
            icon = "unilib_tree_apple_wood.png^unilib_container_cheese_rack_full_overlay.png",
            width = 1,
            height = 1,
            uses_crafting_grid = false
        })

    elseif core.get_modpath("i3") ~= nil then

        i3.register_craft_type("cheese_rack_aging", {
            description = S("Cheese Rack Ageing"),
            icon = "unilib_tree_apple_wood.png^unilib_container_cheese_rack_full_overlay.png",
        })

    end

end

function unilib.pkg.shared_cheese_rack.register_custom_craft(part_name)

    -- Adapted from cheese/items.lua
    -- Registers a custom craft recipe for an aged cheese type
    --
    -- Args:
    --      part_name (str): e.g. "parmesan" for "unilib:food_cheese_parmesan

    if core.get_modpath("unified_inventory") ~= nil then

        unified_inventory.register_craft({
            type = "cheese_rack_aging",
            items = {"unilib:ingredient_curd"},
            output = "unilib:_food_cheese_" .. part_name,
        })

    elseif core.get_modpath("i3") ~= nil then

        i3.register_craft({
            type = "cheese_rack_aging",
            items = {"unilib:ingredient_curd"},
            result = "unilib:_food_cheese_" .. part_name,
        })

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_cheese_rack.init()

    return {
        description = "Shared functions for cheese racks (from cheese)",
        notes = "Place a cheese rack in a dark place, then place curd inside it. After a period" ..
                " of time, a cheese is produced",
        depends = "ingredient_curd",
    }

end
