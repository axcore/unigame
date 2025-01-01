---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_beer_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_beer_normal.init()

    return {
        description = "Glass of beer",
        depends = {"crop_wheat", "ingredient_yeast", "vessel_glass_empty"},
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
            "ingredient_sugar_normal",          -- group:food_sugar
        },
        adult_flag = true,
    }

end

function unilib.pkg.drink_beer_normal.exec()

    unilib.register_node("unilib:drink_beer_normal", "bbq:beer", mode, {
        -- From bbq:beer
        description = S("Glass of Beer"),
        tiles = {
            "unilib_drink_beer_normal_top.png",
            "unilib_drink_beer_normal_top.png^[transformFy",
            "unilib_drink_beer_normal.png",
            "unilib_drink_beer_normal.png",
            "unilib_drink_beer_normal.png",
            "unilib_drink_beer_normal.png^[transformFx",
        },
        groups = {attached_node = 1, dig_immediate = 3},
        sounds = unilib.global.sound_table.glass,

        drawtype = "nodebox",
        inventory_image = "unilib_drink_beer_normal.png",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.18, -0.5, -0.18, 0.18, 0.3, 0.18},
                {-0.3, -0.25, -0.06, -0.18, 0.18, 0.06},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        wield_image = "unilib_drink_beer_normal.png",

        on_use = unilib.cuisine.drink_on_use("unilib:drink_beer_normal", 6)
    })

end

function unilib.pkg.drink_beer_normal.post()

    unilib.register_craft({
        -- From bbq:beer
        type = "shapeless",
        output = "unilib:drink_beer_normal",
        recipe = {
            "group:potable_bucket",
            "unilib:ingredient_yeast",
            "unilib:crop_wheat_harvest",
            "group:food_sugar",
            "unilib:vessel_glass_empty",
        },
        replacements = unilib.global.potable_bucket_list,
    })

end
