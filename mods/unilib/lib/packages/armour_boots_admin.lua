---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_admin
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_boots_admin = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_admin.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_boots_admin.init()

    return {
        description = "Admin boots",
    }

end

function unilib.pkg.armour_boots_admin.exec()

    unilib.register_armour("unilib:armour_boots_admin", "3d_armor:boots_admin", mode, {
        -- From 3d_armor:boots_admin
        description = S("Admin Boots"),
        inventory_image = "unilib_armour_boots_admin_inv.png",
        groups = {
            armour_feet = 1, armour_heal = 100, armour_use = 0, armour_water = 1,
            not_in_creative_inventory = 1, physics_speed = 1,
        },

        armour_groups = {fleshy = 100},

        on_drop = function(itemstack, dropper, pos)
            return
        end,
    })
    if mode == "replace" then
        core.register_alias("adminboots", "unilib:armour_boots_admin")
    end

end
