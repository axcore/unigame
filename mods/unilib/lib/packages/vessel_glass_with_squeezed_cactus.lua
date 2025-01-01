---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.vessel_glass_with_squeezed_cactus = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vessel_glass_with_squeezed_cactus.init()

    return {
        description = "Glass of squeezed cactus",
        notes = "Either improves the player's health, or reduces it a little",
        depends = {"plant_cactus_ordinary", "utensil_press_hand", "vessel_glass_empty"},
    }

end

function unilib.pkg.vessel_glass_with_squeezed_cactus.exec()

    -- N.B. Converted the original mod's craftitem into a node, to match other glass vessels
    --[[
    unilib.register_craftitem(
        -- From farming:cactus_juice
        "unilib:vessel_glass_with_squeezed_cactus",
        "farming:cactus_juice",
        mode,
        {
            description = S("Glass of Squeezed Cactus"),
            inventory_image = "unilib_vessel_glass_with_squeezed_cactus.png",
            -- N.B. no food_cactus in original code
            groups = {drink = 1, food_cactus = 1, vessel = 1},

            -- N.B. No call to unilib.cuisine.eat_on_use(); checking food history doesn't matter
            --      when a food can be both nutritious and poisonous
            on_use = function(itemstack, user, pointed_thing)

                if user then

                    if math.random(5) == 1 then

                        return core.do_item_eat(
                            -1, "unilib:vessel_glass_empty", itemstack, user, pointed_thing
                        )

                    else

                        return core.do_item_eat(
                            2, "unilib:vessel_glass_empty", itemstack, user, pointed_thing
                        )

                    end

                end

            end,
        }
    )
    ]]--
    unilib.register_node("unilib:vessel_glass_with_squeezed_cactus", "farming:cactus_juice", mode, {
        -- From farming:cactus_juice
        description = S("Glass of Squeezed Cactus"),
        tiles = {"unilib_vessel_glass_with_squeezed_cactus.png"},
        -- N.B. no attached_node = 1, dig_immediate = 3, food_cactus = 1, food_cactus_squeezed = 1
        --      in original code
--      groups = {drink = 1, vessel = 1},
        groups = {
            attached_node = 1, dig_immediate = 3, drink = 1, food_cactus = 1,
            food_cactus_squeezed = 1, vessel = 1,
        },
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_vessel_glass_with_squeezed_cactus.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
        },
        walkable = false,
        wield_image = "unilib_vessel_glass_with_squeezed_cactus.png",

        -- N.B. No call to unilib.cuisine.eat_on_use(); checking food history doesn't matter when
        --      a food can be both nutritious and poisonous
        on_use = function(itemstack, user, pointed_thing)

            if user then

                if math.random(5) == 1 then

                    return core.do_item_eat(
                        -1, "unilib:vessel_glass_empty", itemstack, user, pointed_thing
                    )

                else

                    return core.do_item_eat(
                        2, "unilib:vessel_glass_empty", itemstack, user, pointed_thing
                    )

                end

            end

        end,
    })
    unilib.register_craft({
        -- From farming:cactus_juice
        output = "unilib:vessel_glass_with_squeezed_cactus",
        recipe = {
            {"unilib:plant_cactus_ordinary"},
            {"unilib:utensil_press_hand"},
            {"unilib:vessel_glass_empty"},
        },
        replacements = {
            {"unilib:utensil_press_hand", "unilib:utensil_press_hand"},
        },
    })

end
