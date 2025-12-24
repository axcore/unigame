---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_chicken_legs = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_chicken_legs.init()

    return {
        description = "Chicken legs",
        depends = {"bucket_steel", "food_chicken"},
    }

end

function unilib.pkg.food_chicken_legs.exec()

    unilib.register_craftitem("unilib:food_chicken_legs_raw", "petz:chicken_legs", mode, {
        -- From petz:chicken_legs
        description = S("Raw Chicken Legs"),
        inventory_image = "unilib_food_chicken_legs_raw.png",
        groups = {flammable = 2, food = 2, food_meat_raw = 1},

        wield_image = "unilib_food_chicken_legs_raw.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_chicken_legs_raw", 1),
    })
    unilib.register_craft({
        -- From petz:chicken_legs
        type = "shapeless",
        output = "unilib:food_chicken_legs_raw",
        recipe = {"unilib:food_chicken_raw"},
    })

    unilib.register_craftitem(
        -- From petz:roasted_chicken_legs
        "unilib:food_chicken_legs_roasted",
        "petz:roasted_chicken_legs",
        mode,
        {
            description = S("Roasted Chicken Legs"),
            inventory_image = "unilib_food_chicken_legs_roasted.png",
            groups = {flammable = 2, food = 2, food_meat = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:food_chicken_legs_roasted", 5),
        }
    )
    unilib.register_craft({
        -- From petz:roasted_chicken_legs
        type = "cooking",
        output = "unilib:food_chicken_legs_roasted",
        recipe = "unilib:food_chicken_legs_raw",
        cooktime = 3,
    })

    unilib.register_craftitem(
        -- From petz:chicken_legs_bucket
        "unilib:food_chicken_legs_bucket",
        "petz:chicken_legs_bucket",
        mode,
        {
            description = S("Bucket of Chicken Legs"),
            inventory_image = "unilib_food_chicken_legs_bucket.png",
            groups = {flammable = 2, food = 2, food_meat = 1},

            stack_max = 1,

            on_use = unilib.cuisine.eat_on_use(
                "unilib:food_chicken_legs_bucket", 12, "unilib:bucket_steel_empty"
            ),
        }
    )
    unilib.register_craft({
        -- From petz:chicken_legs_bucket
        type = "shapeless",
        output = "unilib:food_chicken_legs_bucket",
        recipe = {
            "unilib:food_chicken_legs_roasted",
            "unilib:food_chicken_legs_roasted",
            "unilib:food_chicken_legs_roasted",
            "unilib:bucket_steel_empty",
        },
    })
    unilib.register_craft({
        -- From petz:chicken_legs_bucket
        type = "shapeless",
        output = "unilib:food_chicken_legs_roasted 3",
        recipe = {"unilib:food_chicken_legs_bucket"},
        replacements = {
            {"unilib:food_chicken_legs_bucket", "unilib:bucket_steel_empty"}
        },
    })

end
