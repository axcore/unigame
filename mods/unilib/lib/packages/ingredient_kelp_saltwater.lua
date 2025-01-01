---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_kelp_saltwater = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_kelp_saltwater.init()

    return {
        description = "Saltwater kelp",
        depends = {"plant_kelp_ordinary", "vessel_bottle_glass_empty"},
    }

end

function unilib.pkg.ingredient_kelp_saltwater.exec()

    unilib.register_craftitem(
        -- From cropocalypse:saltwater_kelp_jar
        "unilib:ingredient_kelp_saltwater",
        "cropocalypse:saltwater_kelp_jar",
        mode,
        {
            description = S("Jar of Saltwater Kelp"),
            inventory_image = "unilib_ingredient_kelp_saltwater.png",
            groups = {flammable = 1, food_saltwater_kelp_jar = 1},

            on_use = unilib.cuisine.eat_on_use(
                "unilib:ingredient_kelp_saltwater", 1, "unilib:vessel_bottle_glass_empty"
            ),
        }
    )
    unilib.register_craft({
        -- From cropocalypse:saltwater_kelp_jar
        type = "shapeless",
        output = "unilib:ingredient_kelp_saltwater",
        recipe = {
            "unilib:plant_kelp_ordinary",
            "unilib:plant_kelp_ordinary",
            "unilib:plant_kelp_ordinary",
            "unilib:vessel_bottle_glass_empty",
        },
    })

    -- Notes from cropocalypse:
    -- Multiple kelp jars, because kelp is currently not renewable
    if unilib.setting.cropocalypse_infinite_kelp_flag then

        unilib.register_craft({
            type = "shapeless",
            output = "unilib:ingredient_kelp_saltwater 3",
            recipe = {
                "unilib:ingredient_kelp_saltwater",
                "unilib:vessel_bottle_glass_empty",
                "unilib:vessel_bottle_glass_empty",
            },
        })
        unilib.register_craft({
            -- From cropocalypse:saltwater_kelp_jar
            type = "shapeless",
            output = "unilib:plant_kelp_ordinary",
            recipe = {"unilib:ingredient_kelp_saltwater"},
        })

    end

end
