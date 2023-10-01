---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_hotpot_blueberry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_hotpot_blueberry.init()

    return {
        description = "Blueberry hotpot",
        depends = {"food_puree_blueberry", "item_stick_ordinary"},
        optional = {"ingredient_molasses", "vessel_glass_empty"},
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.food_hotpot_blueberry.exec()

    unilib.register_craftitem(
        -- From cucina_vegana:blueberry_pot
        "unilib:food_hotpot_blueberry_raw",
        "cucina_vegana:blueberry_pot",
        mode,
        {
            description = S("Uncooked Blueberry Hotpot"),
            inventory_image = "unilib_food_hotpot_blueberry_raw.png",
            -- N.B. sud = 1 in original code
            groups = {food_hotpot = 1},
        }
    )

    unilib.register_craftitem(
        -- From cucina_vegana:blueberry_pot_cooked
        "unilib:food_hotpot_blueberry_cooked",
        "cucina_vegana:blueberry_pot_cooked",
        mode,
        {
            description = S("Cooked Blueberry Hotpot"),
            inventory_image = "unilib_food_hotpot_blueberry_cooked.png",
            -- N.B. sud = 1 in original code
            groups = {food_hotpot = 1},
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:blueberry_pot_cooked
        type = "cooking",
        output = "unilib:food_hotpot_blueberry_cooked",
        recipe = "unilib:food_hotpot_blueberry_raw",
        cooktime = 25,
    })

end

function unilib.pkg.food_hotpot_blueberry.post()

    local c_puree = "unilib:food_puree_blueberry"
    local c_stick = "unilib:item_stick_ordinary"
    local c_molasses = "unilib:ingredient_molasses"

    local replace_list = unilib.clone_simple_table(unilib.potable_bucket_list)
    table.insert(replace_list, {c_stick, c_stick})

    unilib.register_craft({
        -- From cucina_vegana:blueberry_pot
        output = "unilib:food_hotpot_blueberry_raw",
        recipe = {
            {"group:food_sugar", c_stick, "group:food_sugar"},
            {c_puree, c_puree, c_puree},
            {"", "group:potable_bucket", ""}
        },
        replacements = replace_list,
    })

    if unilib.pkg_executed_table["ingredient_molasses"] ~= nil and
            unilib.pkg_executed_table["vessel_glass_empty"] ~= nil then

        replace_list = unilib.clone_simple_table(unilib.potable_bucket_list)
        table.insert(replace_list, {c_stick, c_stick})
        table.insert(replace_list, {c_molasses, "unilib:vessel_glass_empty 2"})

        unilib.register_craft({
            -- From cucina_vegana:blueberry_pot
            output = "unilib:food_hotpot_blueberry_raw",
            recipe = {
                {c_molasses, c_stick, c_molasses},
                {c_puree, c_puree, c_puree},
                {"", "group:potable_bucket", ""}
            },
            replacements = replace_list,
        })

    end

end
