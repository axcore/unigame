---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.egg_duck_normal = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.egg_duck_normal.init()

    return {
        description = "Normal duck egg",
    }

end

function unilib.pkg.egg_duck_normal.exec()

    unilib.register_craftitem("unilib:egg_duck_normal", "petz:ducky_egg", mode, {
        -- From petz:ducky_egg
        description = S("Normal Duck Egg"),
        inventory_image = "unilib_egg_duck_normal.png",
        groups = {flammable = 2, food = 2, food_egg = 1},

        -- N.B. Max stack size of 64 in original code
        stack_max = unimobs.petz_setting.egg_stack_size,
        wield_image = "unilib_egg_duck_normal.png",

        on_use = unilib.cuisine.eat_on_use("unilib:egg_duck_normal", 2),
    })

end
