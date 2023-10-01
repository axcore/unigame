---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    vallee_des_roses
-- Code:    Unlicense
-- Media:   Unlicense
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_hyacinth = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.vallee_des_roses.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_hyacinth.init()

    return {
        description = "Hyacinth",
    }

end

function unilib.pkg.flower_hyacinth.exec()

    unilib.register_node("unilib:flower_hyacinth", "vallee_des_roses:hyacinth", mode, {
        -- From vallee_des_roses:hyacinth
        description = unilib.annotate(S("Hyacinth"), "Hyacinthus"),
        tiles = {"unilib_flower_hyacinth.png"},
        -- N.B. Changed groups to resemble those used in minetest_game/flowers
--      groups = {oddly_breakable_by_hand = 3, snappy = 3},
        groups = {
            attached_node = 1, color_violet = 1, flammable = 1, flora = 1, flower = 1, snappy = 3,
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
    unilib.register_flower_in_pot("unilib:flower_hyacinth", "vallee_des_roses:hyacinth")

    unilib.register_decoration("vallee_des_roses_flower_hyacinth", {
        -- From vallee_des_roses:hyacinth
        deco_type = "simple",
        decoration = "unilib:flower_hyacinth",

        -- N.B. 0.1 in original code
        fill_ratio = 0.01,
        sidelen = 16,
    })

end
