---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    vallee_des_roses
-- Code:    Unlicense
-- Media:   Unlicense
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_buttercup_small = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.vallee_des_roses.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_buttercup_small.init()

    return {
        description = "Small buttercup",
    }

end

function unilib.pkg.flower_buttercup_small.exec()

    unilib.register_node("unilib:flower_buttercup_small", "vallee_des_roses:buttercup", mode, {
        -- From vallee_des_roses:buttercup
        description = unilib.annotate(S("Small Buttercup"), "Ranunculus"),
        tiles = {"unilib_flower_buttercup_small.png"},
        -- N.B. Replaced original groups with standard flower groups
        groups = {
            attached_node = 1, color_yellow = 1, flammable = 1, flora = 1, flower = 1, snappy = 3,
        },
        -- N.B. No sounds in original code
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        -- N.B. Not in original code
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
        },
        walkable = false,
    })
    unilib.register_flower_in_pot("unilib:flower_buttercup_small", "vallee_des_roses:buttercup")

    unilib.register_decoration("vallee_des_roses_flower_buttercup_small", {
        -- From vallee_des_roses:buttercup
        deco_type = "simple",
        decoration = "unilib:flower_buttercup_small",

        -- N.B. 0.06 in original code
        fill_ratio = 0.01,
        sidelen = 16,
    })

end
