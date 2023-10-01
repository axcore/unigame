---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pith_mamaku = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pith_mamaku.init()

    return {
        description = "Cooked mamaku pith",
        depends = "tree_mamaku",
    }

end

function unilib.pkg.food_pith_mamaku.exec()

    unilib.register_craftitem(
        -- From aotearoa:cooked_mamaku_pith
        "unilib:food_pith_mamaku_cooked",
        "aotearoa:cooked_mamaku_pith",
        mode,
        {
            description = S("Cooked Mamaku Pith"),
            inventory_image = "unilib_food_pith_mamaku_cooked.png",
            -- N.B. No groups in original code
            groups = {food_pith = 1},

            on_use = unilib.cuisine_eat_on_use("unilib:food_pith_mamaku_cooked", 1),
        }
    )
    unilib.register_craft({
        -- From aotearoa:cooked_mamaku_pith
        type = "cooking",
        output = "unilib:food_pith_mamaku_cooked",
        recipe = "unilib:tree_mamaku_trunk",
    })

end
