---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.food_shoots_nikau = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_shoots_nikau.init()

    return {
        description = "Cooked nikau shoots",
        depends = "tree_palm_nikau",
    }

end

function unilib.pkg.food_shoots_nikau.exec()

    unilib.register_craftitem(
        -- From aotearoa:cooked_nikau_shoots
        "unilib:food_shoots_nikau_cooked",
        "aotearoa:cooked_nikau_shoots",
        mode,
        {
            description = S("Cooked Nikau Shoots"),
            inventory_image = "unilib_food_shoots_nikau_cooked.png",
            -- N.B. No groups in original code
            groups = {food_shoots = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:food_shoots_nikau_cooked", 1),
        }
    )
    unilib.register_craft({
        -- From aotearoa:cooked_nikau_shoots
        type = "cooking",
        output = "unilib:food_shoots_nikau_cooked",
        recipe = "unilib:tree_palm_nikau_trunk_skirt",
    })

end
