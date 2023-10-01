---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_sauce_soy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_sauce_soy.init()

    return {
        description = "Soy sauce",
        depends = {"utensil_juicer_normal", "vessel_bottle_glass_empty"},
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
            "ingredient_salt_normal",           -- group:food_salt
            "produce_soy_normal",               -- group:food_soy
        },
    }

end

function unilib.pkg.ingredient_sauce_soy.exec()

    unilib.register_node("unilib:ingredient_sauce_soy", "farming:soy_sauce", mode, {
        -- From farming:soy_sauce
        description = S("Soy Sauce"),
        tiles = {"unilib_ingredient_sauce_soy.png"},
        -- N.B. food_sauce = 1 not in original code
        groups = {
            attached_node = 1, dig_immediate = 3, food_sauce = 1, food_soy_sauce = 1, vessel = 1,
        },
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_sauce_soy.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
        },
        walkable = false,
        wield_image = "unilib_ingredient_sauce_soy.png",
    })

end

function unilib.pkg.ingredient_sauce_soy.post()

    local replace_list = unilib.clone_simple_table(unilib.potable_bucket_list)
    table.insert(replace_list, {"unilib:utensil_juicer_normal", "unilib:utensil_juicer_normal"})

    unilib.register_craft({
        -- From farming:soy_sauce
        output = "unilib:ingredient_sauce_soy",
        recipe = {
            {"group:food_soy", "group:food_salt", "group:food_soy"},
            {"", "unilib:utensil_juicer_normal", ""},
            {"", "group:potable_bucket", "unilib:vessel_bottle_glass_empty"},
        },
        replacements = replace_list,
    })

end
