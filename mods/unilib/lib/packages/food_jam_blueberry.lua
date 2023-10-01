---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_jam_blueberry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_jam_blueberry.init()

    return {
        description = "Blueberry jam",
        depends = {"crop_cotton", "food_hotpot_blueberry", "wool_basic"},
    }

end

function unilib.pkg.food_jam_blueberry.exec()

    unilib.register_node("unilib:food_jam_blueberry", "cucina_vegana:blueberry_jam", mode, {
        -- From cucina_vegana:blueberry_jam
        description = S("Blueberry Jam"),
        tiles = {"unilib_food_jam_blueberry.png"},
        groups = {
            attached_node = 1, dig_immediate = 3, eatable = 1, food_vegan = 1, food_sweet = 1,
        },
        -- (no sounds)

        drawtype = "plantlike",
        inventory_image = "unilib_food_jam_blueberry.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_food_jam_blueberry.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_jam_blueberry", 8),
    })

end

function unilib.pkg.food_jam_blueberry.post()

    unilib.register_craft({
        -- From cucina_vegana:blueberry_jam
        output = "unilib:food_jam_blueberry",
        recipe = {
            {"unilib:food_hotpot_blueberry_cooked", "", ""},
            {"group:wool", "", ""},
            {"unilib:vessel_bottle_glass_empty", "", ""},
        },
        replacements = {
            {"unilib:food_hotpot_blueberry_cooked", unilib.fallback_empty_bucket},
            {"group:wool", "unilib:crop_cotton_harvest"},
        },
    })

end
