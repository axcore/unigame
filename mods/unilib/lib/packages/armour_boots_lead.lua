---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_boots_lead = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_boots_lead.init()

    return {
        description = "Lead boots",
        depends = "metal_lead",
    }

end

function unilib.pkg.armour_boots_lead.exec()

    unilib.register_armour("unilib:armour_boots_lead", "technic_armor:boots_lead", mode, {
        -- From technic_armor:boots_lead
        description = S("Lead Boots"),
        inventory_image = "unilib_armour_boots_lead_inv.png",
        groups = {armour_feet = 6, armour_heal = 0, armour_radiation = 8, armour_use = 500},
    })
    unilib.register_craft_boots({
        -- From technic_armor:boots_lead
        part_name = "lead",
        ingredient = "unilib:metal_lead_ingot",
    })

end
