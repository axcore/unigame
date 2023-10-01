---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_saltbush = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_saltbush.init()

    return {
        description = "Saltbush",
    }

end

function unilib.pkg.plant_saltbush.exec()

    unilib.register_node("unilib:plant_saltbush", "australia:saltbush", mode, {
        -- From australia:saltbush
        description = unilib.annotate(S("Saltbush"), "Atriplex nummularia"),
        tiles = {"unilib_plant_saltbush.png"},
        groups = {attached_node = 1, flammable = 2, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = false,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_saltbush.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        sunlight_propagates = true,
        visual_scale = 1.4,
        walkable = false,
        waving = 0,
        wield_image = "aus_saltbush.png",
    })
    unilib.register_plant_in_pot("unilib:plant_saltbush", "australia:saltbush")

    unilib.register_decoration("australia_plant_saltbush", {
        -- From australia:saltbush
        deco_type = "simple",
        decoration = "unilib:plant_saltbush",

        fill_ratio = 0.01,
        sidelen = 80,
    })

end
