---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_churn_milk = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cheese.add_mode

-- This list is populated in the .post() function below
-- Each item in the list is a mini-list in the form (ingredient, output)
local recipe_list = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function is_compatible_source(full_name)

    -- Adapted from cheese/churn.lua, was is_accettable_source()

    -- (Use ipairs to ensure that recipe_list is always processed in the same order)
    for i, mini_list in ipairs(recipe_list) do

        -- Demand cow milk, not vegan substitutes
        if full_name == mini_list[1] or (
            minetest.get_item_group(full_name , "food_milk") > 0 and
            minetest.get_item_group(full_name , "food_vegan") == 0
        ) then
            return mini_list[2]
        end

    end

    return nil

end

local function get_empty_container(full_name)

    -- Original to unilib, replacing original code's should_return()
    -- Converts a full bucket (e.g. "unilib:bucket_steel_with_water_ordinary") into an empty bucket
    --      (e.g. "unilib:bucket_steel_empty")
    -- If it's not a unilib bucket (such as one from mobs_animal or petz), just return an empty
    --      steel bucket or an empty bottle, assuming that it was the original ingredient

    if unilib.empty_bucket_table[full_name] ~= nil then
        return unilib.empty_bucket_table[full_name]
    elseif string.find(full_name, "bucket") then
        return "unilib:bucket_steel_empty"
    else
        return "unilib:vessel_bottle_glass_empty"
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_churn_milk.init()

    return {
        description = "Milk churn",
        notes = "Right-click a churn with either cream or milk to produce butter",
        depends = {"item_stick_ordinary", "metal_steel"},
        optional = {
            "ingredient_butter_normal",
            "ingredient_butter_vegetable",
            "ingredient_cream_milk",
        },
    }

end

function unilib.pkg.machine_churn_milk.exec()

    unilib.register_node("unilib:machine_churn_milk", "cheese:churn", mode, {
        -- From cheese:churn
        description = S("Milk Churn"),
        tiles = {
            "unilib_machine_churn_milk_top.png",
            "unilib_machine_churn_milk_bottom.png",
            "unilib_machine_churn_milk_side.png",
            "unilib_machine_churn_milk_side.png",
            "unilib_machine_churn_milk_side.png",
            "unilib_machine_churn_milk_side.png"
        },
        groups = {attached_node = 1, choppy = 2, cracky = 1},
        -- (no sounds)

        collision_box = {
            type = "fixed",
            fixed = {
                {-0.375, -0.5, -0.375, 0.375, -0.3125, 0.375},
                {-0.3125, -0.3125, -0.3125, 0.3125, -0.125, 0.3125},
                {-0.25, -0.125, -0.25, 0.25, 0.125, 0.25},
                {-0.0625, 0.0625, -0.0625, 0.0625, 0.5, 0.0625},
            }
        },
        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.375, -0.5, -0.375, 0.375, -0.3125, 0.375},
                {-0.3125, -0.3125, -0.3125, 0.3125, -0.125, 0.3125},
                {-0.25, -0.125, -0.25, 0.25, 0.0625, 0.25},
                {-0.0625, 0.0625, -0.0625, 0.0625, 0.5, 0.0625},
                {-0.25, 0.0625, -0.25, 0.25, 0.125, -0.1875},
                {-0.25, 0.0625, 0.1875, 0.25, 0.125, 0.25},
                {-0.25, 0.0625, -0.1875, -0.1875, 0.125, 0.1875},
                {0.1875, 0.0625, -0.1875, 0.25, 0.125, 0.1875},
            }
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.375, -0.5, -0.375, 0.375, -0.3125, 0.375},
                {-0.3125, -0.3125, -0.3125, 0.3125, -0.125, 0.3125},
                {-0.25, -0.125, -0.25, 0.25, 0.125, 0.25},
                {-0.0625, 0.0625, -0.0625, 0.0625, 0.5, 0.0625},
            }
        },
        use_texture_alpha = "clip",

        after_place_node = function(pos, placer, itemstack)

            local meta = minetest.get_meta(pos)
            meta:set_string(
                "infotext", S("Milk Churn") ..'\n'.. S("Makes butter from milk or milk cream")
            )

        end,

        on_rightclick = function(pos, node, player, itemstack, pointed_thing)

            if player:is_player() and itemstack:is_empty() == false then

                local full_name = itemstack:get_name()
                local output = is_compatible_source(full_name)
                if output ~= nil then

                    minetest.sound_play({
                        name = "unilib_machine_churn",
                        pos = pos,
                        max_hear_distance = 16,
                        gain = 1.0,
                    })

                    local inv = player:get_inventory()
                    if inv:room_for_item("main", output) then

                        leftover = inv:add_item("main", output)
                        itemstack:take_item()
                        if not leftover:is_empty() then
                            minetest.add_item(player:get_pos(), leftover)
                        end

                    else

                        itemstack:take_item()
                        minetest.add_item(player:get_pos(), output)

                    end

                    local replacement = get_empty_container(full_name)
                    if inv:room_for_item("main", replacement) then
                        inv:add_item("main", replacement)
                    else
                        minetest.add_item(player:get_pos(), replacement)
                    end

                end

            end

            return itemstack

        end,

        on_rotate = function(pos, node)

            return false

        end,
    })
    -- N.B. Original craft recipe used default:wood
    unilib.register_craft({
        -- From cheese:churn
        output = "unilib:machine_churn_milk",
        recipe = {
            {"", "unilib:item_stick_ordinary", ""},
            {"", "group:wood", ""},
            {"group:wood", "unilib:metal_steel_ingot", "group:wood"},
        },
    })

end

function unilib.pkg.machine_churn_milk.post()

    if unilib.pkg_executed_table["ingredient_cream_milk"] ~= nil and
            unilib.pkg_executed_table["ingredient_butter_normal"] ~= nil then

        -- (group:food_milk provided by animalia, mobs_animals and petz)
        table.insert(recipe_list, {"group:food_milk", "unilib:ingredient_butter_normal"})
        table.insert(
            recipe_list,
            {"unilib:ingredient_cream_milk", "unilib:ingredient_butter_normal 2"}
        )

        if minetest.get_modpath("mobs_animal") then

            table.insert(
                recipe_list,
                {"mobs:wooden_bucket_milk", "unilib:ingredient_butter_normal"}
            )

        end

    end

    if unilib.pkg_executed_table["ingredient_butter_vegetable"] ~= nil then

        table.insert(
            recipe_list,
            {"unilib:ingredient_butter_vegetable_prep", "unilib:ingredient_butter_vegetable 2"}
        )

    end

    -- Recipes complete, now update unified_inventory/I3 (if loaded) with custom craft types
    if minetest.get_modpath("unified_inventory") ~= nil then

        unified_inventory.register_craft_type("churning", {
            description = S("Churning"),
            icon = "unilib_machine_churn_milk_side.png",
            width = 1,
            height = 1,
            uses_crafting_grid = false
        })

    elseif minetest.get_modpath("i3") ~= nil then

        i3.register_craft_type("churning", {
            description = S("Churning"),
            icon = "Churning.png",
        })

    end

    for _, mini_list in pairs(recipe_list) do

        if minetest.get_modpath("unified_inventory") ~= nil then

            unified_inventory.register_craft({
                type = "churning",
                items = {mini_list[1]},
                output = mini_list[2],
            })

        elseif minetest.get_modpath("i3") ~= nil then

            i3.register_craft({
                type = "churning",
                items = {mini_list[1]},
                result = mini_list[2],
            })

        end

    end

end
