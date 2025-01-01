---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.fern_mangrove = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fern_mangrove.init()

    return {
        description = "Mangrove fern",
    }

end

function unilib.pkg.fern_mangrove.exec()

    unilib.register_node("unilib:fern_mangrove", "australia:mangrove_fern", mode, {
        -- From australia:mangrove_fern
        description = unilib.utils.annotate(S("Mangrove Fern"), "Acrostichum speciosum"),
        tiles = {"unilib_fern_mangrove.png"},
        groups = {attached_node = 1, flammable = 2, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = false,
        drawtype = "plantlike",
        inventory_image = "unilib_fern_mangrove.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        sunlight_propagates = true,
        visual_scale = 1.0,
        walkable = false,
        waving = 1,
        wield_image = "unilib_fern_mangrove.png",
    })
    unilib.register_plant_in_pot("unilib:fern_mangrove", "australia:mangrove_fern")

    unilib.register_decoration_generic("australia_fern_mangrove", {
        -- From australia:mangrove_fern
        deco_type = "simple",
        decoration = "unilib:plant_spinifex",

        fill_ratio = 0.2,
        sidelen = 80,
    })

end
