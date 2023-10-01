---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_centrifuge_cream = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cheese.add_mode

-- This list is populated in the .post() function below
-- Each item in the list is a mini-list in the form (ingredient, output)
local recipe_list = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function is_compatible_source(full_name)

    -- Adapted from cheese/centrifuge.lua, was is_accettable_source()

    -- (Use ipairs to ensure that recipe_list is always processed in the same order)
    for i, mini_list in ipairs(recipe_list) do

        if full_name == mini_list[1] then
            return mini_list[2]
        elseif minetest.get_item_group(full_name, "food_milk") > 0 and
                minetest.get_item_group(full_name, "food_vegan") == 0 then
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

function unilib.pkg.machine_centrifuge_cream.init()

    return {
        description = "Cream centrifuge",
        notes = "Right-click a centrifuge with either whey or milk to produce cream",
        depends = {"ingredient_whey", "item_stick_ordinary", "metal_copper"},
        optional = {
            "food_milk_coconut",
            "food_pulp_cactus",
            "ingredient_cream_cactus",
            "ingredient_cream_milk",
        },
    }

end

function unilib.pkg.machine_centrifuge_cream.exec()

    unilib.register_node("unilib:machine_centrifuge_cream", "cheese:cream_separator", mode, {
        -- From cheese:cream_separator
        description = S("Cream Centrifuge"),
        tiles = {
            "unilib_machine_centrifuge_cream_top.png",
            "unilib_machine_centrifuge_cream_top.png^[transform6",
            "unilib_machine_centrifuge_cream_side.png",
            "unilib_machine_centrifuge_cream_side.png",
            "unilib_machine_centrifuge_cream_front.png^[transform4",
            "unilib_machine_centrifuge_cream_front.png"
        },
        groups = {attached_node = 1, cracky = 1},
        -- (no sounds)

        collision_box = {
            type = "fixed",
            fixed = {
                {-0.1875, -0.5, -0.1875, 0.1875, 0.375, 0.1875},
                {0.125, -0.1875, -0.0625, 0.4375, 0, 0},
                {-0.25, -0.125, -0.0625, -0.125, -0.1875, 0.0625},
            },
        },
        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
                {-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
                {-0.0625, -0.375, -0.0625, 0.0625, 0.125, 0.0625},
                {-0.125, 0.125, -0.125, 0.125, 0.1875, 0.125},
                {-0.125, 0.1875, -0.1875, 0.125, 0.375, -0.125},
                {-0.125, 0.1875, 0.125, 0.125, 0.375, 0.1875},
                {-0.1875, 0.1875, -0.125, -0.125, 0.375, 0.125},
                {0.125, 0.1875, -0.125, 0.1875, 0.375, 0.125},
                {-0.125, -0.25, -0.125, 0.125, 0, 0.125},
                {0.125, -0.1875, -0.0625, 0.3125, -0.125, 0},
                {0.25, -0.1875, -0.0625, 0.3125, 0, 0},
                {0.25, -0.0625, -0.0625, 0.4375, 0, 0},
                {-0.25, -0.175, -0.0625, -0.125, -0.1875, 0.0625},
                {-0.25, -0.125, -0.0625, -0.125, -0.1875, -0.05},
                {-0.25, -0.125, 0.0625, -0.125, -0.1875, 0.05},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.1875, -0.5, -0.1875, 0.1875, 0.375, 0.1875},
                {0.125, -0.1875, -0.0625, 0.3125, -0.125, 0},
                {0.25, -0.1875, -0.0625, 0.3125, 0, 0},
                {0.25, -0.0625, -0.0625, 0.4375, 0, 0},
                {-0.25, -0.125, -0.0625, -0.125, -0.1875, 0.0625},
            },
        },
        use_texture_alpha = "clip",

        after_place_node = function(pos, placer, itemstack)

            local meta = minetest.get_meta(pos)
            meta:set_string(
                "infotext", S("Cream Centrifuge") .."\n" .. S("Makes cream from milk or whey")
            )

        end,

        on_rightclick = function(pos, node, player, itemstack, pointed_thing)

            if player:is_player() and itemstack:is_empty() == false then

                local full_name = itemstack:get_name()
                local output = is_compatible_source(full_name)
                if output ~= nil then

                    minetest.sound_play({
                        name = "unilib_machine_centrifuge_splash",
                        pos = pos,
                        max_hear_distance = 14,
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
    })
    unilib.register_craft({
        -- From cheese:cream_separator
        output = "unilib:machine_centrifuge_cream",
        recipe = {
            {"unilib:metal_copper_ingot", "", "unilib:metal_copper_ingot"},
            {"", "unilib:metal_copper_block", "unilib:item_stick_ordinary"},
            {"unilib:metal_copper_ingot", "unilib:metal_copper_ingot", "unilib:metal_copper_ingot"},
        }
    })

end

function unilib.pkg.machine_centrifuge_cream.post()

    if unilib.pkg_executed_table["ingredient_cream_milk"] ~= nil then

        -- (group:food_milk provided by animalia, mobs_animals and petz)
        table.insert(recipe_list, {"group:food_milk", "unilib:ingredient_cream_milk 3"})
        table.insert(recipe_list, {"unilib:ingredient_whey", "unilib:ingredient_cream_milk"})

        if minetest.get_modpath("mobs_animal") then

            table.insert(recipe_list, {"mobs:wooden_bucket_milk", "unilib:ingredient_cream_milk 3"})

        end

    end

    if unilib.pkg_executed_table["food_pulp_cactus"] ~= nil and
            unilib.pkg_executed_table["ingredient_cream_cactus"] ~= nil then

        for bucket_type, def_table in pairs(unilib.generic_bucket_table) do

            local c_pulp_bucket = "unilib:" .. bucket_type .. "_with_pulp_cactus"
            table.insert(recipe_list, {c_pulp_bucket, "unilib:ingredient_cream_cactus 2"})

        end

    end

    if unilib.pkg_executed_table["food_milk_coconut"] ~= nil and
            unilib.pkg_executed_table["ingredient_cream_coconut"] ~= nil then

        table.insert(recipe_list, {"unilib:food_milk_coconut", "unilib:ingredient_cream_coconut 2"})

    end

    -- Recipes complete, now update unified_inventory/I3 (if loaded) with custom craft types
    if minetest.get_modpath("unified_inventory") ~= nil then

        unified_inventory.register_craft_type("centrifugation", {
            description = S("Centrifugation"),
            icon = "unilib_machine_centrifuge_cream_front.png",
            width = 1,
            height = 1,
            uses_crafting_grid = false
        })

    elseif minetest.get_modpath("i3") ~= nil then

        i3.register_craft_type("centrifugation", {
            description = S("Centrifugation"),
            icon = "unilib_machine_centrifuge_cream_front.png",
        })

    end

    for _, mini_list in pairs(recipe_list) do

        if minetest.get_modpath("unified_inventory") ~= nil then

            unified_inventory.register_craft({
                type = "centrifugation",
                items = {mini_list[1]},
                output = mini_list[2],
            })

        elseif minetest.get_modpath("i3") ~= nil then

            i3.register_craft({
                type = "centrifugation",
                items = {mini_list[1]},
                result = mini_list[2],
            })

        end

    end

end
