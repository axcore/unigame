---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.food_shoots_cabbage = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_shoots_cabbage.init()

    return {
        description = "Cooked cabbage tree shoots",
        depends = "tree_cabbage",
    }

end

function unilib.pkg.food_shoots_cabbage.exec()

    unilib.register_craftitem(
        -- From aotearoa:cooked_cabbage_tree_shoots
        "unilib:food_shoots_cabbage_cooked",
        "aotearoa:cooked_cabbage_tree_shoots",
        mode,
        {
            description = S("Cooked Cabbage Tree Shoots"),
            inventory_image = "unilib_food_shoots_cabbage_cooked.png",
            -- N.B. No groups in original code
            groups = {food_shoots = 1},

            on_use = unilib.cuisine_eat_on_use("unilib:food_shoots_cabbage_cooked", 1),
        }
    )
    unilib.register_craft({
        -- From aotearoa:cooked_cabbage_tree_shoots
        type = "cooking",
        output = "unilib:food_shoots_cabbage_cooked",
        recipe = "unilib:tree_cabbage_crown",
    })

end
