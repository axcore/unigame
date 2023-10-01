---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_sushi_imitation = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_sushi_imitation.init()

    return {
        description = "Imitation sushi",
        depends = {"food_fish_imitation", "food_rice_brown", "utensil_bowl_glass"},
        optional = {"plant_kelp_ordinary", "plant_papyrus_ordinary"},
    }

end

function unilib.pkg.food_sushi_imitation.exec()

    unilib.register_craftitem("unilib:food_sushi_imitation", "cucina_vegana:vegan_sushi", mode, {
        -- From cucina_vegana:vegan_sushi
        description = S("Imitation Sushi"),
        inventory_image = "unilib_food_sushi_imitation.png",
        groups = {eatable = 1, food = 1, food_vegan = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_sushi_imitation", 4),
    })
    if unilib.pkg_executed_table["plant_papyrus_ordinary"] ~= nil then

        unilib.register_craft({
            -- From cucina_vegana:vegan_sushi
            output = "unilib:food_sushi_imitation",
            recipe = {
                {"unilib:food_fish_imitation", "unilib:food_rice_brown_raw", ""},
                {"unilib:plant_papyrus_ordinary", "", ""}
            },
            replacements = {
                {"unilib:food_rice_brown_raw", "unilib:utensil_bowl_glass"},
            },
        })

    end
    if unilib.pkg_executed_table["plant_kelp_ordinary"] ~= nil then

        unilib.register_craft({
            -- From cucina_vegana:vegan_sushi
            output = "unilib:food_sushi_imitation",
            recipe = {
                {"unilib:food_fish_imitation", "unilib:food_rice_brown_raw", ""},
                {"unilib:plant_kelp_ordinary", "", ""}
            },
        })

    end

end
