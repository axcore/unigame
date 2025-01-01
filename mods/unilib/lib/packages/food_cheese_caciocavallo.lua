---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cheese_caciocavallo = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cheese_caciocavallo.init()

    return {
        description = "Caciocavallo cheese",
        notes = "Before being eaten, caciocavallo must be aged by hanging it on a wooden ceiling" ..
                " in the dark",
        depends = {"ingredient_cheese_stretched", "item_string_ordinary"},
    }

end

function unilib.pkg.food_cheese_caciocavallo.exec()

    local c_stretched = "unilib:ingredient_cheese_stretched"

    unilib.register_node("unilib:food_cheese_caciocavallo", "cheese:caciocavallo", mode, {
        -- From cheese:caciocavallo
        description = S("Caciocavallo"),
        tiles = {
            "unilib_food_cheese_caciocavallo_top.png",
            "unilib_food_cheese_caciocavallo_bottom.png",
            "unilib_food_cheese_caciocavallo_right.png",
            "unilib_food_cheese_caciocavallo_left.png",
            "unilib_food_cheese_caciocavallo_back.png",
            "unilib_food_cheese_caciocavallo_front.png"
        },
        groups = {food = 8, food_cheese = 1, oddly_breakable_by_hand = 3},
        -- (no sounds)

        collision_box = {
            type = "fixed",
            fixed = {
                {-0.1875, -0.3125, -0.125, 0.25, 0.5, 0.1875},
            },
        },
        drawtype = "nodebox",
        inventory_image = "unilib_food_cheese_caciocavallo_inv.png",
        -- N.B. is_ground_content = false not in original code; added to match other food items
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.125, -0.3125, -0.0625, 0.1875, 0.125, 0.125},
                {-0.0625, 0.0625, -0.0625, 0.125, 0.1875, 0.125},
                {-0.125, 0.1875, -0.0625, 0.0625, 0.3125, 0.125},
                {0, 0.1875, 0, 0.125, 0.5, 0.0625},
                {-0.1875, -0.25, -0.0625, 0.25, 0.0625, 0.125},
                {-0.125, -0.25, -0.125, 0.1875, 0.0625, 0.1875},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.1875, -0.3125, -0.125, 0.25, 0.5, 0.1875},
            },
        },
        use_texture_alpha = "clip",
        wield_image = "unilib_food_cheese_caciocavallo_inv.png",

        after_place_node = function(pos, placer, itemstack, pointed_thing)

            if placer:is_player() and itemstack:is_empty() == false then

                local above_name = core.get_node(vector.add(pos, vector.new(0, 1, 0))).name
                if core.get_item_group(above_name , "wood") == 0 then

                    core.set_node(pos, {name = "air"})
                    core.add_item(pos, "unilib:food_cheese_caciocavallo_fresh")

                end
            end
        end,

        on_use = unilib.cuisine.eat_on_use("unilib:food_cheese_caciocavallo", 8),
    })

    unilib.register_node(
        -- From cheese:fresh_caciocavallo
        "unilib:food_cheese_caciocavallo_fresh",
        "cheese:fresh_caciocavallo",
        mode,
        {
            description = S("Fresh Caciocavallo"),
            tiles = {
                "unilib_food_cheese_caciocavallo_fresh_top.png",
                "unilib_food_cheese_caciocavallo_fresh_bottom.png",
                "unilib_food_cheese_caciocavallo_fresh_right.png",
                "unilib_food_cheese_caciocavallo_fresh_left.png",
                "unilib_food_cheese_caciocavallo_fresh_back.png",
                "unilib_food_cheese_caciocavallo_fresh_front.png"
            },
            groups = {oddly_breakable_by_hand = 3},
            -- (no sounds)

            collision_box = {
                type = "fixed",
                fixed = {
                    {-0.1875, -0.3125, -0.125, 0.25, 0.5, 0.1875},
                },
            },
            drawtype = "nodebox",
            inventory_image = "unilib_food_cheese_caciocavallo_fresh_inv.png",
            -- N.B. is_ground_content = false not in original code; added to match other food items
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.125, -0.3125, -0.0625, 0.1875, 0.125, 0.125},
                    {-0.0625, 0.0625, -0.0625, 0.125, 0.1875, 0.125},
                    {-0.125, 0.1875, -0.0625, 0.0625, 0.3125, 0.125},
                    {0, 0.1875, 0, 0.125, 0.5, 0.0625},
                    {-0.1875, -0.25, -0.0625, 0.25, 0.0625, 0.125},
                    {-0.125, -0.25, -0.125, 0.1875, 0.0625, 0.1875},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.1875, -0.3125, -0.125, 0.25, 0.5, 0.1875},
                },
            },
            use_texture_alpha = "clip",
            wield_image = "unilib_food_cheese_caciocavallo_fresh_inv.png",

            after_place_node = function(pos, placer, itemstack, pointed_thing)

                if placer:is_player() and itemstack:is_empty() == false then

                    local above_name = core.get_node(vector.add(pos, vector.new(0, 1, 0))).name

                    if above_name ~= "ignore" and
                            core.get_item_group(above_name , "wood") == 0 then

                        core.set_node(pos, {name = "air"})
                        core.add_item(pos, "unilib:food_cheese_caciocavallo_fresh")

                    end

                end

            end,

            on_construct = function(pos)

                local timer = core.get_node_timer(pos)
                timer:start(70 + math.random(-5.0, 5.0))

            end,

            on_timer = function(pos)

                local timer = core.get_node_timer(pos)

                -- Fake a reverse group:attached behaviour
                local above_name = core.get_node(vector.add(pos, vector.new(0, 1, 0))).name
                if above_name ~= "ignore" and core.get_item_group(above_name , "wood") > 0 then

                    if core.get_node_light(pos) <= 7 and (
                        core.get_node_light(pos) >= 12 or math.random() > 0.1
                    ) then
                        return true
                    end

                else

                    timer:stop()
                    core.set_node(pos, {name = "air"})
                    core.add_item(pos, "unilib:food_cheese_caciocavallo_fresh")
                    return false

                end

                local node = core.get_node(pos)
                if node.name ~= "ignore" then

                    core.set_node(
                        pos, {name = "unilib:food_cheese_caciocavallo", param2 = node.param2}
                    )

                    return false

                end

                return true

            end,
        }
    )
    unilib.register_craft({
        -- From cheese:fresh_caciocavallo
        output = "unilib:food_cheese_caciocavallo_fresh 4",
        recipe = {
            {"", "unilib:item_string_ordinary", c_stretched},
            {c_stretched, c_stretched, "unilib:item_string_ordinary"},
            {c_stretched, c_stretched, ""},
        },
    })

end
