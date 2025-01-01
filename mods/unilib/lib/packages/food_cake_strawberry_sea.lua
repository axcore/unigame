---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aqua_farming
-- Code:    GPL 3.0
-- Media:   CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cake_strawberry_sea = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aqua_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cake_strawberry_sea.init()

    return {
        description = "Sea strawberry cake",
        depends = {"crop_undersea_strawberry", "dye_basic"},
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
            "ingredient_flour_ordinary",        -- group:food_flour
        },
    }

end

function unilib.pkg.food_cake_strawberry_sea.exec()

    unilib.register_craftitem(
        -- From aqua_farming:sea_strawberry_cake
        "unilib:food_cake_strawberry_sea",
        "aqua_farming:sea_strawberry_cake",
        mode,
        {
            description = S("Sea Strawberry Cake"),
            inventory_image = "unilib_food_cake_strawberry_sea.png",
            groups = {food = 1, food_sweet = 1, food_vegan = 1},
        }
    )

    unilib.register_craftitem(
        -- From aqua_farming:sea_strawberry_cake_piece
        "unilib:food_cake_strawberry_sea_slice",
        "aqua_farming:sea_strawberry_cake_piece",
        mode,
        {
            description = S("Slice of Sea Strawberry Cake"),
            inventory_image = "unilib_food_cake_strawberry_sea_slice.png",
            groups = {food = 1, food_sweet = 1, food_vegan = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:food_cake_strawberry_sea_slice", 3),
        }
    )
    unilib.register_craft({
        -- From aqua_farming:sea_strawberry_cake_piece
        output = "unilib:food_cake_strawberry_sea_slice 8",
        recipe = {
            {"unilib:food_cake_strawberry_sea"},
        },
    })

end

function unilib.pkg.food_cake_strawberry_sea.post()

    local c_strawberry = "unilib:crop_undersea_strawberry_harvest"

    unilib.register_craft({
        -- From aqua_farming:sea_strawberry_cake
        output = "unilib:food_cake_strawberry_sea",
        recipe = {
            {c_strawberry, c_strawberry, c_strawberry},
            {"group:food_flour", "unilib:dye_pink", "group:food_flour"},
            {"", "group:potable_bucket", ""},
        },
        replacements = unilib.global.potable_bucket_list,
    })

end
