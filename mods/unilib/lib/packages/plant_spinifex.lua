---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_spinifex = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_spinifex.init()

    return {
        description = "Spinifex",
    }

end

function unilib.pkg.plant_spinifex.exec()

    unilib.register_node("unilib:plant_spinifex", "australia:spinifex", mode, {
        -- From australia:spinifex
        description = unilib.annotate(S("Spinifex"), "Triodia longiceps"),
        tiles = {"unilib_plant_spinifex.png"},
        groups = {attached_node = 1, flammable = 2, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = false,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_spinifex.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        sunlight_propagates = true,
        visual_scale = 1.2,
        walkable = false,
        waving = 0,
        wield_image = "unilib_plant_spinifex.png",
    })
    unilib.register_plant_in_pot("unilib:plant_spinifex", "australia:spinifex")

    unilib.register_decoration("australia_plant_spinifex_1", {
        -- From australia:spinifex
        deco_type = "simple",
        decoration = "unilib:plant_spinifex",

        fill_ratio = 0.05,
        sidelen = 80,
    })
    unilib.register_decoration("australia_plant_spinifex_3", {
        -- From australia:spinifex
        deco_type = "simple",
        decoration = "unilib:plant_spinifex",

        fill_ratio = 0.02,
        sidelen = 80,
    })

end
