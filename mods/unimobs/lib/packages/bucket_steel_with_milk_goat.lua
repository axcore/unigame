---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bucket_steel_with_milk_goat = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bucket_steel_with_milk_goat.init()

    return {
        description = "Bucket of goat milk",
        depends = "bucket_steel",
    }

end

function unilib.pkg.bucket_steel_with_milk_goat.exec()

    unilib.register_craftitem("unilib:bucket_steel_with_milk_goat", nil, mode, {
        -- Original to unimobs
        description = S("Bucket of Goat Milk"),
        inventory_image = "unilib_bucket_steel_empty.png^unilib_bucket_milk_goat_overlay.png",
        groups = {food = 3, food_milk = 1, milk_bucket = 1},

        stack_max = 1,
        wield_image = "unilib_bucket_steel_empty.png^unilib_bucket_milk_goat_overlay.png",

        on_use = unilib.cuisine.eat_on_use(
            "unilib:bucket_steel_with_milk_goat", 3, "unilib:bucket_steel_empty"
        ),
    })

end
