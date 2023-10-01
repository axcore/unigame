---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_liquid_smoke = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_liquid_smoke.init()

    return {
        description = "Liquid smoke",
        notes = "This is a liquid flavouring",
        depends = {"torch_ordinary", "vessel_bottle_glass_empty"},
    }

end

function unilib.pkg.ingredient_liquid_smoke.exec()

    unilib.register_node("unilib:ingredient_liquid_smoke", "bbq:liquid_smoke", mode, {
        -- From bbq:liquid_smoke
        description = S("Liquid Smoke"),
        tiles = {"unilib_ingredient_liquid_smoke.png"},
        groups = {attached_node = 1, dig_immediate = 3, vessel = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_liquid_smoke.png",
        paramtype = "light",
        paramtype2 = "facedir",
        wield_image = "unilib_ingredient_liquid_smoke.png",
    })
    unilib.register_craft({
        -- From bbq:liquid_smoke
        type = "shapeless",
        output = "unilib:ingredient_liquid_smoke",
        recipe = {"unilib:vessel_bottle_glass_empty", "unilib:torch_ordinary"}
    })

end
