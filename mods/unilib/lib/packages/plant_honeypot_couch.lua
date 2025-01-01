---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_honeypot_couch = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_honeypot_couch.init()

    return {
        description = "Couch honeypot",
    }

end

function unilib.pkg.plant_honeypot_couch.exec()

    unilib.register_node("unilib:plant_honeypot_couch", "australia:couch_honeypot", mode, {
        -- From australia:couch_honeypot
        description = unilib.utils.annotate(S("Couch Honeypot"), "Banksia dallanneyi"),
        tiles = {"unilib_plant_honeypot_couch.png"},
        groups = {attached_node = 1, flammable = 2, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = false,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_honeypot_couch.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        sunlight_propagates = true,
        visual_scale = 1.0,
        walkable = false,
        waving = 0,
        wield_image = "unilib_plant_honeypot_couch.png",
    })
    unilib.register_plant_in_pot("unilib:plant_honeypot_couch", "australia:couch_honeypot")

    unilib.register_decoration_generic("australia_plant_honeypot_couch", {
        -- From australia:couch_honeypot
        deco_type = "simple",
        decoration = "unilib:plant_honeypot_couch",

        fill_ratio = 0.02,
        sidelen = 80,
    })

end
