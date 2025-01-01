---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.food_root_raupo = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_root_raupo.init()

    return {
        description = "Cooked raupo root",
        depends = "plant_raupo",
    }

end

function unilib.pkg.food_root_raupo.exec()

    unilib.register_craftitem("unilib:food_root_raupo_cooked", "aotearoa:cooked_raupo_root", mode, {
        -- From aotearoa:cooked_raupo_root
        description = S("Cooked Raupo Root"),
        inventory_image = "unilib_food_root_raupo_cooked.png",
        -- N.B. No groups in original code
        groups = {food_roots = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_root_raupo_cooked", 1),
    })
    unilib.register_craft({
        -- From aotearoa:cooked_raupo_root
        type = "cooking",
        output = "unilib:food_root_raupo_cooked",
        recipe = "unilib:plant_raupo",
    })

end
