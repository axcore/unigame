---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    vallee_des_roses
-- Code:    Unlicense
-- Media:   Unlicense
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_marigold_small = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.vallee_des_roses.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_marigold_small.init()

    return {
        description = "Small marigold",
    }

end

function unilib.pkg.flower_marigold_small.exec()

    unilib.register_node("unilib:flower_marigold_small", "vallee_des_roses:marigold", mode, {
        -- From vallee_des_roses:marigold
        description = unilib.annotate(S("Small Marigold"), "Tagetes"),
        tiles = {"unilib_flower_marigold_small.png"},
        -- N.B. Replaced original groups with standard flower groups
--      groups = {oddly_breakable_by_hand = 3, snappy = 3},
        groups = {
            attached_node = 1, color_orange = 1, flammable = 1, flora = 1, flower = 1,
            snappy = 3,
        },
        -- N.B. No sounds in original code
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        -- N.B. inventory_image not in original code
        inventory_image = "unilib_flower_marigold_small.png",
        -- N.B. Not in original code
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
        },
        walkable = false,
    })
    unilib.register_flower_in_pot("unilib:flower_marigold_small", "vallee_des_roses:marigold")

    unilib.register_decoration("vallee_des_roses_flower_marigold_small", {
        -- From vallee_des_roses:marigold
        deco_type = "simple",
        decoration = "unilib:flower_marigold_small",

        -- N.B. 0.07 in original code
        fill_ratio = 0.01,
        sidelen = 16,
    })

end
