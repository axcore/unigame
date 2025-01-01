---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_chestplate_unobtainium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_chestplate_unobtainium.init()

    return {
        description = "Unobtainium chestplate",
        depends = "metal_unobtainium",
    }

end

function unilib.pkg.armour_chestplate_unobtainium.exec()

    unilib.register_armour(
        -- From xtraores_armor:chestplate_unobtainium
        "unilib:armour_chestplate_unobtainium",
        "xtraores_armor:chestplate_unobtainium",
        mode,
        {
            description = S("Unobtainium Chestplate"),
            inventory_image = "unilib_armour_chestplate_unobtainium_inv.png",
            groups = {
                armour_fire = 1, armour_heal = 12, armour_torso = 22, armour_use = 20,
                physics_gravity = -0.15, physics_jump = 0.15, physics_speed = 0.15,
            },

            wear = 0,
        }
    )
    unilib.register_craft_chestplate({
        -- From xtraores_armor:chestplate_unobtainium
        part_name = "unobtainium",
        ingredient = "unilib:metal_unobtainium_ingot",
    })

end