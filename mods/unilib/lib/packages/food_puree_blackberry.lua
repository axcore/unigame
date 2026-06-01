---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_puree_blackberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_puree_blackberry.init()

    return {
        description = "Blackberry purée",
        depends = "utensil_mortar_pestle",
        at_least_one = {"bush_ornamental_blackberry", "produce_blackberry"},
    }

end

function unilib.pkg.food_puree_blackberry.exec()

    unilib.register_craftitem("unilib:food_puree_blackberry", nil, mode, {
        -- Original to unilib, based on the blueberry puree from cucina_vegana
        description = S("Blackberry Purée"),
        inventory_image = "unilib_food_puree_blackberry.png",
        groups = {food = 1, food_berry = 1, food_blackberry = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_puree_blackberry", 4)
    })

    local berry_list = {}
    if unilib.global.pkg_executed_table["bush_ornamental_blackberry"] ~= nil then
        table.insert(berry_list, "unilib:fruit_blackberry_picked")
    end
    if unilib.global.pkg_executed_table["produce_blackberry"] ~= nil then
        table.insert(berry_list, "unilib:produce_blackberry_harvest")
    end

    for _, berry_name in ipairs(berry_list) do

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:food_puree_blackberry",
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
                output = "unilib:food_puree_blackberry",
                input = {berry_name .. " 6"},
            })

        end

    end

end
