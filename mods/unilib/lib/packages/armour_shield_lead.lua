---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_lead = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_lead.init()

    return {
        description = "Lead shield",
        depends = "metal_lead",
    }

end

function unilib.pkg.armour_shield_lead.exec()

    unilib.register_armour("unilib:armour_shield_lead", "technic_armor:shield_lead", mode, {
        -- From technic_armor:shield_lead
        description = S("Lead Shield"),
        inventory_image = "unilib_armour_shield_lead_inv.png",
        groups = {armour_heal = 0, armour_radiation = 0, armour_shield = 8, armour_use = 500},
    })
    unilib.register_craft_shield({
        -- From technic_armor:shield_lead
        part_name = "lead",
        ingredient = "unilib:metal_lead_ingot",
    })

end
