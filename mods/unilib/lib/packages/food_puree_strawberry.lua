---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_puree_strawberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_puree_strawberry.init()

    return {
        description = "Strawberry purée",
        depends = "utensil_mortar_pestle",
        at_least_one = {
            "bush_ornamental_strawberry",
            "crop_strawberry_gariguette",
            "crop_undersea_strawberry",
            "produce_strawberry_normal",
        },
    }

end

function unilib.pkg.food_puree_strawberry.exec()

    unilib.register_craftitem("unilib:food_puree_strawberry", nil, mode, {
        -- Original to unilib, based on the blueberry puree from cucina_vegana
        description = S("Strawberry Purée"),
        inventory_image = "unilib_food_puree_strawberry.png",
        groups = {food = 1, food_berry = 1, food_strawberry = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_puree_strawberry", 4)
    })

    local berry_list = {}
    if unilib.global.pkg_executed_table["bush_ornamental_strawberry"] ~= nil then
        table.insert(berry_list, "unilib:fruit_strawberry_picked")
    end
    if unilib.global.pkg_executed_table["crop_strawberry_gariguette"] ~= nil then
        table.insert(berry_list, "unilib:crop_strawberry_gariguette_harvest")
    end
    if unilib.global.pkg_executed_table["crop_undersea_strawberry"] ~= nil then
        table.insert(berry_list, "unilib:crop_undersea_strawberry_harvest")
    end
    if unilib.global.pkg_executed_table["produce_strawberry_normal"] ~= nil then
        table.insert(berry_list, "unilib:produce_strawberry_normal_harvest")
    end

    for _, berry_name in ipairs(berry_list) do

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:food_puree_strawberry",
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
                output = "unilib:food_puree_strawberry",
                input = {berry_name .. " 6"},
            })

        end

    end

end
