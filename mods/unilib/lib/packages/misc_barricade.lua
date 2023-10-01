---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_barricade = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_barricade.init()

    return {
        description = "Barricade",
        depends = "metal_steel",
    }

end

function unilib.pkg.misc_barricade.exec()

    unilib.register_node("unilib:misc_barricade", "xdecor:baricade", mode, {
        -- From xdecor:baricade
        description = S("Barricade"),
        tiles = {"unilib_misc_barricade.png"},
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.node,

        collision_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, 0, 0.5, 0.5, 0},
            },
        },
        damage_per_second = 4,
        drawtype = "plantlike",
        inventory_image = "unilib_misc_barricade.png",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.2, 0.5},
        },
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- From xdecor:baricade
        output = "unilib:misc_barricade",
        recipe = {
            {"group:stick", "", "group:stick"},
            {"", "unilib:metal_steel_ingot", ""},
            {"group:stick", "", "group:stick"}
        }
    })

end
