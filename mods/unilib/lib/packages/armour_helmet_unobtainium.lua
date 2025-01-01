---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_helmet_unobtainium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_helmet_unobtainium.init()

    return {
        description = "Unobtainium helmet",
        depends = "metal_unobtainium",
    }

end

function unilib.pkg.armour_helmet_unobtainium.exec()

    unilib.register_armour(
        -- From xtraores_armor:helmet_unobtainium
        "unilib:armour_helmet_unobtainium",
        "xtraores_armor:helmet_unobtainium",
        mode,
        {
            description = S("Unobtainium Helmet"),
            inventory_image = "unilib_armour_helmet_unobtainium_inv.png",
            groups = {
                armour_fire = 1, armour_head = 17, armour_heal = 12, armour_use = 20,
                physics_gravity = -0.15, physics_jump = 0.15, physics_speed = 0.15,
            },

            wear = 0,
        }
    )
    unilib.register_craft_helmet({
        -- From xtraores_armor:helmet_unobtainium
        part_name = "unobtainium",
        ingredient = "unilib:metal_unobtainium_ingot",
    })

end
