---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.clothing_hood_pumpkin = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clothing_hood_pumpkin.init()

    return {
        description = "Pumpkin hood",
        notes = "Dropped by the Mr Pumpkin mob",
        depends = "shared_petz_clothing",
    }

end

function unilib.pkg.clothing_hood_pumpkin.exec()

    unilib.register_armour("unilib:clothing_hood_pumpkin", "petz:pumpkin_hood", mode, {
        -- From petz:pumpkin_hood
        description = S("Pumpkin Hood"),
        inventory_image = "unilib_clothing_hood_pumpkin_inv.png",
        groups = {armour_head = 1, armour_use = 200, flammable = 0},

        armour_groups = {fleshy = 10, radiation = 10},
        damage_groups = {choppy = 3, cracky = 3, crumbly = 3, level = 1, snappy = 3},
        preview = "unilib_clothing_hood_pumpkin_preview.png",
        reciprocate_damage = true,
        texture = "unilib_clothing_hood_pumpkin.png",

        on_destroy = function(player, index, stack)
            unilib.pkg.shared_petz_clothing.destroy_callback(player)
        end,
    })

end
