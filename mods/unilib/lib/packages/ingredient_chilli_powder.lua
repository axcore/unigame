---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_chilli_powder = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_chilli_powder.init()

    return {
        description = "Chilli Powder",
        at_least_one = {"crop_chilli_gorria", "produce_chilli_cayenne", "produce_chilli_normal"},
    }

end

function unilib.pkg.ingredient_chilli_powder.exec()

    unilib.register_craftitem(
        -- From better_farming:chilie_powder
        "unilib:ingredient_chilli_powder",
        "better_farming:chilie_powder",
        mode,
        {
            description = S("Chilli Powder"),
            inventory_image = "unilib_ingredient_chilli_powder.png",

            on_use = unilib.cuisine_eat_on_use("unilib:ingredient_chilli_powder", -1),
        }
    )
    if unilib.pkg_executed_table["crop_chilli_gorria"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:ingredient_chilli_powder",
            recipe = {
                {"unilib:crop_chilli_gorria_harvest"},
            },
        })

    end
    if unilib.pkg_executed_table["produce_chilli_cayenne"] ~= nil then

        unilib.register_craft({
            -- From better_farming:chilie_powder
            output = "unilib:ingredient_chilli_powder",
            recipe = {
                {"unilib:produce_chilli_cayenne_harvest"},
            },
        })

    end
    if unilib.pkg_executed_table["produce_chilli_normal"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:ingredient_chilli_powder",
            recipe = {
                {"unilib:produce_chilli_normal_harvest"},
            },
        })

    end

end
