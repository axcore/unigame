---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bucket_steel_with_milk_cow = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bucket_steel_with_milk_cow.init()

    return {
        description = "Bucket of cow milk",
        depends = "bucket_steel",
    }

end

function unilib.pkg.bucket_steel_with_milk_cow.exec()

    unilib.register_craftitem("unilib:bucket_steel_with_milk_cow", "petz:bucket_milk", mode, {
        -- From petz:bucket_milk
        description = S("Bucket of Cow Milk"),
        inventory_image = "unilib_bucket_steel_empty.png^unilib_bucket_milk_cow_overlay.png",
        groups = {food = 3, food_milk = 1, milk_bucket = 1},

        stack_max = 1,
        wield_image = "unilib_bucket_steel_empty.png^unilib_bucket_milk_cow_overlay.png",

        on_use = unilib.cuisine.eat_on_use(
            "unilib:bucket_steel_with_milk_cow", 3, "unilib:bucket_steel_empty"
        ),
    })

end
