---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/chestnuttree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.food_chestnut = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.chestnuttree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_chestnut.init()

    return {
        description = "Chestnut",
        depends = "tree_chestnut",
    }

end

function unilib.pkg.food_chestnut.exec()

    unilib.register_craftitem("unilib:food_chestnut", "chestnuttree:fruit", mode, {
        -- From chestnuttree:fruit
        description = S("Chestnut"),
        inventory_image = "unilib_food_chestnut.png",
        -- N.B. no food_chestnut in original code
        groups = {flammable = 2, food = 2, food_chestnut = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_chestnut", 2),
    })
    unilib.register_craft({
        -- From chestnuttree:fruit
        output = "unilib:food_chestnut",
        recipe = {
            {"unilib:tree_chestnut_bur"},
        },
    })

end
