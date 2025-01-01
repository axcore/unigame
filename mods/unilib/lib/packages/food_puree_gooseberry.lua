---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_puree_gooseberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_puree_gooseberry.init()

    return {
        description = "Gooseberry purée",
        depends = {"bush_ornamental_gooseberry", "utensil_mortar_pestle"},
    }

end

function unilib.pkg.food_puree_gooseberry.exec()

    local berry_name = "unilib:fruit_gooseberry_picked"

    unilib.register_craftitem("unilib:food_puree_gooseberry", nil, mode, {
        -- Original to unilib, based on the blueberry puree from cucina_vegana
        description = S("Gooseberry Purée"),
        inventory_image = "unilib_food_puree_gooseberry.png",
        groups = {food = 1, food_berry = 1, food_gooseberry = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_puree_gooseberry", 4)
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:food_puree_gooseberry",
        recipe = {
            {berry_name, berry_name, berry_name},
            {berry_name, berry_name, berry_name},
            {"", "unilib:utensil_mortar_pestle", ""},
        },
        replacements = {
            {"unilib:utensil_mortar_pestle", "unilib:utensil_mortar_pestle"},
        },
    })

    if unilib.setting.technic_extra_flag then

        technic.register_compressor_recipe({
            -- Original to unilib
            output = "unilib:food_puree_gooseberry",
            input = {berry_name .. " 6"},
        })

    end

end
