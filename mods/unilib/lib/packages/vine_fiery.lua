---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.vine_fiery = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vine_fiery.init()

    return {
        description = "Fiery vine",
    }

end

function unilib.pkg.vine_fiery.exec()

    local img = "unilib_vine_fiery.png"

    unilib.register_node("unilib:vine_fiery", "underch:fiery_vine", mode, {
        -- From underch:fiery_vine
        description = S("Fiery Vine"),
        tiles = {img},
        groups = {choppy = 3, oddly_breakable_by_hand = 1, hot = 1},
        sounds = unilib.sound_table.leaves,

        climbable = true,
        damage_per_second = 1 * unilib.underch_damage_scaling_factor,
        drawtype = "signlike",
        inventory_image = img,
        is_ground_content = false,
        light_source = 8,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "wallmounted",
        },
        walkable = false,
        wield_image = img,
    })
    unilib.register_craft({
        -- From underch:fiery_vine
        type = "fuel",
        recipe = "unilib:vine_fiery",
        burntime = 8,
    })

end
