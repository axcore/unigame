---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tuber_honey
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_honey_tuber = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.tuber_honey.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_honey_tuber.init()

    return {
        description = "Tuber honey",
        depends = "plant_tuber_dark",
    }

end

function unilib.pkg.food_honey_tuber.exec()

    unilib.register_craftitem("unilib:food_honey_tuber", "tuber_honey:food", mode, {
        -- From tuber_honey:food
        description = S("Tuber Honey"),
        inventory_image = "unilib_food_honey_tuber.png",
        -- (no groups)

        on_use = unilib.cuisine.eat_on_use("unilib:food_honey_tuber", 3),
    })

    if unilib.setting.technic_extra_flag then

        technic.register_extractor_recipe({
            -- From tuber_honey:food
            output = "unilib:food_honey_tuber",
            input = {"unilib:plant_tuber_dark"},
        })

    end

end
