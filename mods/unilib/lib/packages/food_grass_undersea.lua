---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aqua_farming
-- Code:    GPL 3.0
-- Media:   CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_grass_undersea = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aqua_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_grass_undersea.init()

    return {
        description = "Edible sea grass",
        depends = "crop_undersea_grass",
    }

end

function unilib.pkg.food_grass_undersea.exec()

    unilib.register_craftitem(
        -- From aqua_farming:sea_grass_roasted_item
        "unilib:food_grass_undersea_roasted",
        "aqua_farming:sea_grass_roasted_item",
        mode,
        {
            description = S("Roasted Edible Sea Grass"),
            groups = {food = 1, food_vegan = 1},
            inventory_image = "unilib_food_grass_undersea_roasted.png",
        }
    )
    unilib.register_craft({
        -- From aqua_farming:sea_grass_roasted_item
        type = "cooking",
        output = "unilib:food_grass_undersea_roasted",
        recipe = "unilib:crop_undersea_grass_harvest",
        cooktime = 10,
    })

end
