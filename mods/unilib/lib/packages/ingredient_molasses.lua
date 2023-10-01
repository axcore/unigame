---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_molasses = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

-- (The original main ingredient)
local c_ingredient = "unilib:crop_kohlrabi_harvest"

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_molasses.init()

    return {
        description = "Molasses",
        notes = "The original code uses kohlrabi as a basic ingredient, instead of the real-life" ..
                " ingredients of sugarcane or sugar beets. Here, we use the real-life" ..
                " ingredients, if they are available",
        depends = {"ingredient_sugar_normal", "item_stick_ordinary", "vessel_glass_empty"},
        optional = {"crop_beet_sugar", "crop_kohlrabi", "ingredient_sugar_cane", "tree_apple"},
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
        },
    }

end

function unilib.pkg.ingredient_molasses.exec()

    if unilib.pkg_executed_table["crop_beet_sugar"] ~= nil then
        c_ingredient = "unilib:crop_beet_sugar_harvest"
    elseif unilib.pkg_executed_table["ingredient_sugar_cane"] ~= nil then
        c_ingredient = "unilib:ingredient_sugar_cane"
    end

    unilib.register_craftitem("unilib:ingredient_molasses", "cucina_vegana:molasses", mode, {
        -- From cucina_vegana:molasses
        description = S("Molasses"),
        inventory_image = "unilib_ingredient_molasses.png",
        groups = {flammable = 1, food = 1, food_sugar = 1},
    })
    unilib.register_craft({
        -- From cucina_vegana:molasses
        type = "cooking",
        -- N.B. Original code's output is "bushes:sugar"
        output = "unilib:ingredient_sugar_normal",
        recipe = "unilib:ingredient_molasses",
        replacements = {
            {"unilib:ingredient_molasses", "unilib:vessel_glass_empty"},
        },
        cooktime = 14,
    })
    unilib.register_craft({
        -- From cucina_vegana:molasses
        type = "fuel",
        recipe = "unilib:ingredient_molasses",
        burntime = 10,
    })
    if unilib.technic_extra_flag then

        technic.register_compressor_recipe({
            -- From cucina_vegana:molasses
            output = "unilib:ingredient_molasses",
            input = {c_ingredient .. " 6"},
        })

        if unilib.pkg_executed_table["tree_apple"] ~= nil then

            technic.register_separating_recipe({
                -- From cucina_vegana:molasses
                output = {"unilib:ingredient_molasses", "unilib:tree_apple_leaves", nil},
                input = {c_ingredient .. " 4"},
            })

        end

        technic.register_extractor_recipe({
            -- From cucina_vegana:molasses
            output = "unilib:ingredient_molasses",
            input = {c_ingredient .. " 3"},
        })

        technic.register_extractor_recipe({
            -- From cucina_vegana:molasses
            -- N.B. Original code's output is "bushes:sugar 2"
            output = "unilib:ingredient_sugar_normal 2",
            input = {"unilib:ingredient_molasses"},
        })

    end

end

function unilib.pkg.ingredient_molasses.post()

    local c_stick = "unilib:item_stick_ordinary"

    local replace_list = unilib.clone_simple_table(unilib.potable_bucket_list)
    table.insert(replace_list, {c_stick, c_stick})

    unilib.register_craft({
        -- From cucina_vegana:molasses
        output = "unilib:ingredient_molasses",
        recipe = {
            {"", c_stick, ""},
            {c_ingredient, "unilib:vessel_glass_empty", c_ingredient},
            {"", "group:potable_bucket", ""},
        },
        replacements = replace_list,
    })

end
