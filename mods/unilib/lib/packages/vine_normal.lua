---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.vine_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vine_normal.init()

    return {
        description = "Normal vine",
    }

end

function unilib.pkg.vine_normal.exec()

    unilib.register_node("unilib:vine_normal", "ethereal:vine", mode, {
        -- From unilib:vine_normal
        description = S("Normal Vine"),
        tiles = {"unilib_vine_normal.png"},
        groups = {choppy = 3, flammable = 2, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.leaves,

        climbable = true,
        drawtype = "signlike",
        inventory_image = "unilib_vine_normal.png",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "wallmounted"
        },
        walkable = false,
        wield_image = "unilib_vine_normal.png",
    })
    unilib.register_craft({
        -- From unilib:vine_normal
        output = "unilib:vine_normal 2",
        recipe = {
            {"group:leaves", "", "group:leaves"},
            {"", "group:leaves", ""},
            {"group:leaves", "", "group:leaves"},
        },
    })

end
