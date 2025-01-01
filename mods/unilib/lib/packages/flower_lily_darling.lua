---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_lily_darling = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_lily_darling.init()

    return {
        description = "Darling lily",
    }

end

function unilib.pkg.flower_lily_darling.exec()

    unilib.register_node("unilib:flower_lily_darling", "australia:darling_lily", mode, {
        -- From australia:darling_lily
        description = unilib.utils.annotate(S("Darling Lily"), "Crinum flaccidum"),
        tiles = {"unilib_flower_lily_darling.png"},
        -- N.B. Replaced original groups with standard flower groups
--      groups = {attached_node = 1, flammable = 2, flora = 1, snappy = 3},
        groups = {
            attached_node = 1, color_grey_dark = 1, colour_grey_dark = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = false,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_lily_darling.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        sunlight_propagates = true,
        visual_scale = 1.0,
        walkable = false,
        waving = 1,
        wield_image = "unilib_flower_lily_darling.png",
    })
    unilib.register_flower_in_pot("unilib:flower_lily_darling", "australia:darling_lily")

    unilib.register_decoration_generic("australia_flower_lily_darling", {
        -- From australia:darling_lily
        deco_type = "simple",
        decoration = "unilib:flower_lily_darling",

        fill_ratio = 0.02,
        sidelen = 80,
    })

end
