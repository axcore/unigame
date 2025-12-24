---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bucket_steel_with_milk_camel = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bucket_steel_with_milk_camel.init()

    return {
        description = "Bucket of camel milk",
        depends = "bucket_steel",
    }

end

function unilib.pkg.bucket_steel_with_milk_camel.exec()

    unilib.register_craftitem("unilib:bucket_steel_with_milk_camel", nil, mode, {
        -- Original to unimobs
        description = S("Bucket of Camel Milk"),
        inventory_image = "unilib_bucket_steel_empty.png^unilib_bucket_milk_camel_overlay.png",
        -- N.B. Note that camel milk doesn't have the "food_milk = 1, milk_bucket = 1" groups, so
        --      that it can't be used to make ordinary dairy products (as cow/goat milk can)
        groups = {camel_milk_bucket = 1, food = 3, food_camel_milk = 1},

        stack_max = 1,
        wield_image = "unilib_bucket_steel_empty.png^unilib_bucket_milk_camel_overlay.png",

        -- N.B. To compensate for camel milk being used in fewer craft recipes, we'll increase its
        --      nutrition from 3 to 5
        on_use = unilib.cuisine.eat_on_use(
            "unilib:bucket_steel_with_milk_camel", 5, "unilib:bucket_steel_empty"
        ),
    })

end
