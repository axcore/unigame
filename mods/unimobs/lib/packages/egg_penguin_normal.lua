---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.egg_penguin_normal = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.egg_penguin_normal.init()

    return {
        description = "Normal penguin egg",
    }

end

function unilib.pkg.egg_penguin_normal.exec()

    --[[
    unilib.register_craftitem("unilib:egg_penguin_normal", "petz:penguin_egg", mode, {
        -- From petz:penguin_egg
        description = S("Normal Penguin Egg"),
        inventory_image = "unilib_egg_penguin_normal.png",
        groups = {flammable = 2, food = 2, food_egg = 1},

        -- N.B. No .stack_max in original code; added for consistency with chicken/duck eggs
        stack_max = unimobs.petz_setting.egg_stack_size,
        wield_image = "unilib_egg_penguin_normal.png",

        on_use = unilib.cuisine.eat_on_use("unilib:egg_penguin_normal", 1),
    })
    ]]--
    unimobs.petz_api.register_egg_entity({
        -- From petz:penguin_egg
        mob_type = "penguin_normal",
        orig_name = "petz:penguin_egg",

        replace_mode = mode,
        baby_name = "unilib:mob_penguin_normal",
        description = S("Normal Penguin Egg"),
        satiation = 1,
        scale_factor = 0.25,
    })

end
