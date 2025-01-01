---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_lily_mangrove = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_lily_mangrove.init()

    return {
        description = "Mangrove lily",
    }

end

function unilib.pkg.flower_lily_mangrove.exec()

    unilib.register_node("unilib:flower_lily_mangrove", "australia:mangrove_lily", mode, {
        -- From australia:mangrove_lily
        description = unilib.utils.annotate(S("Mangrove Lily"), "Crinum pedunculatum"),
        tiles = {"unilib_flower_lily_mangrove.png"},
        -- N.B. Replaced original groups with standard flower groups
--      groups = {attached_node = 1, flammable = 2, flora = 1, snappy = 3},
        groups = {
            attached_node = 1, color_white = 1, colour_white = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = false,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_lily_mangrove.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        sunlight_propagates = true,
        visual_scale = 1.0,
        walkable = false,
        waving = 1,
        wield_image = "unilib_flower_lily_mangrove.png",
    })
    unilib.register_flower_in_pot("unilib:flower_lily_mangrove", "australia:mangrove_lily")

    unilib.register_decoration_generic("australia_flower_lily_mangrove", {
        -- From australia:mangrove_lily
        deco_type = "simple",
        decoration = "unilib:flower_lily_mangrove",

        fill_ratio = 0.1,
        sidelen = 80,
    })

end
