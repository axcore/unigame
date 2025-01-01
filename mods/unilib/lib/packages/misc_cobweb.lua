---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_cobweb = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_cobweb.init()

    return {
        description = "Cobweb",
        notes = "Tangles up the player",
        depends = "item_string_ordinary",
    }

end

function unilib.pkg.misc_cobweb.exec()

    unilib.register_node("unilib:misc_cobweb", "xdecor:cobweb", mode, {
        -- From xdecor:cobweb
        description = S("Cobweb"),
        tiles = {"unilib_misc_cobweb.png"},
        groups = {flammable = 3, liquid = 3, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_misc_cobweb.png",
        -- N.B. Replaced liquid properties in the original mod's code, with move_resistance = 7
--      liquidtype = "source",
--      liquid_alternative_flowing = "unilib:misc_cobweb",
--      liquid_alternative_source = "unilib:misc_cobweb",
--      liquid_range = 0,
--      liquid_renewable = false,
--      liquid_viscosity = 8,
        move_resistance = 7,
        paramtype = "light",
        selection_box = {type = "regular"},
        sunlight_propagates = true,
        walkable = false,
    })
    unilib.register_craft({
        -- From xdecor:cobweb
        output = "unilib:misc_cobweb",
        recipe = {
            {"unilib:item_string_ordinary", "", "unilib:item_string_ordinary"},
            {"", "unilib:item_string_ordinary", ""},
            {"unilib:item_string_ordinary", "", "unilib:item_string_ordinary"},
        },
    })

end
