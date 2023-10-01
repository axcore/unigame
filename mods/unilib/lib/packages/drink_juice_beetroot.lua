---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_juice_beetroot = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_juice_beetroot.init()

    return {
        description = "Beetroot juice",
        depends = "vessel_bottle_glass_empty",
        suggested = {
            "produce_beetroot_normal",          -- group:food_beetroot
        },
    }

end

function unilib.pkg.drink_juice_beetroot.exec()

    unilib.register_node("unilib:drink_juice_beetroot", "better_farming:beetroot_juice", mode, {
        -- From better_farming:beetroot_juice
        description = S("Beetroot Juice"),
        tiles = {"unilib_drink_juice_beetroot.png"},
        groups = {attached_node = 1, dig_immediate = 3, vessel = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_drink_juice_beetroot.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_drink_juice_beetroot.png",

        -- N.B. Original code used minetest.item_eat(), and did not return a bottle
        on_use = unilib.cuisine_drink_on_use(
            "unilib:drink_juice_beetroot", 1, "unilib:vessel_bottle_glass_empty"
        ),
    })
    unilib.register_craft({
        -- From better_farming:beetroot_juice
        output = "unilib:drink_juice_beetroot",
        -- N.B. Original code used better_farming:beetroot
        recipe = {
            {"unilib:vessel_bottle_glass_empty", "group:food_beetroot"},
        },
    })

end
