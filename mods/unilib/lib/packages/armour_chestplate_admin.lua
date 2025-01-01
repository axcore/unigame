---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_admin
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_chestplate_admin = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_admin.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_chestplate_admin.init()

    return {
        description = "Admin chestplate",
    }

end

function unilib.pkg.armour_chestplate_admin.exec()

    unilib.register_armour("unilib:armour_chestplate_admin", "3d_armor:chestplate_admin", mode, {
        -- From 3d_armor:chestplate_admin
        description = S("Admin Chestplate"),
        inventory_image = "unilib_armour_chestplate_admin_inv.png",
        groups = {
            armour_heal = 100, armour_torso = 1, armour_use = 0, armour_water = 1,
            not_in_creative_inventory = 1,
        },

        armour_groups = {fleshy = 100},

        on_drop = function(itemstack, dropper, pos)
            return
        end,
    })
    if mode == "replace" then
        core.register_alias("adminchestplate", "unilib:armour_chestplate_admin")
    end

end
