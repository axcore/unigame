---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.vessel_bottle_glass_with_squeezed_beetroot = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vessel_bottle_glass_with_squeezed_beetroot.init()

    return {
        description = "Bottle of squeezed beetroot",
        depends = {"utensil_press_hand", "vessel_bottle_glass_empty"},
        suggested = {
            "produce_beetroot_normal",          -- group:food_beetroot
        },
    }

end

function unilib.pkg.vessel_bottle_glass_with_squeezed_beetroot.exec()

    unilib.register_node(
        -- From better_farming:beetroot_juice
        "unilib:vessel_bottle_glass_with_squeezed_beetroot",
        "better_farming:beetroot_juice",
        mode,
        {
            description = S("Bottle of Squeezed Beetroot"),
            tiles = {"unilib_vessel_bottle_glass_with_squeezed_beetroot.png"},
            -- N.B. food_beetroot_squeezed = 1 not in original code
            groups = {attached_node = 1, dig_immediate = 3, food_beetroot_squeezed = 1, vessel = 1},
            sounds = unilib.global.sound_table.glass,

            drawtype = "plantlike",
            inventory_image = "unilib_vessel_bottle_glass_with_squeezed_beetroot.png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
            },
            walkable = false,
            wield_image = "unilib_vessel_bottle_glass_with_squeezed_beetroot.png",

            -- N.B. Original code used core.item_eat(), and did not return a bottle, and used the
            --      satiation value 1
            on_use = unilib.cuisine.drink_on_use(
                "unilib:vessel_bottle_glass_with_squeezed_beetroot",
                4,
                "unilib:vessel_bottle_glass_empty"
            ),
        }
    )
    --[[
    unilib.register_craft({
        -- From better_farming:beetroot_juice
        output = "unilib:vessel_bottle_glass_with_squeezed_beetroot",
        -- N.B. Original code used better_farming:beetroot
        recipe = {
            {"unilib:vessel_bottle_glass_empty", "group:food_beetroot"},
        },
    })
    ]]--
    unilib.register_craft({
        -- Original to unilib, matching the craft recipe for other squeezed items
        output = "unilib:drink_squeezed_beetroot",
        recipe = {
            {"group:food_beetroot"},
            {"unilib:utensil_press_hand"},
            {"unilib:vessel_bottle_glass_empty"},
        },
        replacements = {
            {"unilib:utensil_press_hand", "unilib:utensil_press_hand"},
        },
    })

end
