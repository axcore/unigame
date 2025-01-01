---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_armor
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_leggings_tritonium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_leggings_tritonium.init()

    return {
        description = "Tritonium leggings",
        depends = "metal_tritonium",
    }

end

function unilib.pkg.armour_leggings_tritonium.exec()

    unilib.register_armour(
        -- From xtraores_armor:leggings_titanium
        "unilib:armour_leggings_tritonium",
        "xtraores_armor:leggings_titanium",
        mode,
        {
            description = S("Tritonium Leggings"),
            inventory_image = "unilib_armour_leggings_tritonium_inv.png",
            groups = {
                armour_fire = 1, armour_heal = 14, armour_legs = 22.6, armour_use = 20,
                physics_gravity = -0.18, physics_jump = 0.16, physics_speed = 0.25,
            },

            wear = 0,
        }
    )
    unilib.register_craft_leggings({
        -- From xtraores_armor:leggings_titanium
        part_name = "tritonium",
        ingredient = "unilib:metal_tritonium_ingot",
    })

end
