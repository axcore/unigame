---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.vessel_glass_with_squeezed_carrot = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vessel_glass_with_squeezed_carrot.init()

    return {
        description = "Glass of squeezed carrot",
        depends = {"utensil_press_hand", "vessel_glass_empty"},
        suggested = {
            "produce_carrot_normal",            -- group:food_carrot
        },
    }

end

function unilib.pkg.vessel_glass_with_squeezed_carrot.exec()

    -- N.B. Converted the original mod's craftitem into a node, to match other glass vessels
    --[[
    unilib.register_craftitem(
        -- From farming:carrot_juice
        "unilib:vessel_glass_with_squeezed_carrot",
        "farming:carrot_juice",
        mode,
        {
            description = S("Glass of Squeezed Carrot"),
            inventory_image = "unilib_vessel_glass_with_squeezed_carrot.png",
            -- N.B. no food_carrot_squeezed = 1 in original code
            groups = {drink = 1, food_carrot_squeezed = 1, vessel = 1},

            on_use = unilib.cuisine.drink_on_use(
                "unilib:vessel_glass_with_squeezed_carrot", 4, "unilib:vessel_glass_empty"
            ),
        }
    )
    ]]--
    unilib.register_node("unilib:vessel_glass_with_squeezed_carrot", "farming:carrot_juice", mode, {
        -- From farming:carrot_juice
        description = S("Glass of Squeezed Carrot"),
        tiles = {"unilib_vessel_glass_with_squeezed_carrot.png"},
        -- N.B. no attached_node = 1, dig_immediate = 3, food_carrot_squeezed = 1 in original code
--      groups = {drink = 1, vessel = 1},
        groups = {
            attached_node = 1, dig_immediate = 3, drink = 1, food_carrot_squeezed = 1, vessel = 1,
        },
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_vessel_glass_with_squeezed_carrot.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
        },
        walkable = false,
        wield_image = "unilib_vessel_glass_with_squeezed_carrot.png",

        on_use = unilib.cuisine.drink_on_use(
            "unilib:vessel_glass_with_squeezed_carrot", 4, "unilib:vessel_glass_empty"
        ),
    })
    unilib.register_craft({
        -- From farming:carrot_juice
        output = "unilib:vessel_glass_with_squeezed_carrot",
        recipe = {
            {"group:food_carrot"},
            {"unilib:utensil_press_hand"},
            {"unilib:vessel_glass_empty"},
        },
        replacements = {
            {"unilib:utensil_press_hand", "unilib:utensil_press_hand"},
        },
    })

end
