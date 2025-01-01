---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.food_root_bracken = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_root_bracken.init()

    return {
        description = "Cooked bracken root",
        depends = "plant_bracken",
    }

end

function unilib.pkg.food_root_bracken.exec()

    unilib.register_craftitem(
        -- From aotearoa:cooked_bracken_root
        "unilib:food_root_bracken_cooked",
        "aotearoa:cooked_bracken_root",
        mode,
        {
            description = S("Cooked Bracken Root"),
            inventory_image = "unilib_food_root_bracken_cooked.png",
            -- N.B. No groups in original code
            groups = {food_roots = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:food_root_bracken_cooked", 2),
        }
    )
    unilib.register_craft({
        -- From aotearoa:cooked_bracken_root
        type = "cooking",
        output = "unilib:food_root_bracken_cooked",
        recipe = "unilib:plant_bracken",
    })

end
