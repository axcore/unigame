---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.vine_underground = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vine_underground.init()

    return {
        description = "Underground vine",
    }

end

function unilib.pkg.vine_underground.exec()

    local img = "unilib_vine_underground.png"

    unilib.register_node("unilib:vine_underground", "underch:underground_vine", mode, {
        -- From underch:underground_vine
        description = S("Underground Vine"),
        tiles = {img},
        groups = {choppy = 3, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.leaves,

        climbable = true,
        drawtype = "signlike",
        inventory_image = img,
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "wallmounted",
        },
        walkable = false,
        wield_image = img,
    })
    unilib.register_craft({
        -- From underch:underground_vine
        type = "fuel",
        recipe = "unilib:vine_underground",
        burntime = 4,
    })

end
