---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/shields
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_admin = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.shields.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_admin.init()

    return {
        description = "Admin shield",
        depends = "shared_armour_shield",
    }

end

function unilib.pkg.armour_shield_admin.exec()

    unilib.register_armour("unilib:armour_shield_admin", "shields:shield_admin", mode, {
        -- From shields:shield_admin
        description = S("Admin Shield"),
        inventory_image = "unilib_armour_shield_admin_inv.png",
        groups = {
            armour_heal = 100, armour_shield = 1000, armour_use = 0, not_in_creative_inventory = 1,
        },
    })
    if mode == "replace" then
        core.register_alias("adminshield", "unilib:armour_shield_admin")
    end

end
