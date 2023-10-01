---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_packet_veggie = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_packet_veggie.init()

    return {
        description = "Veggie packet",
        depends = "item_foil_kitchen",
        suggested = {
            "ingredient_pepper_ground",         -- group:food_pepper_ground
            "produce_corn_normal",              -- group:food_corn
            "produce_potato_normal",            -- group:food_potato
            "produce_tomato_salad",             -- group:food_tomato
        },
    }

end

function unilib.pkg.food_packet_veggie.exec()

    unilib.register_craftitem("unilib:food_packet_veggie_raw", "bbq:veggie_packet_raw", mode, {
        -- From bbq:veggie_packet
        description = S("Raw Veggie Packet"),
        inventory_image = "unilib_food_packet_veggie_raw.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_packet_veggie_raw", 4),
    })
    unilib.register_craft({
        -- From bbq:veggie_packet
        type = "shapeless",
        output = "unilib:food_packet_veggie_raw 2",
        recipe = {
            "group:food_pepper_ground",
            "group:food_tomato",
            "group:food_potato",
            "group:food_corn",
            "unilib:item_foil_kitchen",
        },
    })

    unilib.register_craftitem("unilib:food_packet_veggie", "bbq:veggie_packet", mode, {
        -- From bbq:veggie_packet
        description = S("Veggie Packet"),
        inventory_image = "unilib_food_packet_veggie.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_packet_veggie", 5),
    })
    unilib.register_craft({
        -- From bbq:veggie_packet
        type = "cooking",
        output = "unilib:food_packet_veggie",
        recipe = "unilib:food_packet_veggie_raw",
        cooktime = 8,
    })

end
