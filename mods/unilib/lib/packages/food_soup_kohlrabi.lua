---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_soup_kohlrabi = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_soup_kohlrabi.init()

    return {
        description = "Kohlrabi soup",
        depends = {
            "crop_kohlrabi",
            "crop_parsley_curly",
            "utensil_plate_ceramic",
            "vessel_bottle_glass_empty",
        },
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
            "ingredient_oil_sunflower",         -- group:food_oil
        },
    }

end

function unilib.pkg.food_soup_kohlrabi.exec()

    unilib.register_node("unilib:food_soup_kohlrabi_raw", "cucina_vegana:kohlrabi_soup", mode, {
        -- From cucina_vegana:kohlrabi_soup
        description = S("Uncooked Kohlrabi Soup"),
        tiles = {"unilib_food_soup_kohlrabi_raw.png"},
        groups = {attached_node = 1, dig_immediate = 3, food_soup = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_food_soup_kohlrabi_raw.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_food_soup_kohlrabi_raw.png",
    })

    unilib.register_node(
        -- From cucina_vegana:kohlrabi_soup_cooked
        "unilib:food_soup_kohlrabi_cooked",
        "cucina_vegana:kohlrabi_soup_cooked",
        mode,
        {
            description = S("Cooked Kohlrabi Soup"),
            tiles = {"unilib_food_soup_kohlrabi_cooked.png"},
            groups = {attached_node = 1, dig_immediate = 3, eatable = 1},
            sounds = unilib.sound_table.glass,

            drawtype = "plantlike",
            inventory_image = "unilib_food_soup_kohlrabi_cooked.png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
            },
            walkable = false,
            wield_image = "unilib_food_soup_kohlrabi_cooked.png",

            on_use = unilib.cuisine_eat_on_use(
                "unilib:food_soup_kohlrabi_cooked", 5, "unilib:utensil_plate_ceramic"
            ),
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:kohlrabi_soup_cooked
        type = "cooking",
        output = "unilib:food_soup_kohlrabi_cooked",
        recipe = "unilib:food_soup_kohlrabi_raw",
        cooktime = 15,
    })

end

function unilib.pkg.food_soup_kohlrabi.post()

    local c_kohlrabi = "unilib:crop_kohlrabi_harvest"
    local c_parsley = "unilib:crop_parsley_curly_harvest"

    local replace_list = unilib.clone_simple_table(unilib.potable_bucket_list)
    table.insert(replace_list, {"group:food_oil", "unilib:vessel_bottle_glass_empty"})

    unilib.register_craft({
        -- From cucina_vegana:kohlrabi_soup
        output = "unilib:food_soup_kohlrabi_raw",
        recipe = {
            {c_kohlrabi, "group:food_oil", c_parsley},
            {"", "group:potable_bucket", ""},
            {"", "unilib:utensil_plate_ceramic", ""},
        },
        replacements = replace_list,
    })

end
