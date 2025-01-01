---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_grille_iron = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_grille_iron.init()

    return {
        description = "Iron grille",
        depends = "misc_bars_iron",
    }

end

function unilib.pkg.misc_grille_iron.exec()

    unilib.register_node("unilib:misc_grille_iron", "darkage:iron_grille", mode, {
        -- From darkage:iron_grille
        description = S("Iron Grille"),
        tiles = {"unilib_misc_grille_iron.png"},
        groups = {cracky = 3},
        -- (In original code, unilib.global.sound_table.stone)
        sounds = unilib.global.sound_table.metal,

        drawtype = "glasslike",
        inventory_image = "unilib_misc_grille_iron.png",
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = true,
        wield_image = "unilib_misc_grille_iron.png",
    })
    unilib.register_craft({
        -- From darkage:iron_grille
        output = "unilib:misc_grille_iron 3",
        recipe = {
            {"", "unilib:misc_bars_iron", ""},
            {"unilib:misc_bars_iron", "", "unilib:misc_bars_iron"},
            {"", "unilib:misc_bars_iron", ""},
        },
    })

end
