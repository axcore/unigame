---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_tuber_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_tuber_dark.init()

    return {
        description = "Dark tuber",
    }

end

function unilib.pkg.plant_tuber_dark.exec()

    unilib.register_node("unilib:plant_tuber_dark", "underch:dark_tuber", mode, {
        -- From underch:dark_tuber
        description = S("Dark Tuber"),
        tiles = {"unilib_plant_tuber_dark.png"},
        -- N.B. food_tuber = 1 not in original code
        groups = {attached_node = 1, food_tuber = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "mesh",
        mesh = "unilib_plant_tuber_dark.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        walkable = false,

        on_use = unilib.cuisine.eat_on_use("unilib:plant_tuber_dark", 2),
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_spare("unilib:plant_tuber_dark")

end
