---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_starch_rice = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_starch_rice.init()

    return {
        description = "Rice starch",
        depends = {"crop_cotton", "crop_rice_brown", "wool_basic"},
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
        },
    }

end

function unilib.pkg.ingredient_starch_rice.exec()

    unilib.register_craftitem("unilib:ingredient_starch_rice", "cucina_vegana:rice_starch", mode, {
        -- From cucina_vegana:rice_starch
        description = S("Rice Starch"),
        inventory_image = "unilib_ingredient_starch_rice.png",
        groups = {food_starch = 1, food_vegan = 1},
    })

end

function unilib.pkg.ingredient_starch_rice.post()

    local c_rice = "unilib:crop_rice_brown_harvest"
    local c_wool = "unilib:wool_white"

    local replace_list = unilib.clone_simple_table(unilib.potable_bucket_list)
    table.insert(replace_list, {c_wool, "unilib:crop_cotton_harvest 2"})

    unilib.register_craft({
        -- From cucina_vegana:rice_starch
        output = "unilib:ingredient_starch_rice 2",
        recipe = {
            {c_wool, c_rice, c_wool},
            {c_wool, c_rice, c_wool},
            {"", "group:potable_bucket", ""},
        },
        replacements = replace_list,
    })

end
