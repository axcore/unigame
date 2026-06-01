---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_puree_raspberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_puree_raspberry.init()

    return {
        description = "Raspberry purée",
        depends = "utensil_mortar_pestle",
        at_least_one = {"bush_ornamental_raspberry", "produce_raspberry"},
    }

end

function unilib.pkg.food_puree_raspberry.exec()

    unilib.register_craftitem("unilib:food_puree_raspberry", nil, mode, {
        -- Original to unilib, based on the blueberry puree from cucina_vegana
        description = S("Raspberry Purée"),
        inventory_image = "unilib_food_puree_raspberry.png",
        groups = {food = 1, food_berry = 1, food_raspberry = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_puree_raspberry", 4)
    })

    local berry_list = {}
    if unilib.global.pkg_executed_table["bush_ornamental_raspberry"] ~= nil then
        table.insert(berry_list, "unilib:fruit_raspberry_picked")
    end
    if unilib.global.pkg_executed_table["produce_raspberry"] ~= nil then
        table.insert(berry_list, "unilib:produce_raspberry_harvest")
    end

    for _, berry_name in ipairs(berry_list) do

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:food_puree_raspberry",
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
                output = "unilib:food_puree_raspberry",
                input = {berry_name .. " 6"},
            })

        end

    end

end
