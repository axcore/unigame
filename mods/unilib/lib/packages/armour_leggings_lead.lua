---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_leggings_lead = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_leggings_lead.init()

    return {
        description = "Lead leggings",
        depends = "metal_lead",
    }

end

function unilib.pkg.armour_leggings_lead.exec()

    unilib.register_armour("unilib:armour_leggings_lead", "technic_armor:leggings_lead", mode, {
        -- From technic_armor:leggings_lead
        description = S("Lead Leggings"),
        inventory_image = "unilib_armour_leggings_lead_inv.png",
        groups = {armour_heal = 0, armour_legs = 11, armour_radiation = 13, armour_use = 500},
    })
    unilib.register_craft_leggings({
        -- From technic_armor:leggings_lead
        part_name = "lead",
        ingredient = "unilib:metal_lead_ingot",
    })

end
