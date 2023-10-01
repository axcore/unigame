---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    vallee_des_roses
-- Code:    Unlicense
-- Media:   Unlicense
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_poppy_brittle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.vallee_des_roses.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_poppy_brittle.init()

    return {
        description = "Brittle poppy",
    }

end

function unilib.pkg.flower_poppy_brittle.exec()

    unilib.register_node("unilib:flower_poppy_brittle", "vallee_des_roses:brittle_poppy", mode, {
        -- From vallee_des_roses:brittle_poppy
        description = unilib.annotate(S("Brittle Poppy"), "Papaver somniferum"),
        tiles = {"unilib_flower_poppy_brittle.png"},
        -- N.B. No groups in original code
        groups = {
            attached_node = 1, color_red = 1, flammable = 1, flora = 1, flower = 1, snappy = 3,
        },
        -- N.B. No sounds in original code
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        -- N.B. Not in original code
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
        },
        walkable = false,
    })
    unilib.register_flower_in_pot("unilib:flower_poppy_brittle", "vallee_des_roses:brittle_poppy")

    unilib.register_decoration("vallee_des_roses_flower_poppy_brittle", {
        -- Original to unilib
        deco_type = "simple",
        decoration = "unilib:flower_poppy_brittle",

        -- N.B. 0.07 in original code
        fill_ratio = 0.01,
        sidelen = 16,
    })

end
