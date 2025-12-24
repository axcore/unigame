---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.clothing_crown_prince = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clothing_crown_prince.init()

    return {
        description = "Prince of the North's crown",
        depends = {"component_bobbin_silk", "metal_gold", "shared_petz_clothing"},
    }

end

function unilib.pkg.clothing_crown_prince.exec()

    local c_bobbin = "unilib:component_bobbin_silk"
    local c_ingot = "unilib:metal_gold_ingot"

    unilib.register_armour("unilib:clothing_crown_prince", "petz:prince_crown", mode, {
        -- From petz:prince_crown
        description = S("Prince of the North's Crown"),
        inventory_image = "unilib_clothing_crown_prince_inv.png",
        groups = {armour_head = 1, armour_use = 500, flammable = 0},

        armour_groups = {fleshy = 10, radiation = 10},
        damage_groups = {choppy = 3, cracky = 3, crumbly = 3, level = 1, snappy = 3},
        preview = "unilib_clothing_crown_prince_preview.png",
        reciprocate_damage = true,
        texture = "unilib_clothing_crown_prince.png",

        on_destroy = function(player, index, stack)
            unilib.pkg.shared_petz_clothing.destroy_callback(player)
        end,
    })
    unilib.register_craft({
        -- From petz:prince_crown
        type = "shaped",
        output = "unilib:clothing_crown_prince",
        recipe = {
            {c_ingot, "", c_ingot},
            {c_ingot, c_ingot, c_ingot},
            {c_bobbin, c_bobbin, c_bobbin},
        },
    })

end
