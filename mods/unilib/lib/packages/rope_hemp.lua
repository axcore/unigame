---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.rope_hemp = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.rope_hemp.init()

    return {
        description = "Hemp rope",
        depends = {"crop_cotton", "item_fibre_hemp"},
    }

end

function unilib.pkg.rope_hemp.exec()

    local c_cotton = "unilib:crop_cotton_harvest"

    unilib.register_node("unilib:rope_hemp", "farming:hemp_rope", mode, {
        -- From unilib:rope_hemp
        description = S("Hemp Rope"),
        tiles = {"unilib_rope_hemp.png"},
        groups = {choppy = 3, flammable = 2, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.leaves,

        climbable = true,
        drawtype = "plantlike",
        inventory_image = "unilib_rope_hemp.png",
        -- N.B. is_ground_content = false not in original code; added to match other ropes
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_rope_hemp.png",
    })
    unilib.register_craft({
        -- From unilib:rope_hemp
        output = "unilib:rope_hemp 6",
        recipe = {
            {"unilib:item_fibre_hemp", "unilib:item_fibre_hemp", "unilib:item_fibre_hemp"},
            {c_cotton, c_cotton, c_cotton},
            {"unilib:item_fibre_hemp", "unilib:item_fibre_hemp", "unilib:item_fibre_hemp"},
        },
    })

end
