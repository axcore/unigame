---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_grille_wood = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_grille_wood.init()

    return {
        description = "Wooden grille",
        depends = "misc_bars_wood",
    }

end

function unilib.pkg.misc_grille_wood.exec()

    unilib.register_node("unilib:misc_grille_wood", "darkage:wood_grille", mode, {
        -- From darkage:wood_grille
        description = S("Wooden Grille"),
        tiles = {"unilib_misc_grille_wood.png"},
        groups = {choppy = 2, snappy = 1},
        -- (In original code, unilib.global.sound_table.stone)
        sounds = unilib.global.sound_table.wood,

        drawtype = "glasslike",
        inventory_image = "unilib_misc_grille_wood.png",
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = true,
        wield_image = "unilib_misc_grille_wood.png",
    })
    unilib.register_craft({
        -- From darkage:wood_grille
        output = "darkage:wood_grille 3",
        recipe = {
            {"", "unilib:misc_bars_wood", ""},
            {"unilib:misc_bars_wood", "", "unilib:misc_bars_wood"},
            {"", "unilib:misc_bars_wood", ""},
        },
    })

end
