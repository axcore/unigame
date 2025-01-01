---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_planexium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_planexium.init()

    return {
        description = "Planexium shield",
        depends = {"metal_planexium", "shared_armour_shield"},
    }

end

function unilib.pkg.armour_shield_planexium.exec()

    unilib.register_armour(
        -- From xtraores_armor:shield_platinum
        "unilib:armour_shield_planexium",
        "xtraores_armor:shield_platinum",
        mode,
        {
            description = S("Planexium Shield"),
            inventory_image = "unilib_armour_shield_planexium_inv.png",
            groups = {armour_heal = 7, armour_shield = 12, armour_use = 200},

            wear = 0,

            -- N.B. .on_damage(), .on_destroy() not in original code
            on_damage = function(player, index, stack)
                unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_dig_metal")
            end,

            on_destroy = function(player, index, stack)
                unilib.pkg.shared_armour_shield.play_shield_sound(player, "unilib_dug_metal")
            end,
        }
    )
    unilib.register_craft_shield({
        -- From xtraores_armor:shield_platinum
        part_name = "planexium",
        ingredient = "unilib:metal_planexium_ingot",
    })

end
