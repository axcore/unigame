---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.clothing_boots_silk = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clothing_boots_silk.init()

    return {
        description = "Silk boots",
        depends = {"component_bobbin_silk", "dye_basic", "metal_gold", "shared_petz_clothing"},
    }

end

function unilib.pkg.clothing_boots_silk.exec()

    local c_bobbin = "unilib:component_bobbin_silk"

    unilib.register_armour("unilib:clothing_boots_silk", "petz:silk_boots", mode, {
        -- From petz:silk_boots
        description = S("Silk Boots"),
        inventory_image = "unilib_clothing_boots_silk_inv.png",
        groups = {armour_feet = 1, armour_use = 500, flammable = 0},

        armour_groups = {fleshy = 10, radiation = 10},
        damage_groups = {choppy = 3, cracky = 3, crumbly = 3, level = 1, snappy = 3},
        preview = "unilib_clothing_boots_silk_preview.png",
        reciprocate_damage = true,
        texture = "unilib_clothing_boots_silk.png",

        on_destroy = function(player, index, stack)
            unilib.pkg.shared_petz_clothing.destroy_callback(player)
        end,
    })
    unilib.register_craft({
        -- From petz:silk_boots
        type = "shaped",
        output = "unilib:clothing_boots_silk",
        recipe = {
            {c_bobbin, "", c_bobbin},
            {"unilib:metal_gold_ingot", "", "unilib:metal_gold_ingot"},
            {c_bobbin, "unilib:dye_brown", c_bobbin},
        },
    })

end
